<#
Run this at a powershell prompt with administrator privileges

NOTE: On a fresh install of Windows, you may not have the permissions to execute this script
If you encounter an issue, open powershell with administrator privileges and run the following command: Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
You should now be able to run this script
You can run a Get-ExecutionPolicy and Get-ExecutionPolicy -Scope CurrentUser and double check they say Unrestricted if you want to verify

Currently, there is a function for each item that you want to install/configure
The script simply calls each function one by one
Uncomment out the functions that you would like and run the script

You can and should set the script exectution permissions back to a more secure state once you're done by uncommenting the Harden-ExecutionPolicy function call before you run the script
#>

# Silently install the latest 64 bit Chrome, confirm installation by printing exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Chrome
{
    $LocalTempDir = $env:TEMP; 
    $ChromeInstaller = "ChromeInstaller.exe"; 
    $url='http://dl.google.com/chrome/install/latest/chrome_installer.exe'; 
    $output="$LocalTempDir\$ChromeInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/silent","/install" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose
    }
}

# Silently install the latest 64 bit Firefox, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Firefox
{
    $LocalTempDir = $env:TEMP; 
    $FirefoxInstaller = "FirefoxInstaller.exe"; 
    $url='https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US'; 
    $output="$LocalTempDir\$FirefoxInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/silent","/install" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$FirefoxInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install the latest 64 bit Brave, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Brave
{
    $LocalTempDir = $env:TEMP; 
    $BraveInstaller = "BraveInstaller.exe"; 
    $url='https://laptop-updates.brave.com/latest/winx64'; 
    $output="$LocalTempDir\$BraveInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/silent","/install" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$BraveInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install the latest stable, 64 bit VSCode with the following install options: add a desktop icon, add the "open with VSCode" options for files and folders; confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-VSCode
{
    $LocalTempDir = $env:TEMP; 
    $VSCodeInstaller = "VSCodeInstaller.exe"; 
    $url='https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user'; 
    $output="$LocalTempDir\$VSCodeInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        # This is running the following command from the command-line as an administrator (YOUR INSTALLER VERSION NAME MAY VARY): VSCodeUserSetup-x64-1.68.1.exe /VERYSILENT /MERGETASKS=desktopicon,addcontextmenufiles,addcontextmenufolders,!runcode
        $p = Start-Process $output -ArgumentList "/VERYSILENT /MERGETASKS=desktopicon,addcontextmenufiles,addcontextmenufolders,!runcode" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$VSCodeInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install the latest stable, 32 bit Discord, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Discord
{
    $LocalTempDir = $env:TEMP; 
    $DiscordInstaller = "DiscordInstaller.exe"; 
    $url='https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86'; 
    $output="$LocalTempDir\$DiscordInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/silent" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$DiscordInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install Obsidian, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Obsidian
{
    $LocalTempDir = $env:TEMP; 
    $ObsidianInstaller = "ObsidianInstaller.exe"; 
    $url='https://github.com/obsidianmd/obsidian-releases/releases/download/v0.14.15/Obsidian.0.14.15.exe'; 
    $output="$LocalTempDir\$ObsidianInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/S" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$ObsidianInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install the latest Bitwarden, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Bitwarden
{
    $LocalTempDir = $env:TEMP; 
    $BitwardenInstaller = "BitwardenInstaller.exe"; 
    $url='https://vault.bitwarden.com/download/?app=desktop&platform=windows'; 
    $output="$LocalTempDir\$BitwardenInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/S" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$BitwardenInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install 64 bit 7Zip, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-7Zip
{
    $LocalTempDir = $env:TEMP; 
    $7ZipInstaller = "7ZipInstaller.exe"; 
    $url='https://www.7-zip.org/a/7z2200-x64.exe'; 
    $output="$LocalTempDir\$7ZipInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/S" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$7ZipInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install the latest 64 bit Putty, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-Putty
{
    $LocalTempDir = $env:TEMP; 
    $PuttyInstaller = "PuttyInstaller.exe"; 
    $url='https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.77-installer.msi'; 
    $output="$LocalTempDir\$PuttyInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/qn" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$PuttyInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Silently install WinSCP and choose not to restart after, confirm installation by printing the exit code to the screen (True = success) or the error message if issues occur, and remove the installer we dropped into our local TEMP directory
function Install-WinSCP
{
    $LocalTempDir = $env:TEMP; 
    $WinSCPInstaller = "WinSCPInstaller.exe"; 
    $url='https://winscp.net/download/WinSCP-5.21-Setup.exe'; 
    $output="$LocalTempDir\$WinSCPInstaller"

    try {
        (new-object System.Net.WebClient).DownloadFile($url, $output); 
        $p = Start-Process $output -ArgumentList "/VERYSILENT /NORESTART" -PassThru -Verb runas; 

        while (!$p.HasExited) { Start-Sleep -Seconds 1 }

        Write-Output ([PSCustomObject]@{Success=$p.ExitCode -eq 0;Process=$p})
    } catch {
        Write-Output ([PSCustomObject]@{Success=$false;Process=$p;ErrorMessage=$_.Exception.Message;ErrorRecord=$_})
    } finally {
        Remove-Item "$LocalTempDir\$WinSCPInstaller" -ErrorAction SilentlyContinue -Verbose
    }

}

# Remove some of the Windows bloatware. This is just a small list of possible items. Feel free to add in any items that you think will appear on your machine
function Remove-Bloatware
{ 
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.YourPhone | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.ZuneMusic | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.ZuneVideo | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.Xbox | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.XboxGameCallableUI | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.SkypeApp | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.BingWeather | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.WindowsMaps | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.Messaging | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.MicrosoftSolitareCollection | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.MixedReality.Portal | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.GetHelp | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.WindowsFeedbackHub | Remove-AppxProvisionedPackage -AllUsers
    Get-AppxProvisionedPackage -online | where displayname -Like Microsoft.People | Remove-AppxProvisionedPackage -AllUsers
}

# Show hidden files
# Unfortunately, the changes will not take effect until you have opened file explorer and refreshed it
# You can refresh it programmatically with the commented out commands below, but file explorer needs to be open for the changes to take effect
function ShowHiddenFiles 
{
	Write-Output "Showing hidden files..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
    
    
    # $Shell = New-Object -ComObject Shell.Application
    # $Shell.Windows() | ForEach-Object {$_.Refresh()}
}

# Hide hidden files
# Unfortunately, the changes will not take effect until you have opened file explorer and refreshed it
# You can refresh it programmatically with the commented out commands below, but file explorer needs to be open for the changes to take effect
function HideHiddenFiles
{
    Write-Output "Hiding hidden files..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 2
    
    
    # $Shell = New-Object -ComObject Shell.Application
    # $Shell.Windows() | ForEach-Object {$_.Refresh()}
}

# Set time-zone (in this case, Eastern Standard Time, but you can change this value to whichever time zone you want)
function SetTimeZone
{
    Set-TimeZone -Name "Eastern Standard Time"
}

# Set the script execution permissions to a more secure state now that we're done
function Harden-ExecutionPolicy
{
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted
}

# Install-Chrome
# Install-Firefox
# Install-Brave
# Install-VSCode
# Install-Discord
# Install-Obsidian
# Install-Bitwarden
# Install-7Zip
# Install-Putty
# Install-WinSCP
# Remove-Bloatware
# ShowHiddenFiles
# HideHiddenFiles
# SetTimeZone
# Harden-ExecutionPolicy