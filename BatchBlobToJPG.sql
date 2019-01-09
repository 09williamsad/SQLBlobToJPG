CREATE PROCEDURE ImageExport (@query as nvarchar(max)) AS
BEGIN
    begin
	   if OBJECT_ID ('tempdb..##TempImageExport') is not null
	   begin
		  drop table ##TempImageExport
	   end
	   CREATE TABLE dbo.##TempImageExport (filename varchar(8000), imageData varbinary(max))
	   set @query = 'insert into ##TempImageExport ' + @query
	   exec sp_executesql @query

	   while exists (select top 1 filename from ##TempImageExport)
	   begin
    		  declare @filename as varchar(8000) = (select top 1 filename from ##TempImageExport)
		  declare @imageSQL as varchar(8000) = 'BCP "SELECT imageData FROM ##TempImageExport where filename = ''' + @filename + '"'' queryout "C:\exportdir\exported\' + @filename + '.jpg" -T -C RAW<C:\exportdir\config\imageExport.txt'
		  EXEC master..xp_cmdshell @imagesql
		  delete from ##TempImageExport where filename = @filename
	   end
    end
    drop table ##TempImageExport
END
