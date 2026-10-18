# 🐼⚡ Financial Analytics ETL Pipeline: Pandas vs. Polars

## 📝 Description
This project implements a high-performance **ETL & Data Analytics pipeline** designed to ingest and process relational financial data. It serves as a benchmark and direct comparative study between **Pandas** (the industry-standard data manipulation library) and **Polars** (the modern, lightning-fast alternative powered by a multi-threaded Rust engine).

The pipeline extracts complex multi-table billing data (Users, Clients, Invoices, and Invoice Items) from a relational **MySQL** schema, performs vector-based calculations and type casting, applies complex multi-stage joins, and produces consolidated business metrics without using a single procedural `for` loop.

---

## 🏗️ Relational Schema & Data Architecture
The pipeline orchestrates and unifies data across 3 interconnected tables from a production-like database schema:
*   **`clients`**: Contains client metadata, addresses, and tax identifiers.
*   **`invoices`**: Tracks billing lifecycles, publication status, and reference numbers.
*   **`invoice_items`**: Line-by-line breakdown of quantities, unit prices, and custom VAT rates.

---

## 📐 Technical Pipeline Workflow

1. **Extraction (Data Ingestion):**
   * Establishes safe connections to the MySQL database engine.
   * Ingests individual tables natively into memory as lists of Python dictionaries.

2. **Transformation (Vectorized Analytics):**
   * **Type Casting**: Explicitly casts database `DECIMAL` types to `Float64` to prevent precision errors and unleash hardware-level vector processing.
   * **Calculations**: Computes Pre-tax Total (HT), VAT amount, and Total Inclusive of Tax (TTC) simultaneously across all records.
   * **Aggregations**: Executes a `Group By` operation on `invoice_id` to roll up individual item rows into distinct invoice-level financial blocks.
   * **Multi-stage Joins**: Implements a cascading `LEFT JOIN` strategy to map aggregated financial calculations to their respective invoice summaries and client metadata.

3. **Restitution (Load):**
   * Generates highly optimized analytical outputs for downstream business intelligence dashboards.

---

## 🛠️ Tech Stack & Key Competencies
*   **Languages:** Python 3.13+, SQL (MySQL Core Architecture)
*   **Data Frameworks:** Pandas, Polars (Eager Engine API), NumPy
*   **Database Connectors:** `mysql-connector-python`
*   **Environment Mastery:** PowerShell Execution Policies, Root-isolated Virtual Environments (`.venv`)

---

## 📂 Project Directory Structure
```text
├── .venv/                         # Centralized environment runtime dependencies
├── aggregations.py                # Module: Vectorized segmentations and group-by calculations
├── data_joins.py                  # Module: Left and Inner joins cross-referencing multi-source datasets
├── mysql_analytics_pipeline.py    # 🚀 Core ETL Pipeline: 3-table analytical engine (Pandas vs Polars)
├── produits_mysql_propres.json    # Cached source catalog dataset
├── README.md                      # Comprehensive technical portfolio documentation
```

---

## ⚙️ Installation & Live Execution

### 1. Initialize and Activate the Shared Virtual Environment
Ensure your terminal session is locked into your localized `.venv`:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
.\.venv\Scripts\Activate.ps1
```

### 2. Execute the Core Comparative Pipeline
Run the multi-table relational schema pipeline to view outputs from both engines simultaneously:
```bash
python mysql_analytics_pipeline.py
```

---

## 📊 Analytical Performance Insight
*   **Pandas Approach**: Relies on explicit bracket indexing and grouped mapping. Straightforward and versatile for general business reporting.
*   **Polars Approach**: Leverages highly descriptive method expressions (`pl.col`). It compiles expressions in parallel using Rust's query optimizer, delivering a massive speedup on large volumes of data.
