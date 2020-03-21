USE SuperstoreDW
go
create or alter procedure dbo.proc_DimCustomerLoad
AS

declare @NewValidFrom datetime

BEGIN
-- 01. Insert new records which do not exist

set @NewValidFrom = getdate()

    insert into dbo.Dim_customer
    (
		CustomerID,
		FirstName,
		LastName,
		DOB,
		Country,
		City,
		PostalCode,
		Address,
		ValidFrom,
		ValidTo,
		Status,
		DateInserted
	)
    select 
		ps.CustomerID,
		ps.FirstName,
		ps.LastName,
		ps.DOB,
		ps.Country,
		ps.City,
		ps.PostalCode,
		ps.Address,
        @NewValidFrom as ValidFrom,
        '9999-12-31 00:00:00.000' as ValidTo,
		'A' as Status,
		getdate() as DateInserted
    from SuperstoreLanding.[dbo].[DIM_CUSTOMER_LANDING] ps 
    left join dbo.Dim_Customer dp
        on dp.CustomerId = ps.CustomerId
    where dp.CustomerKey is null

-- 02. close off existing records that have changed

    update dbo.Dim_Customer
    set ValidTo = DATEADD(second,-1,@NewValidFrom),
		Status = 'I'
	 
    from dbo.Dim_Customer dp 
    left join SuperstoreLanding.[dbo].[DIM_CUSTOMER_LANDING] ps 
        on dp.CustomerId = ps.CustomerId
        and dp.ValidTo = '9999-12-31 00:00:00.000'
    where 
        ps.FirstName <> dp.FirstName
        or ps.LastName <> dp.LastName
		or ps.DOB <> dp.DOB
		or ps.Country <> dp.Country
		or ps.City <> dp.City
		or ps.PostalCode <> dp.PostalCode
		or ps.Address <> dp.Address

-- 03. Insert new updated records

    insert into dbo.Dim_Customer
    (
		CustomerID,
		FirstName,
		LastName,
		DOB,
		Country,
		City,
		PostalCode,
		Address,
		ValidFrom,
		ValidTo,
		Status,
		DateInserted
	)
    select 
		ps.CustomerID,
		ps.FirstName,
		ps.LastName,
		ps.DOB,
		ps.Country,
		ps.City,
		ps.PostalCode,
		ps.Address,
        @NewValidFrom as ValidFrom,
        '9999-12-31 00:00:00.000' as ValidTo,
		'A' as Status,
		getdate() as DateInserted
    from SuperstoreLanding.[dbo].[DIM_CUSTOMER_LANDING] ps 
    left join dbo.Dim_Customer dp
        on dp.CustomerId = ps.CustomerId
		and dp.ValidTo = DATEADD(second,-1,@NewValidFrom) 
    where 
        ps.FirstName <> dp.FirstName
        or ps.LastName <> dp.LastName
		or ps.DOB <> dp.DOB
		or ps.Country <> dp.Country
		or ps.City <> dp.City
		or ps.PostalCode <> dp.PostalCode
		or ps.Address <> dp.Address

END
GO


