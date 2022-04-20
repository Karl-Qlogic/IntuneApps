$Path = "C:\Users\kalmq\OneDrive - QLOGIC AB\Dokument\EndPoint Manager\Git-IntuneApps\1Password\1Password.txt"
$values = Get-Content $Path | Out-String | ConvertFrom-StringData
echo $values.ShortName
echo $values.Description
echo $values.MinimumOSVersion
echo $values.Category
echo $values.InstallParameters
echo $values.InstallerUrl