param([string]$QlogMessage)

$QAppFolderName = (Split-Path -Path (Get-Location) -Leaf)

#$QLog = "C:\QlogicScripts\Qinstaller\$QAppFolderName.txt"

$QLog = "C:\QlogicScripts\Qinstaller\1PasswordSetup-8.6.1\1PasswordSetup-8.6.1LOG.txt"

if ($QLogMessage -eq "") {
    $QLogEmpty = "EMPTY LOG MESSAGE"
}
else {
    $QLogEmpty = ""
}
$ErrorDate = (Get-Date -format "u")
$QlogText = ($QLogMessage + $QLogEmpty)
$QTextAndTime = ($QlogText + "`t`t`t`t`t - `t" + $ErrorDate) 

#If file is larger than 1mb, reset size
if ((Get-Item $QLog).Length / 1mb -le 1) {
    $QTextAndTime | Out-File -FilePath $QLog -Append
}
else {
    $QTextAndTime | Out-File -FilePath $QLog
}
