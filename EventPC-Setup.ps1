<#
.SYNOPSIS
  Sets streaming and gaming machines up for event deployment

.DESCRIPTION
  Prepares streaming and gaming machines for live events.  See README.MD for setup instructions.

.PARAMETER Streamer
  Runs through the stream PC setup

.PARAMETER Gamer
  Runs through the game PC setup

.NOTES
  Version: 1.0
  Author: Bennett Blodinger
  License: MIT

.LINK
  https://github.com/benwa/EventPC-Setup
#>

[CmdletBinding()]
Param (
    [Parameter(Position=1, ParameterSetName='Default Param Set')]
    [Switch]$Streamer,

    [Parameter(Position=2, ParameterSetName='Default Param Set')]
    [Switch]$Gamer
)

Begin {
    Write-Host 'Correct any missing driver issues first'
    devmgmt.msc
    Write-Host -NoNewline 'Press any key to continue...'
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

Process {
    #region Create Event Directory
    New-Item $HOME -Name Event -ItemType Directory
    #endregion

    #region Date/Time
    tzutil.exe /s "Central Standard Time"
    w32tm.exe /config /manualpeerlist:pool.ntp.org /syncfromflags:MANUAL
    w32tm.exe /resync
    #endregion

    #region Windows Update
    New-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Force
    Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name NoAutoUpdate -Value 1 -Force
    Set-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name AUOptions -Value 5 -Force
    #endregion

    #region Notifications
    New-Item HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Force
    Set-ItemProperty HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name DisableNotificationCenter -Value 1 -Force
    Set-ItemProperty HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name EnableBalloonTips -Value 0 -Force
    #endregion

    #region High Performance Power Profile
    powercfg.exe -SetActive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg.exe -Hibernate Off
    #endregion

    #region Screensaver
    New-Item 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel' -Force
    New-Item 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop' -Force
    Set-ItemProperty 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop' -Name ScreenSaveTimeOut -Value 0 -Force
    Set-ItemProperty 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop' -Name ScreenSaveActive -Value 0 -Force
    Set-ItemProperty 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop' -Name ScreenSaverIsSecure -Value 0 -Force
    #endregion
    
    #region Accessibility
    Set-ItemProperty 'HKCU:\Control Panel\Accessibility\MouseKeys\' -Name Flags -Value 58 -Force
    Set-ItemProperty 'HKCU:\Control Panel\Accessibility\StickyKeys\' -Name Flags -Value 506 -Force
    Set-ItemProperty 'HKCU:\Control Panel\Accessibility\ToggleKeys\' -Name Flags -Value 58 -Force
    #endregion

    #region Wallpaper
    If (Test-Path .\wallpaper.png) {
        Copy-Item .\wallpaper.png $HOME\Event\wallpaper.png -Force
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $HOME\Event\wallpaper.png -Force
        rundll32.exe USER32.dll,UpdatePerUserSystemParameters, 1, True
    }
    #endregion
    
    #region Graphics
    If (Test-Path *-desktop-*-international-whql.exe) {
        Start-Process -Wait $(Resolve-Path *-desktop-*-international-whql.exe -Relative) -clean -noreboot -passive -noeula -nofinish -nosplash
    }
    #endregion

    If ($Streamer) {
        If (Test-Path .\loop.mp4) {
            Copy-Item .\loop.mp4 $HOME\Event\loop.mp4
        }
        If (Test-Path .\logo.mp4) {
            Copy-Item .\logo.mp4 $HOME\Event\logo.mp4
        }
        If (Test-Path OBS-Studio-*-Installer.exe) {
            Start-Process -Wait $(Resolve-Path OBS-Studio-*-Installer.exe -Relative) /S
        }
        If (Test-Path .\obs-studio\basic) {
            Copy-Item .\obs-studio\basic\ $env:APPDATA\obs-studio\basic\ -Recurse -Force
        }
        If (Test-Path .\obs-studio\plugin_config) {
            Copy-Item .\obs-studio\plugin_config $env:APPDATA\obs-studio\plugin_config -Recurse -Force
        }
        If (Test-Path .\obs-studio\global.ini) {
            Copy-Item .\obs-studio\global.ini $env:APPDATA\obs-studio\global.ini
        }

        Write-Host 'Fix loop, logo, and record locations manually'
    }

    If ($Gamer) {
        #region Steam
        If (Test-Path .\SteamSetup.exe) {
            Start-Process -Wait .\SteamSetup.exe /S
            Start-Process 'C:\Program Files (x86)\Steam\Steam.exe'
            Copy-Item .\steamapps\ 'C:\Program Files (x86)\Steam\' -Recurse -Force
        }
        #endregion

        #region Battle.net
        If (Test-Path .\Battle.net-Setup.exe) {
            Start-Process -Wait .\Battle.net-Setup.exe
        }
        #endregion

        #region Origin
        If (Test-Path .\OriginSetup.exe) {
            Start-Process .\OriginSetup.exe /S
            Copy-Item '.\Origin Games\' 'C:\Program Files (x86)\' -Recurse -Force
        }
        #endregion
        
        #region Epic Games
        If (Test-Path .\EpicGamesLauncherInstaller.msi) {
            Start-Process msiexec -ArgumentList '/i .\EpicGamesLauncherInstaller.msi /qn /norestart' -Wait -PassThru
        }
        #endregion
    }
}
