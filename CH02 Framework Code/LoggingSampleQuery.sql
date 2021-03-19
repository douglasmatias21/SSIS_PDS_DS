select pkg.PackageName
	,convert(time,pkglog.EndDateTime - pkglog.StartDateTime) as DurationSeconds
	,pkglog.Status
from dbo.PackageLog pkglog
join dbo.PackageVersion pkgvers on pkglog.PackageVersionID=pkgvers.PackageVersionID
join dbo.Package pkg on pkgvers.PackageID=pkg.PackageID
order by pkglog.StartDateTime desc
