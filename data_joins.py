import json

import pandas as pd
import polars as pl

# 1. Load your cleaned MySQL products data
with open("produits_mysql_propres.json", "r", encoding="utf-8") as f:
    donnees_produits = json.load(f)

# Simulation of a users dataset from another system
donnees_users = [
    {"user_id": 1, "owner_name": "Alice Developer", "team": "E-commerce"},
    {"user_id": 2, "owner_name": "Bob Data Architect", "team": "Analytics"},
    {"user_id": 4, "owner_name": "Judicael Lead", "team": "Infrastructure"}
]

print("--- 🐼 JOINS WITH PANDAS ---")
df_prod_pd = pd.DataFrame(donnees_produits)
df_user_pd = pd.DataFrame(donnees_users)

# In Pandas, we use pd.merge()
# 'on' specifies the common key, 'how' specifies the join type
df_joined_pd = pd.merge(df_prod_pd, df_user_pd, on="user_id", how="left")

# Select a few columns to inspect the match
print(df_joined_pd[["id", "name", "owner_name", "team"]].head(4))


print("\n--- ⚡ JOINS WITH POLARS ---")
df_prod_pl = pl.DataFrame(donnees_produits)
df_user_pl = pl.DataFrame(donnees_users)

# In Polars, we call .join() directly on the DataFrame
df_joined_pl = df_prod_pl.join(df_user_pl, on="user_id", how="left")

print(df_joined_pl.select(["id", "name", "owner_name", "team"]).head(4))
