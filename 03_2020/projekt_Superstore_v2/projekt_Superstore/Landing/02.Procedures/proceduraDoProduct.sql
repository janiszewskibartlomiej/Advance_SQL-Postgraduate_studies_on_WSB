use SuperstoreLanding
go

CREATE OR ALTER PROC proc_DimProductLandingLoad  --nazwa procedury Dim...

as

begin 

Truncate table SuperstoreLanding.dbo.DIM_PRODUCT_LANDING;

BULK INSERT SuperstoreLanding.dbo.DIM_PRODUCT_LANDING
FROM 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Products.txt' 
WITH (FIELDTERMINATOR= '|', ROWTERMINATOR = '\n', FIRSTROW = 2);

end 
go

SELECT * FROM dbo.DIM_PRODUCT_LANDING;

USE SuperstoreLanding
GO
EXEC proc_DimProductLandingLoad;