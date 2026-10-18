import json
import pandas as pd
import polars as pl

# 1. Chargement des données MySQL propres générées en Semaine 1
with open("produits_mysql_propres.json", "r", encoding="utf-8") as f:
    donnees_produits = json.load(f)

print("--- 🐼 NETTOYAGE AVANCÉ AVEC PANDAS ---")
df_pd = pd.DataFrame(donnees_produits)

# Remplacement des valeurs nulles dans 'image'
df_pd["image"] = df_pd["image"].fillna("/uploads/products/default.jpg")

# Passage du nom du produit en MAJUSCULES (Opération sur chaîne via .str)
df_pd["name"] = df_pd["name"].str.upper()

# Affichage du résultat Pandas
print(df_pd[["name", "image"]].head(3))


print("\n--- ⚡ NETTOYAGE AVANCÉ AVEC POLARS ---")
df_pl = pl.DataFrame(donnees_produits)

# En Polars, on enchaîne les expressions dans .with_columns() pour un traitement ultra-rapide
df_pl = df_pl.with_columns([
    pl.col("image").fill_null("/uploads/products/default.jpg"),
    pl.col("name").str.to_uppercase() # Syntaxe Polars native pour les chaînes
])

# Affichage du résultat Polars
print(df_pl.select(["name", "image"]).head(3))
