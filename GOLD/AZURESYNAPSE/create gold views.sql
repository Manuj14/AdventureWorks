------------------------------
-------CREATE VIEW CALENDER---
-----------------------------

CREATE VIEW gold.calander
as
SELECT
    *
FROM
    OPENROWSET(
            BULK 'AdventureWorks_Calendar/',
            DATA_SOURCE = 'source_silver',
            FORMAT = 'PARQUET'
    )as query1

----------------------------
-----CREATE VIEW CUSTOMERS---
----------------------------

CREATE VIEW gold.customers
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'AdventureWorks_Customers/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query2


----------------------------
-----CREATE VIEW PRODUCT CATEGORIES---
----------------------------

CREATE VIEW gold.product_categories
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'AdventureWorks_Product_Categories/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query3


----------------------------
-----CREATE VIEW PRODUCTS ---
----------------------------

CREATE VIEW gold.products
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'AdventureWorks_Products/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query4

----------------------------
-----CREATE VIEW RETURNS ---
----------------------------

CREATE VIEW gold.ret
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'AdventureWorks_Returns/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query5

----------------------------
-----CREATE VIEW SALES ---
----------------------------

CREATE VIEW gold.sales
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'AdventureWorks_Sales/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query6


----------------------------
-----CREATE VIEW Territory ---
----------------------------

CREATE VIEW gold.territory
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'AdventureWorks_Territories/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query7

----------------------------
-----CREATE VIEW SUBCATEGORY ---
----------------------------

CREATE VIEW gold.subcategory
AS
SELECT 
    * 
FROM 
    OPENROWSET(
        BULK 'Product_Subcategories/',
        DATA_SOURCE = 'source_silver',
        FORMAT= 'PARQUET'
) as query8