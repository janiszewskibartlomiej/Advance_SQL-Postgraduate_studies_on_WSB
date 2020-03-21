USE [SuperstoreDW]
GO


CREATE TABLE dbo.DIM_CUSTOMER(
	CustomerKey bigint NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED ,
	CustomerID	varchar(8) NOT NULL,
	FirstName	varchar(50) NOT NULL,
	LastName	varchar(50) NOT NULL,
	DOB			date NOT NULL,
	Country		varchar(20) NOT NULL,
	City		varchar(25) NOT NULL,
	PostalCode	varchar(6) NOT NULL,
	Address		varchar(50) NOT NULL,
	ValidFrom	datetime NOT NULL,
	ValidTo		datetime NOT NULL,
	Status		varchar(1) NOT NULL,
	DateInserted datetime NOT NULL
) 
GO

ALTER TABLE dbo.DIM_CUSTOMER 
ADD CONSTRAINT UK_Customer UNIQUE (CustomerID, ValidFrom, ValidTo, Status);  




