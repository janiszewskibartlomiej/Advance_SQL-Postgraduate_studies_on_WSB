USE SuperstoreDW
go
create or alter procedure dbo.proc_DimProductLoad
AS

declare @NewValidFrom datetime

BEGIN
-- 01. Insert new records which do not exist

set @NewValidFrom = getdate()

    insert into dbo.Dim_Product
    (
		ProductID,
		Category,
		SubCategory,
		ProductName,
		ValidFrom,
		ValidTo,
		Status,
		DateInserted
	)
    select 
		ps.ProductID,
		ps.Category,
		ps.SubCategory,
		ps.ProductName,
        @NewValidFrom as ValidFrom,
        '9999-12-31 00:00:00.000' as ValidTo,
		'A' as Status,
		getdate() as DateInserted
    from SuperstoreLanding.dbo.DIM_PRODUCT_LANDING ps 
    left join dbo.Dim_Product dp
        on dp.ProductId = ps.ProductId
    where dp.ProductKey is null

-- 02. close off existing records that have changed

    update dbo.Dim_Product
    set ValidTo = DATEADD(second,-1,@NewValidFrom),
		Status = 'I'
	 
    from dbo.Dim_Product dp 
    left join SuperstoreLanding.dbo.DIM_PRODUCT_LANDING ps 
        on dp.ProductId = ps.ProductId
        and dp.ValidTo = '9999-12-31 00:00:00.000'
    where 
        ps.Category <> dp.Category
        or ps.SubCategory <> dp.SubCategory
		or ps.ProductName <> dp.ProductName

-- 03. Insert new updated records

    insert into dbo.Dim_Product
    (
		ProductID,
		Category,
		SubCategory,
		ProductName,
		ValidFrom,
		ValidTo,
		Status,
		DateInserted
	)
    select 
		ps.ProductID,
		ps.Category,
		ps.SubCategory,
		ps.ProductName,
        @NewValidFrom as ValidFrom,
        '9999-12-31 00:00:00.000' as ValidTo,
		'A' as Status,
		getdate() as DateInserted
    from SuperstoreLanding.dbo.DIM_PRODUCT_LANDING ps 
    left join dbo.Dim_Product dp
        on dp.ProductId = ps.ProductId
		and dp.ValidTo = DATEADD(second,-1,@NewValidFrom) 
    where 
        ps.Category <> dp.Category
        or ps.SubCategory <> dp.SubCategory
		or ps.ProductName <> dp.ProductName

END
GO
