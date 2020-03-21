use SuperstoreLanding
go

CREATE OR ALTER PROC proc_LandingLoad  
@tbl nvarchar(30)
,@path nvarchar(255)
,@format nvarchar(10)


as

begin 
declare @query nvarchar(500);
set @query = 'Truncate table' + ' ' +  @tbl ;
EXEC (@query)

set @query = '
BULK INSERT' + ' ' + @tbl + ' FROM' + ' ' + '''' + @path + ''''  +'
 WITH (FORMAT='+'''' +@format +'''' +', FIRSTROW =2)';
print @query
EXEC (@query)

end 
go