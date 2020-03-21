USE SuperstoreDW
go

create or alter procedure dbo.proc_FactSalesLoad
AS
BEGIN

-- insert orders where dimension lookup is successfull into 

insert into dbo.FACT_SALES (OrderID, OrderDate, ShipDate, ProductKey, Price, Quantity, Discount, SalesQuota, CustomerKey, Returned )

select	s.OrderID,
		s.OrderDate,
		s.ShipDate,
		dp.ProductKey,
		s.Price,
		s.Quantity,
		s.Discount,
		s.SalesQuota,
		dc.CustomerKey,
		s.Returned

from SuperstoreLanding.[dbo].[FACT_SALES_LANDING] s
left join [dbo].[DIM_CUSTOMER] dc
on s.CustomerID = dc.CustomerID and s.OrderDate between dc.ValidFrom and  dc.ValidTo
left join [dbo].[DIM_PRODUCT] dp
on s.ProductID = dp.ProductID and s.OrderDate between dc.ValidFrom and  dc.ValidTo

where 1=1
	  and dp.ProductKey is not null
	  and dc.CustomerKey is not null
;
END
GO
