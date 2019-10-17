# Configuration files and script to do basic configuration of Windows 10 workstations for Premium Cohort 2

These configuration files are in support of the training courses the **Canada School of Public Service (CSPS) Digital Academy (DA) / École de la fonction publique du Canada (EFPC) Académie du numérique (AN)**, are hosting starting November, 2019.

**Acknowledgements**

Script template from [9to5IT/PS_Script_Template_V2_Logs.ps1]. This README.md was created using [dillinger.io]

# Files
* **DigitalAcademy-Installation.ps1**
  * Sets: Power Plan, Time Zone, Desktop Wallpaper 
  * Installs: Chrome, Slack Desktop
* **Commands.txt** : List of commands I used to do the installs
* **GoogleChromeStandaloneEnterprise64.msi** : Chrome offline install file
* **SlackSetup.exe** : Slack Desktop install file
* **PowerPlan.pow** : Windows Power Plan applied as part of the configuration
* **wallpaper1920x1080.png** : Desktop wallpaper

# How to use the scripts
The Powershell scripts were designed on laptops running Windows 10 build 1903.

* Download the following installations files
  * Chrome bundle for Windows 64‑bit (GoogleChromeStandaloneEnterprise64.msi) - https://cloud.google.com/chrome-enterprise/browser/download/?h1=en
  * Slack Desktop - https://slack.com/downloads/windows
* Download and copy files to C:\DigitalAcademy\InstallFiles
* Open Powershell prompt as administrator
* Set Powershell execution policy to Unrestricted
```sh
Set-ExecutionPolicy Unrestricted
select [A] Yes to All 
```
* Install PSLogging
```sh
Install-Module PSLogging
select [A] Yes to All
```
* Launch installation script
```sh
C:\DigitalAcademy\InstallFiles\DigitalAcademy-Installation.ps1 -InstallFiles "c:\DigitalAcademy\InstallFiles"
```
* Restart workstation once complete
* DONE!

[dillinger.io]: <https://dillinger.io/>
[9to5IT/PS_Script_Template_V2_Logs.ps1]: <https://gist.github.com/9to5IT/d81802b28cfd10ab5d89>