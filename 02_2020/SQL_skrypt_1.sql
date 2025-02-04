--SELECT - INTO
-- Cwiczenie
/*
Wyświetl ilość zamówień z tabeli FactInternetSales 
pogrupowaną po CustomerKey, oraz FirstName i LastName z tabeli DimCustomer.

Wyfiltruj klientów, którzy złożyli więcej niż 50 zamówień.

Zapisz wynik zapytania do tabeli dbo.GoldenCustomers.
*/
Use [AdventureworksDW2016CTP3]
go
  SELECT fs.CustomerKey
		, dc.FirstName
		, dc.LastName
        ,count(*) count_orders
  into dbo.GoldenCustomers	
  FROM [dbo].[FactInternetSales] fs,
	   [dbo].[DimCustomer] dc
  where 1=1
		and fs.CustomerKey = dc.CustomerKey

  group by fs.CustomerKey, dc.FirstName, dc.lastName
  having count(*) > 50;

  -- lub

select fs.CustomerKey
		, dc.FirstName
		, dc.LastName
        ,count(*) count_orders
into dbo.GoldenCustomers
from [dbo].[FactInternetSales] as fs join
[dbo].[DimCustomer] dc
on fs.CustomerKey = dc.CustomerKey
group by fs.CustomerKey		, dc.FirstName		, dc.LastName
having count(*) > 50;


select * from dbo.GoldenCustomers
--------------------
-- Temporary tables


  SELECT fs.CustomerKey
		, dc.FirstName
		, dc.LastName
        ,count(*) count_orders
  into #TmpGoldenCustomers	
  FROM [dbo].[FactInternetSales] fs,
	   [dbo].[DimCustomer] dc
  where 1=1
		and fs.CustomerKey = dc.CustomerKey
  group by fs.CustomerKey, dc.FirstName, dc.lastName
  having count(*) > 50;

Select * from 
dbo.#TmpGoldenCustomers;
---------------------------
-- DML
-- Update
Update dbo.GoldenCustomers
set LastName = 'Kowalska'
where CustomerKey = 11185;

Update dbo.GoldenCustomers
set LastName = 'Kowalska'
where CustomerKey in (
select CustomerKey from dbo.GoldenCustomers where LastName like '%Da%');



insert into dbo.GoldenCustomers
select fs.CustomerKey
		, dc.FirstName
		, dc.LastName
        ,count(*) count_orders
from [dbo].[FactInternetSales] as fs join
[dbo].[DimCustomer] dc
on fs.CustomerKey = dc.CustomerKey
group by fs.CustomerKey		, dc.FirstName		, dc.LastName
having count(*) between 10 and 50;



insert into dbo.GoldenCustomers	
  SELECT fs.CustomerKey
		, dc.FirstName
		, dc.LastName
        ,count(*) count_orders
  FROM [dbo].[FactInternetSales] fs,
	   [dbo].[DimCustomer] dc
  where 1=1
		and fs.[CustomerKey] = dc.[CustomerKey]
  group by fs.[CustomerKey],  dc.FirstName, dc.lastName
  having count(*) > 50; 


select * from dbo.GoldenCustomers;

drop table dbo.GoldenCustomers;

--SELECT - OVER

--Przykład 1
--select
SELECT fs.CustomerKey
      ,fs.SalesOrderNumber
	  ,fs.SalesOrderLineNumber
      ,fs.SalesAmount 
  FROM [dbo].[FactInternetSales] fs,
		[dbo].GoldenCustomers gc
  where  fs.CustomerKey = gc.CustomerKey
  order by fs.CustomerKey;

