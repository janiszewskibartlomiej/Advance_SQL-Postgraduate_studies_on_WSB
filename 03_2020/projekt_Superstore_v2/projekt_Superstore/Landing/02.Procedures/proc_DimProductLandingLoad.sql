
Truncate table SuperstoreLanding.dbo.DIM_PRODUCT_LANDING;

BULK INSERT SuperstoreLanding.dbo.DIM_PRODUCT_LANDING
FROM 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Products.txt' 
WITH (FIELDTERMINATOR= '|', ROWTERMINATOR = '\n', FIRSTROW = 2);

SELECT * FROM dbo.DIM_PRODUCT_LANDING;

USE SuperstoreLanding
GO
EXEC proc_DimCustomerLandingLoad;


EXEC proc_MojaProc @tbl = 'dbo.FACT_SALES_LANDING',
@path = 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Products.csv',
@format = 'CSV'