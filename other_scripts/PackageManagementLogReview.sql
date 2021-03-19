/*****************************************************************************************************************
NAME:    PackageManagementLogReview
PURPOSE: Ad Hoc quieries used to review the Package Management logs

MODIFICATION LOG:
Ver      Date        Author           Description
-------  ----------  ---------------  ------------------------------------------------------------------------
1.0      11/03/2019  JJAUSSI          1. Created this script for LDS BC IT243


NOTES:  
See Chapter 2 of this book for more details...

Microsoft SQL Server 2008 Integration Services: Problem, Design, Solution
ISBN: 978-0-470-52576-0
      
******************************************************************************************************************/

-- 1) Review Package Task Log details

	SELECT p.PackageID
		 , p.PackageName
		 , pl.*
		 , ptl.*
		 , CONVERT(TIME, ptl.EndDateTime - ptl.StartDateTime) AS DurationSeconds
	  FROM dbo.Package AS p
		   INNER JOIN
		   dbo.PackageVersion AS pv ON p.PackageID = pv.PackageID
		   INNER JOIN
		   dbo.PackageLog AS pl ON pl.PackageVersionID = pv.PackageVersionID
		   INNER JOIN
		   dbo.PackageTaskLog AS ptl ON ptl.PackageLogID = pl.PackageLogID
	 WHERE 1 = 1
		   --AND BatchLogID = 3
		   --AND p.PackageName = 'SSIS_PDS_TEMPLATE_BF'
	 ORDER BY ptl.StartDateTime DESC;





-- 2) Review Package Error Log details

SELECT p.PackageID
     , p.PackageName
     , pl.*
     , pel.*
  FROM dbo.Package AS p
       INNER JOIN
       dbo.PackageVersion AS pv ON p.PackageID = pv.PackageID
       INNER JOIN
       dbo.PackageLog AS pl ON pl.PackageVersionID = pv.PackageVersionID
       INNER JOIN
       dbo.PackageErrorLog AS pel ON pel.PackageLogID = pl.PackageLogID
 --WHERE BatchLogID = 22278   
 ORDER BY LogDateTime DESC;
 




-- 3) Performance Tuning Analysis

-- Find longest running packages from a specific batch

SELECT TOP 20 pkg.PackageName
            , CONVERT(CHAR, MAX(CONVERT(TIME, pkglog.EndDateTime - pkglog.StartDateTime)), 8) AS DurationHHMMSS
  FROM dbo.PackageLog AS pkglog
       JOIN
       dbo.PackageVersion AS pkgvers ON pkglog.PackageVersionID = pkgvers.PackageVersionID
       JOIN
       dbo.Package AS pkg ON pkgvers.PackageID = pkg.PackageID
 WHERE pkglog.STATUS = 'S'
       AND pkglog.BatchLogID > 685
 --   and pkg.PackageName like 'ImportEDW%'
 GROUP BY pkg.PackageName
 ORDER BY MAX(CONVERT(TIME, pkglog.EndDateTime - pkglog.StartDateTime)) DESC;




 
-- 4) List all package runs for a single package with most recent run at top

SELECT pkglog.StartDateTime
     , pkg.PackageName
     , CONVERT(TIME, pkglog.EndDateTime - pkglog.StartDateTime) AS DurationSeconds
     , pkglog.STATUS
  FROM dbo.PackageLog AS pkglog
       JOIN
       dbo.PackageVersion AS pkgvers ON pkglog.PackageVersionID = pkgvers.PackageVersionID
       JOIN
       dbo.Package AS pkg ON pkgvers.PackageID = pkg.PackageID
 WHERE pkg.PackageName = 'BulkImportER_SVAAccountSVA' 
 ORDER BY pkglog.StartDateTime DESC;