--select over
/*
- Suma wartości wszystkich produktów w zamówieniu
- Suma krocząca wszystkich produktów w zamówieniu
- Suma wartości wszystkich zamówień wykonanych przez klienta
- Ranking produktow w zamowieniu wg. wartosci sprzedazy
*/
SELECT fs.CustomerKey
      ,fs.SalesOrderNumber
	  ,fs.SalesOrderLineNumber
      ,fs.SalesAmount
	  ,sum(fs.SalesAmount) over (partition by fs.SalesOrderNumber) as TotalSalesAmount
	  ,sum(fs.SalesAmount) over (partition by fs.SalesOrderNumber order by fs.SalesOrderLineNumber 
	  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RunningOrderSalesAmount
	  ,sum(fs.SalesAmount) over (partition by fs.CustomerKey) as TotalSalesByCustomer
	  ,rank() over (partition by fs.SalesOrderNumber order by SalesAmount desc) as SalesAmountRnk
  FROM [dbo].[FactInternetSales] fs,
		[dbo].GoldenCustomers gc
  where  fs.CustomerKey = gc.CustomerKey
  order by fs.CustomerKey,fs.SalesOrderNumber, fs.SalesOrderLineNumber;

-- Przykład 2
-- Ranking 5 najpopularniejszych produktów

select sub.ProductKey, sub.Ranking, sub.SumQuantity, sub.RowNum from (
	select 
	[ProductKey],
	rank() over (order by sum(OrderQuantity) desc) as Ranking,
	row_number() over (order by sum(OrderQuantity) desc) as RowNum,
	sum(OrderQuantity) as SumQuantity
	FROM 
	 [dbo].[FactInternetSales] 
	group by [ProductKey]
)sub
where sub.Ranking < 6;


-- Cwiczenie 
/*Wyswietl ID klienta oraz id i datę jego ostatniego zamówienia 
(tabela [FactInternetSales])*/

select * from (
		select
		[CustomerKey],
		[SalesOrderNumber],
		[OrderDate],
		row_number() over (partition by [CustomerKey] order by [OrderDate] desc) as Ranking,
		rank() over (partition by [CustomerKey] order by [OrderDate] desc) as Ranking1,
		dense_rank() over (partition by [CustomerKey] order by [OrderDate] desc) as Ranking2
		FROM [dbo].[FactInternetSales] 
)rnk
where Ranking = 1

-- FIRST_VALUE, LAST_VALUE

-- Przyklad 1

select dp.[ProductSubcategoryKey],
ps.[EnglishProductSubcategoryName] as SubcategoryName,
	   dp.[ProductKey],
	   dp.[EnglishProductName] as ProductName,
	   dp.[ListPrice]
	   ,first_value(dp.[ListPrice]) 
	   over (partition by dp.[ProductSubcategoryKey] order by dp.[ListPrice] asc) as CheapestInSubcat
	   ,first_value(dp.[ListPrice]) 
	   over (partition by dp.[ProductSubcategoryKey] order by dp.[ListPrice] desc) as MostExpensiveInSubcat
from [dbo].[DimProduct] dp join
	 [dbo].[DimProductSubcategory] ps
	 on dp.[ProductSubcategoryKey] = ps.[ProductSubcategoryKey] 
	 where 1=1
	 and dp.[ListPrice] is not null
	 and dp.[Status] = 'Current'

-- LAG, LEAD

-- Przykład 1

SELECT EmployeeKey, 
	   CalendarYear,
	   CalendarQuarter,
	   SalesAmountQuota AS CurrentQuota,   
       LAG(SalesAmountQuota, 1,0) 
	   OVER (PARTITION BY EmployeeKey ORDER BY CalendarYear desc, CalendarQuarter asc) AS PreviousQuota,  
	   LEAD(SalesAmountQuota, 1,0) 
	   OVER (PARTITION BY EmployeeKey ORDER BY CalendarYear desc, CalendarQuarter asc) AS NextQuota
from [dbo].[FactSalesQuota]
order by EmployeeKey, CalendarYear desc, CalendarQuarter asc

--select * from [dbo].[FactSalesQuota] order by EmployeeKey, CalendarYear, CalendarQuarter

-- Cwiczenie
/*Z tabeli [FactSalesQuota], dla danego EmployeeKey
wyświetl pierwszą dostępną wartość sprzedaży (first_value)
wartość sprzedaży z poprzedniego kwartału (LEAD)*/

select * from (



SELECT EmployeeKey, 
	   CalendarYear,
	   CalendarQuarter,
	   SalesAmountQuota AS CurrentQuota,
	   first_value(SalesAmountQuota) 
	   over (partition by EmployeeKey order by CalendarYear desc, CalendarQuarter asc) as LatestQuota,
	   LEAD(SalesAmountQuota, 1,0) OVER (PARTITION BY EmployeeKey ORDER BY CalendarYear desc, CalendarQuarter asc) AS PreviousQuota

from [dbo].[FactSalesQuota]



--order by EmployeeKey, CalendarYear desc, CalendarQuarter asc
)sub
where rnk = 1;

--MERGE
-- Cwiczenie
/*
Skasuj rekordy z tabeli GoldenCustomers, jesli maksymalna data zamowienia z FactInternetSales jest starsza niz 11 lat 

Select CustomerKey I first_valaue daty zamowienia
Dodac warunek ze data zamowienia jest mniejsza niz ‘dzisiaj minus X dni)
Dodac Merge, ktory skasuje rekordy z tabeli Golden Customers
*/

  merge dbo.GoldenCustomers gc	
  using (
  select fs.CustomerKey, max(fs.OrderDate) maxOrderDate FROM [dbo].[FactInternetSales] fs
		 group by fs.CustomerKey
		 having max(fs.OrderDate) < getdate()-3015
		) as src
  on gc.CustomerKey  = src.CustomerKey
  when matched then
  delete ;


  delete from dbo.GoldenCustomers where CustomerKey in (
  select fs.CustomerKey FROM [dbo].[FactInternetSales] fs
		 group by fs.CustomerKey
		 having max(fs.OrderDate) < getdate()-3015
  )


select gc.*, 
		substring(LastName, 2,6) as subs,
		replace (LastName,'Sanchez','Martinez') as repl
from dbo.goldenCustomers gc;


select getdate()-4015 ;



-- TSQL
-- Procedure
go
create procedure What_DB_is_this 
as 
SELECT DB_NAME() AS ThisDB; 

EXEC What_DB_is_this;


CREATE PROCEDURE dbo.uspGetAddress @LastName nvarchar(30)
AS
SELECT  * 
FROM dbo.DimCustomer
WHERE LastName = @LastName
GO

EXEC dbo.uspGetAddress @LastName = 'Wang'


-- multiple parameters

CREATE PROCEDURE dbo.uspGetPersonalDetails @FirstName nvarchar(30) = NULL, @LastName nvarchar(60) = NULL
AS
SELECT *
FROM dbo.DimCustomer
WHERE FirstName = ISNULL(@FirstName,FirstName)
AND LastName LIKE '%' + ISNULL(@LastName ,LastName) + '%'















