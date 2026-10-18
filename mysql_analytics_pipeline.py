import mysql.connector
import pandas as pd
import polars as pl

# 1. Configuration de la connexion à la nouvelle base
config = {
    "user": "root",
    "password": "", 
    "host": "127.0.0.1",
    "database": "factures"
}

def extraire_table_sql(nom_table: str) -> list:
    """Se connecte à MySQL et extrait une table sous forme de liste de dicts."""
    connexion = mysql.connector.connect(**config)
    cursor = connexion.cursor(dictionary=True)
    cursor.execute(f"SELECT * FROM {nom_table}")
    resultat = cursor.fetchall()
    cursor.close()
    connexion.close()
    return resultat

if __name__ == "__main__":
    print("[ETL] Ingestion des données depuis MySQL...")
    # Ingestion des 3 tables nécessaires pour le calcul financier
    raw_invoices = extraire_table_sql("invoices")
    raw_items = extraire_table_sql("invoice_items")
    raw_clients = extraire_table_sql("clients")

    # ==========================================
    # 🐼 METHODE 1 : PIPELINE ANALYTICS PANDAS
    # ==========================================
    print("\n--- 🐼 ANALYTICS AVEC PANDAS ---")
    df_inv_pd = pd.DataFrame(raw_invoices)
    df_items_pd = pd.DataFrame(raw_items)
    df_cli_pd = pd.DataFrame(raw_clients)

    # Étape 1 : Calcul vectoriel du montant par ligne d'article
    # Cast explicite des types Decimal/Float pour éviter les erreurs de calcul
    df_items_pd["quantity"] = df_items_pd["quantity"].astype(float)
    df_items_pd["unit_price"] = df_items_pd["unit_price"].astype(float)
    df_items_pd["vat_rate"] = df_items_pd["vat_rate"].astype(float)

    df_items_pd["total_ht"] = df_items_pd["quantity"] * df_items_pd["unit_price"]
    df_items_pd["total_tva"] = df_items_pd["total_ht"] * (df_items_pd["vat_rate"] / 100)
    df_items_pd["total_ttc"] = df_items_pd["total_ht"] + df_items_pd["total_tva"]

    # Étape 2 : Agrégation par facture (Somme des articles par invoice_id)
    df_inv_totals_pd = df_items_pd.groupby("invoice_id").agg(
        montant_HT=("total_ht", "sum"),
        montant_TVA=("total_tva", "sum"),
        montant_TTC=("total_ttc", "sum")
    ).reset_index()

    # Étape 3 : Jointures (Invoices + Clients + Totaux financiers)
    df_master_pd = pd.merge(df_inv_pd, df_cli_pd, left_on="client_id", right_on="id", suffixes=("_inv", "_cli"))
    df_final_pd = pd.merge(df_master_pd, df_inv_totals_pd, left_on="id_inv", right_on="invoice_id")

    # Affichage des métriques clés
    print(df_final_pd[["invoice_number", "client_name", "status", "montant_HT", "montant_TTC"]].head(4))


    # ==========================================
    # ⚡ METHODE 2 : PIPELINE ANALYTICS POLARS
    # ==========================================
    print("\n--- ⚡ ANALYTICS AVEC POLARS (EAGER ENGINE) ---")
    df_inv_pl = pl.DataFrame(raw_invoices)
    df_items_pl = pl.DataFrame(raw_items)
    df_cli_pl = pl.DataFrame(raw_clients)

    # Étape 1 & 2 : Traitement enchaîné (Calculs vectoriels et agrégations)
    df_inv_totals_pl = df_items_pl.with_columns([
        pl.col("quantity").cast(pl.Float64),
        pl.col("unit_price").cast(pl.Float64),
        pl.col("vat_rate").cast(pl.Float64)
    ]).with_columns([
        (pl.col("quantity") * pl.col("unit_price")).alias("total_ht"),
    ]).with_columns([
        (pl.col("total_ht") * (pl.col("vat_rate") / 100)).alias("total_tva")
    ]).with_columns([
        (pl.col("total_ht") + pl.col("total_tva")).alias("total_ttc")
    ]).group_by("invoice_id").agg([
        pl.col("total_ht").sum().alias("montant_HT"),
        pl.col("total_tva").sum().alias("montant_TVA"),
        pl.col("total_ttc").sum().alias("montant_TTC")
    ])

    # Étape 3 : Jointures en Polars
    df_final_pl = df_inv_pl.join(df_cli_pl, left_on="client_id", right_on="id") \
                           .join(df_inv_totals_pl, left_on="id", right_on="invoice_id")

    print(df_final_pl.select(["invoice_number", "client_name", "status", "montant_HT", "montant_TTC"]).head(4))
