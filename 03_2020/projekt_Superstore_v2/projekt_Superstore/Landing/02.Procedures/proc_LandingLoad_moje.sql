use SuperstoreLanding
go

CREATE OR ALTER PROC dbo.proc_MojaProc
@tbl NVARCHAR(30)
,@path nvarchar(255)
,@format nvarchar(10)
as

begin 

DECLARE @query NVARCHAR(500)
SET @query = 'Truncate table ' + @tbl;


SET @query = '
BULK INSERT ' + @tbl +
' FROM ' + '''' + @path + '''' +
' WITH (FORMAT='+ '''' + @format + '''' + ', FIRSTROW =2)';

PRINT @query;
EXEC(@query);

/*Truncate table @tbl;  --to nie zadziala */

/*BULK INSERT SuperstoreLanding.dbo.DIM_CUSTOMER_LANDING
FROM 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Customers.csv' 
WITH (FORMAT='CSV', FIRSTROW = 2);*/

end 
go

-- 4 ''''  to jest równe cos w ciapkach = 'jakis tekst'

EXEC proc_MojaProc @tbl = 'dbo.FACT_SALES_LANDING',
@path = 'D:\GITHUB\Advanced_SQL-Postgraduate_studies_on_WSB\03_2020\projekt_Superstore_v2\projekt_Superstore\Landing\Source\Sales.csv',
@format = 'CSV'