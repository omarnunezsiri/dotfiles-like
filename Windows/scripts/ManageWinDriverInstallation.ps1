# Ensure the script runs with administrative privileges
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "You need to run this script as an Administrator." -ForegroundColor Red
    Exit
}

# Check if constants are already defined
if (-not (Get-Variable WINDOWS_VER -ErrorAction SilentlyContinue)) {
    Set-Variable -Name WINDOWS_VER -Value "Home" -Option ReadOnly
}

if (-not (Get-Variable ACTIVATION_MESSAGE -ErrorAction SilentlyContinue)) {
    Set-Variable -Name ACTIVATION_MESSAGE -Value "permanently activated" -Option ReadOnly
}


# Check Windows activation status and edition using cscript
Write-Output "Checking Windows activation status and edition using cscript..."
$winStatus = try {
    (cscript /Nologo "C:\Windows\System32\slmgr.vbs" /xpr) -join ''
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit
}

# Script requires an activated version of Windows Professional or higher
if ($winStatus -match $WINDOWS_VER -or $winStatus -notmatch $ACTIVATION_MESSAGE) {
    Write-Host "This script requires at least a version of Windows Professional that is permanently activated. Please upgrade before proceeding." -ForegroundColor Red
    exit
} else {
    Write-Host "Windows is activated and running a version of Windows Pro or higher." -ForegroundColor Green
}

# Disable driver installation via Windows Update
Write-Host "Disabling driver installation via Windows Update..." -ForegroundColor Gray

# Create or modify the registry key to disable driver installation from Windows Update
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$propertyName = "ExcludeWUDriversInQualityUpdate"
$propertyValue = 1

# Check if the registry key exists, if not, create it
if (-Not (Test-Path $registryPath -ErrorAction SilentlyContinue)) {
    New-Item -Path $registryPath -Force -ErrorAction Stop | Out-Null
}

# Set the registry value to disable driver installation
New-ItemProperty -Path $registryPath -Name $propertyName -Value $propertyValue -PropertyType DWORD -Force -ErrorAction Stop | Out-Null

Write-Host "Driver installation via Windows Update has been disabled." -ForegroundColor Green

# Optional: Restart the Windows Update service to apply changes
Restart-Service wuauserv -Force -ErrorAction Stop
Write-Host "Windows Update service has been restarted to apply changes." -ForegroundColor Green