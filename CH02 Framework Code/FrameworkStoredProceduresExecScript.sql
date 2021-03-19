exec dbo.LogPackageStart
@BatchLogID = ?
,@PackageName = ?
,@ExecutionInstanceID = ?
,@MachineName = ?
,@UserName = ?
,@StartDatetime = ?
,@PackageVersionGUID = ?
,@VersionMajor = ?
,@VersionMinor = ?
,@VersionBuild = ?
,@VersionComment = ?
,@PackageGUID = ?
,@CreationDate = ?
,@CreatedBy = ?

exec dbo.LogPackageEnd
@PackageLogID = ?
,@BatchLogID = ?
,@EndBatchAudit = ?

exec dbo.LogPackageError
@PackageLogID = ?
,@BatchLogID = ?
,@SourceName = ?
,@SourceID = ?
,@ErrorCode = ?
,@ErrorDescription = ?
,@EndBatchAudit = ?

exec dbo.LogTaskPreExecute
@PackageLogID = ?
,@SourceName = ?
,@SourceID = ?
,@PackageID = ?

exec dbo.LogTaskPostExecute
@PackageLogID = ?
,@SourceID = ?
,@PackageID = ?

exec dbo.LogVariableValueChanged
@PackageLogID = ?
,@VariableName = ?
,@VariableValue = ?
