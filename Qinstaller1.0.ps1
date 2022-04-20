
$Qsource = "https://raw.githubusercontent.com/Karl-Qlogic/IntuneApps/main/1Password/1Password.txt"
$QFileName = [System.IO.Path]::GetFileName($Qsource)
$QFolderDest = "C:\QlogicScripts\Qinstaller\"
$QFileDest = ($QFolderDest + $QFileName)

#Create folder
if (test-path -path $QFolderDest -PathType Container) {
    
}
else {
    New-Item -ItemType Directory -Path $QFolderDest -Force
}

#Download QRecipe
(New-Object Net.WebClient).DownloadFile($Qsource, $QFileDest)

#Get variables from QRecipe
$values = Get-Content $QFileDest | Out-String | ConvertFrom-StringData

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



echo $ShortName
echo $LongName
echo $Description
echo $Publisher
echo $AppVersion
echo $MinimumOSVersion
echo $Category
echo $LogoUrl
echo $InstallParameters
echo $Detection
echo $UninstallerLocation
echo $UninstallParameters
echo $InstallerUrl