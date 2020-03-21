SET IDENTITY_INSERT dbo.DIM_CUSTOMER ON;
INSERT INTO [dbo].[DIM_CUSTOMER] (CustomerKey,[CustomerID],[FirstName] ,[LastName] ,[DOB] ,[Country] ,[City] ,[PostalCode] ,[Address] ,[ValidFrom] ,[ValidTo],[Status],DateInserted)
VALUES (-1,'Unk','Unknown','Unknown','99990101','Unknown','Unknown' ,'00-000','Unknown'  , getdate(),'9999-12-31','A', getdate())
SET IDENTITY_INSERT dbo.DIM_CUSTOMER OFF;

SET IDENTITY_INSERT dbo.DIM_PRODUCT ON;
INSERT INTO [dbo].[DIM_PRODUCT](ProductKey, [ProductID],[Category],[SubCategory],[ProductName],[ValidFrom],[ValidTo],[Status],[Dateinserted])
     VALUES (-1,'Unk','Unknown','Unknown','Unknown','2000-01-01','9999-12-31','A', getdate());
SET IDENTITY_INSERT dbo.DIM_PRODUCT OFF;