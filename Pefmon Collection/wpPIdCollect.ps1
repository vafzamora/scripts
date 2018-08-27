param(
    [string] $Folder = "C:\Microsoft\IIS\", 
    [string] $FileNamePrefix = "AppPool_PID_"
)
$FileName = (Join-Path -Path $Folder -ChildPath "$FileNamePrefix$env:computername.txt")
$taskName = "IIS PID"
$cmdFile = Join-Path -Path $Folder -ChildPath "wpProcess.cmd"

if (!(Test-Path -Path $Folder)) {
    New-Item -ItemType Directory -Force -Path $Folder
}

$cmdText = "@echo %date%-%time% >> $fileName`r`n@%windir%\System32\inetsrv\appcmd list wp >> $fileName"
$cmdText|Set-Content $cmdFile

$Expires=[datetime]::Now.AddMinutes(1445)
$EndDate=$Expires.ToShortDateString()
$EndTime=$Expires.ToString("HH:mm")

$argList = @(
    "/Create",
    "/sc MINUTE",
    "/ed $EndDate",
    "/et $EndTime",
    "/tn `"$taskName`"",
    "/rl HIGHEST", 
    "/tr $cmdFile",
    "/np /f /z" 
)
Start-Process "schtasks.exe" -ArgumentList $argList -WindowStyle Hidden
