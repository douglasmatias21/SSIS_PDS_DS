USE [SSIS_PDS];
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/10/2019 12:27:40 AM ******/

DROP PROCEDURE dbo.usp_LoadSSISConfigurations;
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/10/2019 12:27:40 AM ******/

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO




CREATE PROCEDURE dbo.usp_LoadSSISConfigurations
AS
    BEGIN

/*****************************************************************************************************************
NAME:    dbo.usp_LoadSSISConfigurations
PURPOSE: Load the SSIS Configurations table

MODIFICATION LOG:
Ver      Date        Author           Description
-------  ----------  ---------------  ------------------------------------------------------------------------
1.0      11/03/2019  JJAUSSI          1. Created this process for LDS BC IT243
1.1      11/09/2019  JJAUSSI          1. Added conn_DFNB3
1.1		 03/04/2020  Bruno	          2. 4.4		
1.2		04/06/2020	 Bruno			  3. 7.2 		 	
1.3		04/06/2020	 Bruno			  4. 7.3


RUNTIME: 
approx 5 sec

NOTES:  
Load configured variable values for these levels...
1) System
2) Solution
3) Package


Loads configuration managers for common configuration managers used in template package

Connect strings are loaded with passwords to allow for automation of SSIS ETL based packages

EXEC	dbo.usp_LoadSSISConfigurations;
SELECT c.*
FROM	dbo.[SSIS Configurations] AS c;
         
******************************************************************************************************************/

        TRUNCATE TABLE dbo.[SSIS Configurations];


        -- 1) Common Configurations

        DELETE FROM dbo.[SSIS Configurations]
         WHERE ConfigurationFilter = 'CommonConfigurations';


        -- 1.1) conn_EXM

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'CommonConfigurations'
             , 'Data Source=localhost;Initial Catalog=EXM;Provider=SQLNCLI11;Integrated Security=SSPI;'
             , '\Package.Variables[User::conn_EXM].Properties[Value]'
             , 'String'
              );
		  
        -- 1.2) conn_DFBN3

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'CommonConfigurations'
             , 'Data Source=localhost;Initial Catalog=DFNB3;Provider=SQLNCLI11;Integrated Security=SSPI;'
             , '\Package.Variables[User::conn_DFNB3].Properties[Value]'
             , 'String'
              );

        --1.3) conn_SSIS_PDS

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'CommonConfigurations'
             , 'Data Source=localhost;Initial Catalog=SSIS_PDS;Provider=SQLNCLI11;Integrated Security=SSPI;'
             , '\Package.Variables[User::conn_SSIS_PDS].Properties[Value]'
             , 'String'
              );
		 


        -- 2) Solution Level Configurations


        -- 2.1) LDSBC_IT243_bf

        DELETE FROM dbo.[SSIS Configurations]
         WHERE ConfigurationFilter = 'LDSBC_IT243_bf';
	

        -- 2.1.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'LDSBC_IT243_bf'
             , 'C:\Users\brunodifreitas\Desktop\GIT Repository\DFNB_src\txt_files\'
             , '\Package.Variables[User::v_data_share_root].Properties[Value]'
             , 'String'
              );





		  	

        -- 3) Package level configurations


        -- 3.1) SSIS_PDS_Template

        DELETE FROM dbo.[SSIS Configurations]
         WHERE ConfigurationFilter = 'SSIS_PDS_Template';
	

        -- 3.1.1) v_data_share_root

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'SSIS_PDS_Template'
             , 'C:\Users\brunodifreitas\Desktop\GIT Repository\DFNB_src\txt_files\'
             , '\Package.Variables[User::v_data_share_root].Properties[Value]'
             , 'String'
              );


        -- 3.2 LOAD DFNB3

        DELETE FROM dbo.[SSIS Configurations]
         WHERE ConfigurationFilter = 'LoadDFNB3_bf';

        -- 3.2.1 Root DFNB3

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'LoadDFNB3_bf'
             , 'C:\Users\brunodifreitas\Desktop\GIT Repository\DFNB_src\txt_files\'
             , '\Package.Variables[User::v_data_share_root].Properties[Value]'
             , 'String'
              );

 -- 3.3 LOAD EXM

        DELETE FROM dbo.[SSIS Configurations]
         WHERE ConfigurationFilter = 'LoadEXM_bf';

        -- 3.3.1 Root EXM

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'LoadEXM_bf'
             , 'C:\Users\brunodifreitas\Desktop\GIT Repository\EXM\txt_files'
             , '\Package.Variables[User::v_data_share_root].Properties[Value]'
             , 'String'
              );

			  
 -- 3.4 LOAD LoadNAICSCodeHierDim_bf

        DELETE FROM dbo.[SSIS Configurations]
         WHERE ConfigurationFilter = 'LoadNAICSCodeHierDim_bf';

        -- 3.3.1 Root LoadNAICSCodeHierDim_bf

        INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                            , ConfiguredValue
                                            , PackagePath
                                            , ConfiguredValueType)
        VALUES
              (
               'LoadNAICSCodeHierDim_bf'
             , 'C:\Users\brunodifreitas\Desktop\GIT Repository\DFNB_dw\xls_files'
             , '\Package.Variables[User::v_data_share_root].Properties[Value]'
             , 'String'
              );





    END;

GO