CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<your-strong-password>'

CREATE DATABASE SCOPED CREDENTIAL cred_manuj
WITH
    IDENTITY = 'Managed Identity'


CREATE EXTERNAL DATA SOURCE source_silver
WITH
(
    LOCATION = 'https://storageawproject.dfs.core.windows.net/silver',
    CREDENTIAL = cred_manuj
)


CREATE EXTERNAL DATA SOURCE source_gold
WITH
(
    LOCATION = 'https://storageawproject.dfs.core.windows.net/gold',
    CREDENTIAL = cred_manuj
)


CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)


--------------------------
------create external table extSlaes---
------------------------------------


create external table gold.extcust
with
(
    LOCATION = 'extcust',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
select * from gold.customers 

SELECT * FROM gold.extcust
