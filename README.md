# 🏡 Airbnb Data Engineering Pipeline | AWS S3, Snowflake & dbt

An end-to-end ELT data engineering project that demonstrates how to build a cloud-based data pipeline using **AWS S3, Snowflake, and dbt Core**. The project follows the **Medallion Architecture (Bronze, Silver, and Gold)** to organize raw data, transform it into reliable datasets, and prepare analytics-ready models.

The pipeline focuses on data ingestion, SQL transformations, incremental loading, modular dbt development, and analytical data modeling.

---

## 📌 Project Overview

Modern data platforms need reliable pipelines that can process raw data, maintain data quality, and produce datasets for business analysis.

This project implements a data transformation pipeline for Airbnb data. Data files are stored in Amazon S3 and loaded into Snowflake, where dbt transforms the data through multiple layers.

The resulting datasets can support analysis of bookings, listings, hosts, pricing, and other Airbnb business metrics.

### Key Objectives

- Build a cloud-based data pipeline using AWS and Snowflake.
- Implement the Bronze, Silver, and Gold layers.
- Transform raw datasets using dbt Core and SQL.
- Implement incremental loading to process new or changed records efficiently.
- Use Jinja templating and reusable macros to reduce repetitive SQL.
- Build an integrated analytical dataset using multiple source tables.
- Explore historical data tracking through dbt snapshots.
- Follow modular development practices using Git and separate development branches.

---

## 🏗️ Architecture

```text
              Airbnb Source Data
                      |
                      v
                +-----------+
                |  AWS S3   |
                | Raw Files |
                +-----------+
                      |
                      v
                +-----------+
                | Snowflake |
                | Raw Data  |
                +-----------+
                      |
                      v
            +--------------------+
            | Bronze Layer       |
            | Raw Data Models    |
            +--------------------+
                      |
                      v
            +--------------------+
            | Silver Layer       |
            | Cleaning and       |
            | Transformations     |
            +--------------------+
                      |
                      v
            +--------------------+
            | Gold Layer         |
            | Business-Ready     |
            | Analytical Models  |
            +--------------------+
                      |
                      v
            +--------------------+
            | Analytics and      |
            | Reporting          |
            +--------------------+
```

**Technology flow:** AWS S3 → Snowflake → dbt Core transformations → Analytics-ready datasets.

*Note: The exact ingestion mechanism and the placement of raw tables should reflect the implementation in the repository.*

---

## 🥉 Medallion Architecture

### 1. Bronze Layer — Raw Data

The Bronze layer represents the initial data layer in Snowflake.

**Responsibilities:**
- Store ingested Airbnb source data.
- Preserve source-level information for downstream processing.
- Provide a foundation for data validation and transformation.

**Example datasets:**
- Bookings
- Listings
- Hosts

### 2. Silver Layer — Cleaned and Transformed Data

The Silver layer transforms raw datasets into cleaner, more consistent structures.

**Responsibilities:**
- Clean and standardize source data.
- Apply data transformation and validation rules.
- Prepare datasets for analytical joins.
- Implement incremental loading where configured.

The goal is to make the data more reliable and easier to use in downstream models.

### 3. Gold Layer — Analytics-Ready Data

The Gold layer contains business-oriented models designed for reporting and analysis.

One focus of this project is creating an **One Big Table (OBT)** by joining relevant Silver-layer datasets.

For example, a bookings-oriented analytical model can combine information from:
- Bookings
- Listings
- Hosts

This brings related information into a single dataset, reducing the need for repeated joins in downstream analytical queries.

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Local development environment and package management |
| dbt Core | SQL transformation and data modeling |
| Snowflake | Cloud data warehouse |
| AWS S3 | Storage for source data files |
| SQL | Data transformation and analytical queries |
| Jinja | Dynamic SQL generation and model configuration |
| Git and GitHub | Version control and project collaboration |

---

## ⚙️ Key Features

### Incremental Loading

Incremental models allow dbt to process new or changed records instead of rebuilding an entire dataset on every run.

This can reduce unnecessary processing as the volume of data grows.

Example configuration:

```sql
{{
    config(
        materialized='incremental',
        unique_key='BOOKING_ID'
    )
}}
```

The model's SQL must also define the appropriate incremental filtering logic. A `unique_key` alone does not determine which new or changed records should be processed.

### Jinja Templating

Jinja enables dynamic SQL generation within dbt models.

It can be used to:
- Generate repetitive SQL statements.
- Loop through configuration-driven lists.
- Dynamically construct column selections and joins.
- Reuse model logic across similar transformations.

This helps make complex transformations easier to maintain.

### Reusable dbt Macros

Macros encapsulate reusable SQL logic so it can be shared across multiple models.

Benefits include:
- Reduced SQL duplication.
- Consistent implementation of transformation rules.
- Easier maintenance.
- Better modularity.

### One Big Table (OBT)

The Gold layer can combine bookings, listings, and host attributes into a unified analytical dataset.

Potential analytical use cases include:
- Booking analysis by city or country.
- Revenue analysis.
- Property-type comparisons.
- Host performance analysis.
- Booking trends over time.

These are intended use cases; the metrics available depend on the actual columns and business rules implemented in the project.

### dbt Snapshots

dbt snapshots can track changes to records over time using snapshot strategies such as `timestamp` or `check`.

