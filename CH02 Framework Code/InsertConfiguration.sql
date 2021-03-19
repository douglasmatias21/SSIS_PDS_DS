INSERT INTO [dbo].[SSIS Configurations]
    ([ConfigurationFilter]
    ,[ConfiguredValue]
    ,[PackagePath]
    ,[ConfiguredValueType])
VALUES
     ('CommonConfigurations'
    ,'Data Source=localhost;Initial Catalog=AdventureWorksDW2008;Provider=SQLNCLI10.1;Integrated Security=SSPI;'
    ,'\Package.Variables[User::connAdventureWorksDW2008].Properties[Value]'
    ,'String')
