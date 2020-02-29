	SELECT ds.CustomerKey, ds.FirstName, ds.LastName
	, COUNT(*) AS CountOrders
	, SUM(fs.OrderQuantity) AS SumOfItems
	INTO #TmpGoldenCustomers
	FROM FactInternetSales AS fs
	JOIN DimCustomer AS ds
	ON fs.CustomerKey = ds.CustomerKey
	GROUP BY ds.CustomerKey, ds.FirstName, ds.LastName
	HAVING COUNT(*) > 50 

SELECT *
FROM [dbo].[#TmpGoldenCustomers]