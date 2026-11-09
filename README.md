Azure Data Pipeline: AdventureWorks (Bronze, Silver, Gold)

An end-to-end data engineering pipeline on Azure. It copies the AdventureWorks sample data into a data lake, cleans it with PySpark in Azure Databricks, and exposes it through Azure Synapse Analytics SQL for analysis.



Architecture
Source data (AdventureWorks CSV files, pulled from GitHub)
        |
        |  Azure Data Factory: Lookup -> ForEach -> Copy
        v
ADLS Gen2 - bronze container (raw CSV)
        |
        |  Azure Databricks: PySpark transformations
        v
ADLS Gen2 - silver container (cleaned Parquet)
        |
        |  Azure Synapse Analytics: external tables and views
        v
Gold layer (SQL views for analysis)


Tech stack
Area	                Tools
Orchestration	    Azure Data Factory
Storage	            Azure Data Lake Storage Gen2 (bronze, silver, gold containers)
Transformation	    Azure Databricks, PySpark
Serving	            Azure Synapse Analytics (SQL)
File format	        CSV (bronze), Parquet (silver and gold)
Version control	    Git, GitHub


What each layer does

Bronze (Azure Data Factory). A Lookup activity reads the list of files to copy, and a ForEach loop runs a Copy activity for each one, landing the raw files in the bronze container. The pipeline definitions are in BRONZE/ADF/PIPELINES/.

Silver (Azure Databricks). The notebook SILVER/TRANSFORMATION/DATABRICKS/Silver_layer.ipynb reads each CSV from bronze with PySpark, cleans it, and writes Parquet to the silver container.

Dataset	Transformation
Calendar	        Added Month and Year columns from the date
Customers	        Built a Full_name column from prefix, first name and last name
Product categories	Converted CategoryName to upper case
Products	        Shortened ProductSKU and ProductName to their first segment
Sales	            Converted StockDate to a timestamp, standardized order numbers, added a column multiplying order line item by order quantity
Returns, Territories, Product subcategories	Loaded and written to silver without changes

Gold (Azure Synapse Analytics). The SQL scripts in GOLD/AZURESYNAPSE/ create a schema, a master key, a credential that uses a managed identity, external data sources for the silver and gold containers, and a Parquet file format. They then create external tables and views over the data.

Repository structure
BRONZE/ADF/PIPELINES/
    Dynamic-copy-git-to-raw.json
    Git-to-raw.json
SILVER/TRANSFORMATION/DATABRICKS/
    Silver_layer.ipynb
GOLD/AZURESYNAPSE/
    CreateSchema.sql
    create external table.sql
    create gold views.sql
How to run
Create an ADLS Gen2 storage account with containers named bronze, silver and gold.
Import the pipeline JSON files into Azure Data Factory and point the linked services at your own storage account.
Open the notebook in Azure Databricks, set your storage account name and credentials (see below), and run all cells.
In Synapse, run the scripts in GOLD/AZURESYNAPSE/: first CreateSchema.sql, then create external table.sql, then create gold views.sql.

Credentials

No secrets are stored in this repository. The notebook uses placeholders for the service principal values (<client-id>, <tenant-id>, <client-secret>) and the SQL scripts use placeholders for passwords. In Databricks, load real values from a secret scope with dbutils.secrets.get(scope="...", key="...") instead of typing them into cells.

Possible next steps
Incremental loading instead of full copies
Data quality checks between layers
Scheduling with Data Factory triggers or Databricks Jobs
Deployment with Databricks Asset Bundles and a CI/CD pipeline
A Power BI dashboard on the gold layer