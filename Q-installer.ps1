param([string]$InstallerUrl, 
    [string]$QInstallFileLocation, 
    [string]$InstallerSha256)

####Installer Here####

#Get Q-Logger
function Write-Qlog {
    param (
        [string]$QlogMessage
    )
    powershell.exe -file "$PSScriptRoot\Q-Logger.ps1" $QlogMessage
}

#Get Sha256
$wc = [System.Net.WebClient]::new()
$URLFileSha256 = Get-FileHash -InputStream ($wc.OpenRead($InstallerUrl))

If ($URLFileSha256.Hash -eq $InstallerSha256) {

    #Download File
    Write-QLog("File Downloading...")
(New-Object Net.WebClient).DownloadFile($InstallerUrl, $QInstallFileLocation)
    Write-QLog("File Download ended")

    #Get extension
    $EXEextn = [IO.Path]::GetExtension($QInstallFileLocation)

    #### Check extension ####

    ### EXE ###
    if ($EXEextn -eq ".exe") {

        Write-QLog("")
        Write-QLog("Starting EXE Install")
        # Start-Process -FilePath $QInstallFileLocation -ArgumentList $InstallParameters -Wait -WindowStyle Hidden
        Write-QLog("EXE Install ended")

    }### MSI ####
    elseif ($EXEextn -eq ".msi") {

        Write-QLog("Starting MSI Install")

    }#### MISSINGO ####
    else {
        Write-QLog("The downloaded file is not .exe or .msi")
    }

}
else {
    ######## WARNING ######## 
    #### SHA NOT EQUAL TO SHA ####
    ######## WARNING ######## 
    Write-QLog(("Sha256 is wrong`n" + "Recipee Sha256 : " + $InstallerSha256 + "`nURLSha256 : " + $URLFileSha256.Hash))
}