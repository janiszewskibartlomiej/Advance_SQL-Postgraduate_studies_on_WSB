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
        getdate() as ValidFrom,
        '9999-12-31 00:00:00.000' as ValidTo,
		'A' as Status,
		getdate() as DateInserted
    from SuperstoreLanding.[dbo].[DIM_CUSTOMER_LANDING] ps 
    left join dbo.Dim_Customer dp
        on dp.CustomerId = ps.CustomerId
    where dp.CustomerKey is null  -- pomaga bo nie dublujemy danych