They support historical analysis by retaining versions of records when changes are observed during snapshot runs.

Snapshots require a suitable source relation and a stable unique key. The chosen strategy must also match the source data's update behavior.

### Data Quality Testing

dbt tests help validate assumptions about the data.

Common examples include:
- `not_null`
- `unique`
- `relationships`
- `accepted_values`

Tests should be configured against the relevant models and columns.

---

## 📂 Project Structure

The following is an illustrative structure. Adjust the paths to match the actual repository.

```text
Airbnb-project/
│
├── dbt_project/
│   ├── models/
│   │   ├── bronze/
│   │   ├── silver/
│   │   └── gold/
│   │
│   ├── macros/
│   ├── snapshots/
│   ├── seeds/
│   ├── tests/
│   ├── dbt_project.yml
│   ├── packages.yml
│   └── README.md
│
├── .gitignore
└── README.md
```

### Directory descriptions

| Directory or file | Purpose |
|---|---|
| `models/bronze/` | Bronze-layer models, if implemented as dbt models |
| `models/silver/` | Silver-layer transformation models |
| `models/gold/` | Gold-layer analytical models |
| `macros/` | Reusable Jinja and SQL logic |
| `snapshots/` | Snapshot definitions for historical tracking |
| `seeds/` | CSV files loaded through dbt |
| `tests/` | Custom data-quality tests |
| `dbt_project.yml` | Project configuration |
| `packages.yml` | External dbt package declarations |

*The exact directory layout may differ depending on how the models and snapshots are organized.*

---

## 🚀 Getting Started

### Prerequisites

Before running the project, ensure you have:

- Python installed.
- dbt Core installed.
- The dbt Snowflake adapter installed.
- Access to a Snowflake account.
- An appropriately configured Snowflake warehouse, database, schema, and role.
- AWS S3 access if you need to manage or inspect the source files.
- Git installed.

### 1. Clone the repository

```bash
git clone https://github.com/Varunsaketh/Airbnb-project.git
```

Navigate to the project directory:

```bash
cd Airbnb-project
```

If the dbt project is inside a subdirectory, navigate into that directory:

```bash
cd dbt_project
```

### 2. Create and activate a virtual environment

On Windows PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

If you already have a working virtual environment, activate it instead of creating another one.

### 3. Install dbt Core and the Snowflake adapter

```bash
pip install dbt-core dbt-snowflake
```

Verify the installation:

```bash
dbt --version
```

For reproducible environments, use the package versions specified by your project's dependency setup.

### 4. Configure the Snowflake connection

Create or update the `profiles.yml` file in your local dbt configuration directory.

On Windows, this is typically:

```text
C:\Users\<your_username>\.dbt\profiles.yml
```

Example:

```yaml
airbnb:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: your_account_identifier
      user: your_username
      password: "{{ env_var('DBT_PASSWORD') }}"
      role: your_role
      warehouse: your_warehouse
      database: AIRBNB
      schema: DBT_SCHEMA
      threads: 4
```

Ensure the profile name matches the `profile:` setting in `dbt_project.yml`.

Configure the `DBT_PASSWORD` environment variable securely before running dbt. Alternatively, use an authentication method supported by your Snowflake account and adapter.

**Never commit passwords, private keys, tokens, or other credentials to GitHub.**

### 5. Validate the connection

```bash
dbt debug
```

This checks the dbt configuration and attempts to establish the Snowflake connection.

Resolve any authentication, permission, warehouse, database, or schema configuration errors before proceeding.

### 6. Install dependencies and validate the project

```bash
dbt deps
dbt parse
dbt compile
```

These commands install declared packages, parse the project, and compile model SQL.

### 7. Run the models

```bash
dbt run
```

This executes the selected models according to the project's model configuration and dependencies.

### 8. Run data-quality tests

```bash
dbt test
```

This executes the selected tests defined in the project.

### 9. Build and test selected resources together

```bash
dbt build
```

`dbt build` runs selected resources in dependency order, including applicable models, tests, seeds, and snapshots.

Unlike `dbt run`, it can execute associated data tests as part of the build workflow.

---

## 🧰 Useful dbt Commands

| Command | Description |
|---|---|
| `dbt --version` | Check dbt and adapter versions |
| `dbt init project_name` | Initialize a new project |
| `dbt debug` | Validate configuration and connectivity |
| `dbt deps` | Install dependencies |
| `dbt parse` | Parse project files |
| `dbt compile` | Compile SQL |
| `dbt run` | Execute models |
| `dbt test` | Run data-quality tests |
| `dbt seed` | Load seed CSV files |
| `dbt snapshot` | Execute snapshots |
| `dbt build` | Build selected resources and execute applicable tests |
| `dbt docs generate` | Generate documentation |
| `dbt docs serve` | Serve documentation locally |

### Run a specific model

```bash
dbt run --select s_bookings
```

### Run a model with its upstream dependencies

```bash
dbt run --select +gold_obt
```

### Build a model with its upstream dependencies

```bash
dbt build --select +gold_obt
```

### Fully refresh an incremental model

```bash
dbt run --select s_bookings --full-refresh
```

A full refresh can rebuild the model from its underlying data. Use it only when that behavior is intended.

---

## 📊 Potential
