USE [Superstore_ODS]
GO

INSERT INTO [dbo].[SALES_STG]
           ([OrderID],[OrderDate],[ShipDate],[ProductID],[Price],[Quantity],[Discount],[SalesQuota],[CustomerID],[Returned])
     VALUES('SU22323','2019-02-01','2019-02-02','PL7654','9500',1,0,null,'1235','N')

INSERT INTO [dbo].[SALES_STG]
           ([OrderID],[OrderDate],[ShipDate],[ProductID],[Price],[Quantity],[Discount],[SalesQuota],[CustomerID],[Returned])
     VALUES('SU12323','2018-02-01','2018-02-02','PL9876','2500',1,0,null,'1234','N')

GO


