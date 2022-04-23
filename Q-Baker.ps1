
$Qsource = ("https://raw.githubusercontent.com/Karl-Qlogic/IntuneApps/main/1Password/1Password.txt")

$QScriptInstallerFolder = "C:\QlogicScripts\Qinstaller\"


#Send log to Q-Logger
function Write-Qlog {
    param (
        [string]$QlogMessage
    )
    powershell.exe -file "$PSScriptRoot\Q-Logger.ps1" $QlogMessage
}

#Start Q-Installer
function Start-QInstaller {
    param (
        [string]$InstallerUrl,
        [string]$QInstallFileLocation,
        [string]$InstallerSha256
    )

    $QArguments = "-InstallerUrl $InstallerUrl -QInstallFileLocation $QInstallFileLocation -InstallerSha256 $InstallerSha256"

    powershell.exe -file "$PSScriptRoot\Q-Installer.ps1" $QArguments

}

#Download QRecipe
$QRecipeFileName = [System.IO.Path]::GetFileName($Qsource)
$QRecipeFileLocation = ($QInstallerFolder + $QRecipeFileName)
(New-Object Net.WebClient).DownloadFile($Qsource, $QRecipeFileLocation)

#Get variables from QRecipe
$valuesString = Get-Content $QRecipeFileLocation | Out-String
# https://stackoverflow.com/questions/24142436/powershell-parsing-a-properties-file-that-contains-colons#:~:text=Here%27s%20how%20to%20fix%20your%20code%3A
$StringToConvert = $valuesString -replace '\\', '\\'
$values = ConvertFrom-StringData $StringToConvert


$ShortName = $values.ShortName
$LongName = $values.LongName
$Description = $values.Description
$Publisher = $values.Publisher
$AppVersion = $values.AppVersion
$MinimumOSVersion = $values.MinimumOSVersion
$Category = $values.Category
$LogoUrl = $values.LogoUrl
$InstallParameters = $values.InstallParameters
$Detection = $values.Detection
$UninstallerLocation = $values.UninstallerLocation
$UninstallParameters = $values.UninstallParameters
$InstallerUrl = $values.InstallerUrl
$InstallerSha256 = $values.InstallerSha256

#Get Filename
$QFileName = [System.IO.Path]::GetFileName($InstallerUrl)
$QInstallerFolder = ($QScriptInstallerFolder + ($QFileName -replace ".{4}$") + "\")
$QInstallFileLocation = ($QInstallerFolder + $QFileName)
#Create folder
if (test-path -path $QInstallerFolder -PathType Container) {
   
}
else {
    New-Item -ItemType Directory -Path $QInstallerFolder -Force
}



Write-Host "ShortName              "$ShortName
Write-Host "LongName               "$LongName
Write-Host "Description            "$Description
Write-Host "Publisher              "$Publisher
Write-Host "AppVersion             "$AppVersion
Write-Host "MinimumOSVersion       "$MinimumOSVersion
Write-Host "Category               "$Category
Write-Host "LogoUrl                "$LogoUrl
Write-Host "InstallParameters      "$InstallParameters
Write-Host "Detection              "$Detection
Write-Host "UninstallerLocation    "$UninstallerLocation
Write-Host "UninstallParameters    "$UninstallParameters
Write-Host "InstallerUrl           "$InstallerUrl


Write-QLog("`n`nStart New Log")
## Installer ##

Start-QInstaller($InstallerUrl, $QInstallFileLocation, $InstallerSha256)

#Place Uninstaller Here