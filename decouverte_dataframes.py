import json

import pandas as pd
import polars as pl


# Chargement de vos données prélavées de la semaine dernière
with open("produits_mysql_propres.json", "r", encoding="utf-8") as f:
    donnees_produits = json.load(f)

print("=== 🐼 APPROCHE PANDAS ===")
# 1. Création du DataFrame Pandas
df_pandas = pd.DataFrame(donnees_produits)

# 2. Sélection de colonnes spécifiques
print(df_pandas[["name", "price"]].head(2))  # .head(2) affiche les 2 premières lignes

# 3. Filtrage : Sélectionner les produits avec un prix > 500€
produits_chers_pd = df_pandas[df_pandas["price"] > 500]
print(f"Nombre de produits chers (Pandas) : {len(produits_chers_pd)}\n")


print("=== ⚡ APPROCHE POLARS ===")
# 1. Création du DataFrame Polars
df_polars = pl.DataFrame(donnees_produits)

# 2. Sélection de colonnes spécifiques (Syntaxe plus explicite .select)
print(df_polars.select(["name", "price"]).head(2))

# 3. Filtrage : Utilisation de la méthode .filter() et des expressions pl.col
produits_chers_pl = df_polars.filter(pl.col("price") > 500)
print(f"Nombre de produits chers (Polars) : {len(produits_chers_pl)}")

#Gestion des valeurs manquantes 

# Remplacer les valeurs manquantes dans la colonne 'image' par une chaîne par défaut
# 🐼 Pandas ==  fillna
df_pandas["image"] = df_pandas["image"].fillna("/uploads/products/default.jpg")

# ⚡ Polars  == fill_null
df_polars = df_polars.with_columns(
    pl.col("image").fill_null("/uploads/products/default.jpg")
)

# Convertir la colonne 'price' en type Float 64 bits
# 🐼 Pandas
df_pandas["price"] = df_pandas["price"].astype(float)

# ⚡ Polars
df_polars = df_polars.with_columns(
    pl.col("price").cast(pl.Float64)
)


