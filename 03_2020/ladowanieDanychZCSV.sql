BULK INSERT SuperstoreLanding.dbo.DIM_CUSTOMER_LANDING
FROM 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Customers.csv' 
WITH (FORMAT='CSV', FIRSTROW = 2);

SELECT * FROM dbo.DIM_CUSTOMER_LANDING;

USE SuperstoreLanding
GO
EXEC proc_DimCustomerLandingLoad;