USE SuperstoreDW
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.DIM_DATE(
	DateKey date NOT NULL,
	Day int NULL,
	Month int NULL,
	Year int NULL,
	Quarter int NULL,
	MonthName [nvarchar](30) NULL,
	DayName [nvarchar](30) NULL,
	DayOfYear int NULL,
	Week int NULL,
	WeekDay int NULL
) 
GO

ALTER TABLE dbo.DIM_DATE  
ADD CONSTRAINT PK_DateKey PRIMARY KEY CLUSTERED (DateKey); 

ALTER TABLE dbo.DIM_DATE  ADD WeekDayName varchar(15);







