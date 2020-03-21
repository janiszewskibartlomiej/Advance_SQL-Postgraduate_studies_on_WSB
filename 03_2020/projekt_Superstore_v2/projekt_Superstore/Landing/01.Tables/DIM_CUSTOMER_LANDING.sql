USE [SuperstoreLanding]
GO
SET ANSI_NULLS ON  
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_PADDING ON 
GO

CREATE TABLE dbo.DIM_CUSTOMER_LANDING(
	CustomerID	varchar(8) NOT NULL,
	FirstName	varchar(50) NOT NULL,
	LastName	varchar(50) NOT NULL,
	DOB			date NOT NULL,
	Country		varchar(20) NOT NULL,
	City		varchar(25) NOT NULL,
	PostalCode	varchar(6) NOT NULL,
	Address		varchar(50) NOT NULL
) 
GO

 


