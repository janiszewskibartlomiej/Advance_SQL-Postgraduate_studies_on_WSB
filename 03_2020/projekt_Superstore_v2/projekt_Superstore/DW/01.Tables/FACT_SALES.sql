USE SuperstoreDW
GO

CREATE TABLE dbo.FACT_SALES(
	SalesKey		 int NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	OrderID			 varchar(14) NOT NULL,
	OrderDate		 date NOT NULL,
	ShipDate		 date NOT NULL,
	ProductKey		 int NOT NULL,
	Price			 varchar(20) NOT NULL,
	Quantity		 varchar(14) NOT NULL,
	Discount		 varchar(10) NOT NULL,
	SalesQuota		 varchar(20) NOT NULL,
	CustomerKey		 bigint NULL,
	Returned		 varchar(1) NOT NULL
) 

GO

ALTER TABLE dbo.FACT_SALES  
ADD CONSTRAINT FK_DIM_PRODUCT FOREIGN KEY (ProductKey)     
    REFERENCES dbo.DIM_PRODUCT (ProductKey)     
    ON DELETE CASCADE    
    ON UPDATE CASCADE 
	
	   



