use SuperstoreLanding
go

CREATE OR ALTER PROC proc_DimProductLandingLoad  --nazwa procedury Dim...

as

begin 

Truncate table SuperstoreLanding.dbo.DIM_CUSTOMER_LANDING;  --czysci dane

BULK INSERT SuperstoreLanding.dbo.DIM_CUSTOMER_LANDING
FROM 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Customers.csv' 
WITH (FORMAT='CSV', FIRSTROW = 2);

end 
go