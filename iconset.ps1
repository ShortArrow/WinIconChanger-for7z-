# Powershell version check
($PSVersionTable)["PSVersion"]
# Administrator authorization Check
if (-not(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator" ))) {
	Write-Host "+++++++++ Administrator authorization is required +++++++++" -ForegroundColor White -BackgroundColor Red
	Write-Host "Install failured!!"
	Write-Host "You can close this window by anykey"
	return
}

$iconDir = "C:\gficons"
$iconname = "7z.ico" # same directory with this script
$Extention = "7-Zip.7z"
$rootExtention = ".7z"

# regedit
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention"
Remove-Item -Path $RegPath -Force -Recurse
New-Item -Path $RegPath
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\DefaultIcon"
New-Item $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value $iconDir\$iconname -propertyType ExpandString
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\shell\"
New-Item -Path $RegPath
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\shell\open"
New-Item -Path $RegPath
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\shell\open\command"
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value """C:\Program Files\7-Zip\7zFM.exe"" ""%1""" -propertyType String

# HKEY_CLASSES_ROOT
# HKEY_CLASSES_ROOT\.7z  7-Zip.7z
# HKEY_CLASSES_ROOT\7-Zip.7z\DefaultIcon C:\Program Files\7-Zip\7z.dll, 0
# HKEY_CLASSES_ROOT\7-Zip.7z\shell\open\command "C:\Program Files\7-Zip\7zFM.exe" "%1"
# Remove
$RegPath = "Registry::HKEY_CLASSES_ROOT\$rootExtention"
Remove-Item -Path $RegPath -Force -Recurse
# Make
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value $Extention -propertyType ExpandString
# Remove
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention"
Remove-Item -Path $RegPath -Force -Recurse
# Make
New-Item -Path $RegPath
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\DefaultIcon"
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value $iconDir\$iconname -propertyType ExpandString
$RegPath = "Registry::HKEY_CLASSES_ROOT\$Extention\shell"
New-Item -Path $RegPath
$RegPath = "$RegPath\open"
New-Item -Path $RegPath
$RegPath = "$RegPath\command"
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value "C:\Program Files\7-Zip\7zFM.exe"" ""%1" -propertyType ExpandString

# HKEY_LOCAL_MACHINE
# HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.7z 7-Zip.7z
# HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.7z\DefaultIcon C:\Program Files\7-Zip\7z.dll, 0
# HKEY_LOCAL_MACHINE\SOFTWARE\Classes\7-Zip.7z\shell\open\command "C:\Program Files\7-Zip\7zFM.exe" "%1"
# Remove
$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$rootExtention"
Remove-Item -Path $RegPath -Force -Recurse
# Make
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value $Extention -propertyType ExpandString
# Remove
$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$Extention"
Remove-Item -Path $RegPath -Force -Recurse
# Make
New-Item -Path $RegPath
$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$Extention\DefaultIcon"
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value $iconDir\$iconname -propertyType ExpandString
$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$Extention\shell"
New-Item -Path $RegPath
$RegPath = "$RegPath\open"
New-Item -Path $RegPath
$RegPath = "$RegPath\command"
New-Item -Path $RegPath
New-ItemProperty -Path $RegPath -name "(default)" -Value "C:\Program Files\7-Zip\7zFM.exe"" ""%1" -propertyType ExpandString

# icon file set
Remove-Item $iconDir\ -Force -Recurse
New-Item $iconDir -ItemType Directory
Copy-Item .\$iconname -Destination $iconDir\$iconname -Force -Recurse

Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "Install finished, You can close this window by anykey"