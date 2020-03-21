USE SuperstoreDW
GO


CREATE TABLE dbo.DIM_PRODUCT(
	ProductKey		int IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED ,
	ProductID		varchar(16) NOT NULL,
	Category		varchar(20) NOT NULL,
	SubCategory		varchar(20) NOT NULL,
	ProductName		varchar(200) NOT NULL,
	ValidFrom	datetime NOT NULL,
	ValidTo		datetime NULL,
	Status		varchar(1) NOT NULL,
	DateInserted datetime NOT NULL
) 
GO

ALTER TABLE dbo.DIM_PRODUCT 
ADD CONSTRAINT UK_Product UNIQUE (ProductKey, ValidFrom, ValidTo, Status);  



