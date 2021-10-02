$assemblylist =   
"Microsoft.SqlServer.Management.Common",  
"Microsoft.SqlServer.Smo",  
"Microsoft.SqlServer.Dmf ",  
"Microsoft.SqlServer.Instapi ",  
"Microsoft.SqlServer.SqlWmiManagement ",  
"Microsoft.SqlServer.ConnectionInfo ",  
"Microsoft.SqlServer.SmoExtended ",  
"Microsoft.SqlServer.SqlTDiagM ",  
"Microsoft.SqlServer.SString ",  
"Microsoft.SqlServer.Management.RegisteredServers ",  
"Microsoft.SqlServer.Management.Sdk.Sfc ",  
"Microsoft.SqlServer.SqlEnum ",  
"Microsoft.SqlServer.RegSvrEnum ",  
"Microsoft.SqlServer.WmiEnum ",  
"Microsoft.SqlServer.ServiceBrokerEnum ",  
"Microsoft.SqlServer.ConnectionInfoExtended ",  
"Microsoft.SqlServer.Management.Collector ",  
"Microsoft.SqlServer.Management.CollectorEnum",  
"Microsoft.SqlServer.Management.Dac",  
"Microsoft.SqlServer.Management.DacEnum",  
"Microsoft.SqlServer.Management.Utility",
    "Microsoft.SqlServer.Management.Smo"
foreach ($asm in $assemblylist)  
{  
    $asm = [Reflection.Assembly]::LoadWithPartialName($asm)  
}  
    $conn = new-object Microsoft.SqlServer.Management.Common.ServerConnection("{sql server instance name}","{sql user name}","{password}")

$srv = new-object Microsoft.SqlServer.Management.Smo.Server($conn)

Write-Host $srv.Information.Version

$db = New-Object Microsoft.SqlServer.Management.Smo.Database($srv, "{database name}") 
 



## Set a SMO Server object to the default instance on the local computer.  
CD SQLSERVER:\SQL\localhost\DEFAULT  
$srv = get-item .  
  
## Specify the database to extract to a DAC.  
$dbname = "MyDB"  
  
## Specify the DAC metadata.  
$applicationname = "MyApplication"  
$version = "1.0.0.0"  
$description = "This DAC defines the database used by my application."  
  
## Specify the location and name for the extracted DAC package.  
$dacpacPath = "C:\MyDACs\MyApplication.dacpac"  
  
## Extract the DAC.  
$extractionunit = New-Object Microsoft.SqlServer.Management.Dac.DacExtractionUnit($srv, $dbname, $applicationname, $version)  
$extractionunit.Description = $description  
$extractionunit.Extract($dacpacPath)

$srv.KillAllProcesses($db)
$srv.databases[$db.Name].drop()
