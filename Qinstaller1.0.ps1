
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
$valuesString = Get-Content $QFileDest | Out-String
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