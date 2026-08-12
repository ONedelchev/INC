     USE NN;                                                                                                                                     
     GO                                                                                                                                          
                                                                                                                                                 
     DECLARE @name NVARCHAR(517), @sql NVARCHAR(MAX);                                                                                            
                                                                                                                                                 
     DECLARE cur CURSOR FOR                                                                                                                      
     SELECT QUOTENAME(s.name) + N'.' + QUOTENAME(t.name)                                                                                         
     FROM sys.tables t                                                                                                                           
     JOIN sys.schemas s ON s.schema_id = t.schema_id;                                                                                            
                                                                                                                                                 
     OPEN cur;                                                                                                                                   
     FETCH NEXT FROM cur INTO @name;                                                                                                             
     WHILE @@FETCH_STATUS = 0                                                                                                                    
     BEGIN                                                                                                                                       
         SET @sql = N'SELECT ''' + @name + N''' AS [TableName]; SELECT TOP 3 * FROM ' + @name + N';';                                            
         EXEC sp_executesql @sql;                                                                                                                
         FETCH NEXT FROM cur INTO @name;                                                                                                         
     END                                                                                                                                         
     CLOSE cur;                                                                                                                                  
     DEALLOCATE cur;             