--Cwiczenie 1
-- where join
  select pc.EnglishProductCategoryName as CategoryName
		 ,dd.CalendarYear
		 ,sum(fs.SalesAmount) as TotalSales
		 
  FROM  [dbo].[FactInternetSales] fs, [dbo].[DimProduct] p, 
		[dbo].[DimProductSubcategory] ps, dbo.DimProductCategory pc, dbo.DimDate dd
  where 1=1
	    and fs.ProductKey = p.ProductKey
	    and p.ProductSubcategoryKey = ps.ProductSubcategoryKey
	    and ps.ProductCategoryKey = pc.ProductCategoryKey
		and fs.OrderDateKey = dd.DateKey
  group by pc.EnglishProductCategoryName, dd.CalendarYear	
  order by pc.EnglishProductCategoryName
  ;
--classic join
  select pc.EnglishProductCategoryName as CategoryName,dd.CalendarYear
		 ,sum(fs.SalesAmount) as TotalSales	 
  FROM  [dbo].[FactInternetSales] fs join [dbo].[DimProduct] p
		on fs.ProductKey = p.ProductKey
		join [dbo].[DimProductSubcategory] ps
		on p.ProductSubcategoryKey = ps.ProductSubcategoryKey
		join dbo.DimProductCategory pc
		on ps.ProductCategoryKey = pc.ProductCategoryKey
		join dbo.DimDate dd 
		on fs.OrderDateKey = dd.DateKey
  group by pc.EnglishProductCategoryName	,dd.CalendarYear
  order by pc.EnglishProductCategoryName
  ;
  
 --Cwiczenie 2

  select ps.EnglishProductSubcategoryName as SubcategoryName
		 ,st.SalesTerritoryCountry as Country
		 ,st.SalesTerritoryRegion as Region
		 ,sum(fs.SalesAmount) as TotalSales	 
  FROM  [dbo].[FactInternetSales] fs, [dbo].[DimProduct] p, 
		[dbo].[DimProductSubcategory] ps, [dbo].[DimSalesTerritory] st
  where 1=1
	    and fs.ProductKey = p.ProductKey
	    and p.ProductSubcategoryKey = ps.ProductSubcategoryKey
		and fs.SalesTerritoryKey = st.SalesTerritoryKey
  group by ps.EnglishProductSubcategoryName
		 ,st.SalesTerritoryCountry
		 ,st.SalesTerritoryRegion ; 