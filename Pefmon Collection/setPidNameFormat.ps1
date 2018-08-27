param(
    [switch]$off=$false
)
function setValue([string]$registryPath, $value){
    $Name = "ProcessNameFormat"
    if(!(Test-Path $registryPath))
      {
        New-Item -Path $registryPath -Force | Out-Null
      }
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
}
if (!$off) {
    setValue -registryPath "HKLM:\SYSTEM\CurrentControlSet\Services\.NETFramework\Performance" -value "1"
    setValue -registryPath "HKLM:\SYSTEM\CurrentControlSet\Services\PerfProc\Performance" -value "2"    
}else {
    setValue -registryPath "HKLM:\SYSTEM\CurrentControlSet\Services\.NETFramework\Performance" -value "0"
    setValue -registryPath "HKLM:\SYSTEM\CurrentControlSet\Services\PerfProc\Performance" -value "1"   
}

