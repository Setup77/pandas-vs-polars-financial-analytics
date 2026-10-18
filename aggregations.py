import json

import pandas as pd
import polars as pl

# 1. Chargement des données produits
with open("produits_mysql_propres.json", "r", encoding="utf-8") as f:
    donnees_produits = json.load(f)

print("--- 🐼 AGRÉGATIONS AVEC PANDAS ---")
df_pd = pd.DataFrame(donnees_produits)

# Groupement par 'category_id' et calculs multiples via .agg()
df_total_pd = df_pd.groupby("category_id").agg(
    total_stock=("stock_quantity", "sum"),
    prix_moyen=("price", "mean")
).reset_index()

print(df_total_pd)


print("\n--- ⚡ AGRÉGATIONS AVEC POLARS ---")
df_pl = pl.DataFrame(donnees_produits)

# Groupement syntaxique Polars avec expressions natives pl.col
df_total_pl = df_pl.group_by("category_id").agg([
    pl.col("stock_quantity").sum().alias("total_stock"),
    pl.col("price").mean().alias("prix_moyen")
])

print(df_total_pl)
