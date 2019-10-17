#requires -version 4
#Requires -RunAsAdministrator

<#
.SYNOPSIS
  Configuration files and script to do basic configuration of Windows 10 workstations for Premium Cohort 2

.DESCRIPTION
  Sets: Power Plan, Time Zone, Desktop Wallpaper 
  Installs: Chrome, Slack Desktop

.PARAMETER InstallFiles
  Folder where installation files are
 
.INPUTS
  None

.OUTPUTS Log File
  The script log file stored in $InstallFiles\DigitalAcademy-Installation.log

.NOTES
  Version:        1.0
  Author:         Cory Dignard
  Creation Date:  October 17, 2019
  Purpose/Change: Initial script development


.EXAMPLE
  C:\DigitalAcademy\InstallFiles\DigitalAcademy-Installation.ps1 -InstallFiles "C:\DigitalAcademy\InstallFiles"
  
#>

#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
  [Parameter(Mandatory=$true)][string]$InstallFiles
)

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import Modules & Snap-ins
Import-Module PSLogging

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'

#Log File Info
$sLogPath = $InstallFiles
$sLogName = 'DigitalAcademy-Installation.log'
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Functions]------------------------------------------------------------

Function Write-Message ($message) {
    write-host "`n$message" -ForegroundColor Green;write-host ""
    Write-LogInfo -LogPath $sLogFile -Message "`n$message"

}

Function InstallSoftware ($Software,$InstallCommands,$Arguments) {

  Begin {
    Write-Message "Installing $Software"
  }

  Process {
    Try {
      Start-Process "$InstallCommands" -ArgumentList "$Arguments" -Wait -NoNewWindow
    }

    Catch {
      Write-LogError -LogPath $sLogFile -Message $_.Exception -ExitGracefully
      Break
    }
  }

  End {
    If ($?) {
      write-Message "Completed."
    }
  }
}


#-----------------------------------------------------------[Execution]------------------------------------------------------------

Start-Log -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion | Out-Null
Write-Host "";"Log file: $sLogFile";Write-Host ""

Write-Message "Setting up Power Plan"
powercfg /import "$InstallFiles\PowerPlan.pow"
$HighPerf = powercfg -l | %{if($_.contains("POWER")) {$_.split()[3]}}
powercfg -setactive $HighPerf
Write-Message "Completed"

Write-Message "Set Time Zone"
Set-TimeZone -Id "Eastern Standard Time"
Write-Message "Completed"

Write-Message "Installing Applications"
InstallSoftware "Chrome" "msiexec" "/i $InstallFiles\GoogleChromeStandaloneEnterprise64.msi /q"
InstallSoftware "Slack" "$InstallFiles\SlackSetup.exe" "/silent"
Write-Message "Completed"

Write-Message "Set Desktop Wallpaper"
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value "$InstallFiles\wallpaper1920x1080.png"
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name WallpaperStyle -value "6"
rundll32.exe user32.dll, UpdatePerUserSystemParameters
Write-Message "Completed"

Write-Message "All tasks completed."

Stop-Log -LogPath $sLogFile