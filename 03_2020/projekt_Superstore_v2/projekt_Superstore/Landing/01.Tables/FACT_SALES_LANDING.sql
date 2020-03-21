USE [SuperstoreLanding]
GO

CREATE TABLE dbo.FACT_SALES_LANDING(
	[OrderID] [varchar](14) ,
	[OrderDate] [datetime] ,
	[ShipDate] [datetime] ,
	[ProductID] [varchar](16) ,
	[Price] [varchar](20) ,
	[Quantity] [varchar](14) ,
	[Discount] [varchar](10) ,
	[SalesQuota] [varchar](20) ,
	[CustomerID] nvarchar(8) ,
	[Returned] [varchar](1) )