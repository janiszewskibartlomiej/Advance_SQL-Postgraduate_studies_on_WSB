

SELECT
	ProductKey,
	RANK() OVER (ORDER BY SUM(OrderQuantity) ASC) AS Ranking,
	DENSE_RANK() OVER (ORDER BY SUM(OrderQuantity) ASC) AS Dens_Ranking,
	SUM(OrderQuantity) AS SumQuantity
FROM FactInternetSales
GROUP BY ProductKey
ORDER BY SUM(OrderQuantity) ASC



SELECT Subquery.ProductKey, Subquery.Dens_Ranking
FROM
(SELECT
	ProductKey,
	RANK() OVER (ORDER BY SUM(OrderQuantity) ASC) AS Ranking,
	DENSE_RANK() OVER (ORDER BY SUM(OrderQuantity) ASC) AS Dens_Ranking,
	SUM(OrderQuantity) AS SumQuantity
FROM FactInternetSales
GROUP BY ProductKey) AS Subquery
WHERE Dens_Ranking < 6;

-- top 5 ordered products

SELECT *,Subquery.ProductKey, Subquery.Dens_Ranking
FROM
(SELECT
	ProductKey,
	RANK() OVER (ORDER BY SUM(OrderQuantity) ASC) AS Ranking,
	DENSE_RANK() OVER (ORDER BY SUM(OrderQuantity) DESC) AS Dens_Ranking,
	SUM(OrderQuantity) AS SumQuantity
FROM FactInternetSales
GROUP BY ProductKey) AS Subquery
WHERE Dens_Ranking < 6;



--id klienta oraz id i date ostatniego zamowienia 

SELECT* FROM(
 SELECT CustomerKey, ProductKey, OrderDate,
	ROW_NUMBER() OVER (PARTITION BY CustomerKey ORDER BY OrderDate DESC) AS Ranking,
	RANK() OVER (PARTITION BY CustomerKey ORDER BY OrderDate DESC) AS Ranking1,
	DENSE_RANK() OVER (PARTITION BY CustomerKey ORDER BY OrderDate DESC) AS Ranking2
FROM FactInternetSales)rnk
WHERE Ranking2 = 2

--drugie rozwiaznei powyzszego zadania

	select CustomerKey, MAX(OrderDate) AS latestOrder
	from FactInternetSales
	Group by CustomerKey
	order by CustomerKey