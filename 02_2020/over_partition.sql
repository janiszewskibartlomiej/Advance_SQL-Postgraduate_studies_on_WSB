SELECT fs.CustomerKey
	, fs.SalesOrderNumber
	, fs.SalesOrderLineNumber
	, fs.SalesAmount
	, SUM(fs.SalesAmount) OVER (PARTITION BY fs.SalesOrderNumber) AS TotalSalesAmount
FROM FactInternetSales fs,
	GodenCustomers gc
WHERE fs.CustomerKey = gc.CustomerKey
ORDER BY fs.CustomerKey;

SELECT fs.CustomerKey
	, fs.SalesOrderNumber
	, fs.SalesOrderLineNumber
	, fs.SalesAmount
	, SUM(fs.SalesAmount) OVER (PARTITION BY fs.CustomerKey) AS TotalSalesAmount
FROM FactInternetSales fs,
	GodenCustomers gc
WHERE fs.CustomerKey = gc.CustomerKey
ORDER BY fs.CustomerKey, fs.SalesOrderNumber, fs.SalesOrderLineNumber;

SELECT fs.CustomerKey
	, fs.SalesOrderNumber
	, fs.SalesOrderLineNumber
	, fs.SalesAmount
	, SUM(fs.SalesAmount) OVER (PARTITION BY fs.CustomerKey) AS TotalSalesAmount
	, SUM(fs.SalesAmount) OVER(PARTITION BY fs.SalesOrderNumber ORDER BY fs.SalesOrderLineNumber
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RunningOrderSalesAmount
	, RANK() OVER (PARTITION BY fs.SalesOrderNumber ORDER BY SalesAmount DESC) as SalesAmontRank
FROM FactInternetSales fs,
	GodenCustomers gc
WHERE fs.CustomerKey = gc.CustomerKey
ORDER BY fs.CustomerKey, fs.SalesOrderNumber, fs.SalesOrderLineNumber;