USE [SuperstoreLanding]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE dbo.DIM_PRODUCT_LANDING(
	ProductID		varchar(16) NOT NULL,
	Category		varchar(20) NOT NULL,
	SubCategory		varchar(20) NOT NULL,
	ProductName		varchar(200) NOT NULL
) 
GO




