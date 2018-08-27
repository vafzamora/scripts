param(
    [string] $name="NetPTOCollector",
    [string] $outputFolder = "",
    [switch] $start=$false
)

$counters=@(
    "\.NET CLR Data\*",
    "\.NET CLR Exceptions(*)\*",
    "\.NET CLR Loading(*)\*",
    "\.NET CLR LocksAndThreads(*)\*",
    "\.NET CLR Memory(*)\*",
    "\.NET Data Provider for SqlServer\*",
    "\ASP.NET\*",
    "\ASP.NET Applications(*)\*",
    "\ASP.NET Apps v4.30319(*)\*",
    "\ASP.NET v4.30319(*)\*",
    "\Memory\*",
    "\Process(*)\*",
    "\Processor(*)\*",
    "\Web Service(*)\*",
    "\W3SVC_W3WP(*)\*"
)

if ($outputFolder -eq "") {
    $outputFolder = Join-Path -Path $env:SystemDrive -ChildPath "\PerfLogs\Admin\"
}
$outputFolder = Join-Path -Path $outputFolder -ChildPath $name
Write-Host "Output folder: $outputFolder"

Write-Host "Configuring $name collector."
logman create counter $name -c ($counters) -o "$outputFolder\$name"
if ($start) {
    Write-Host "Starting $name collector."
    logman start $name
}