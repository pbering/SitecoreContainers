FROM windowsservercore

COPY ./inetpub /inetpub

RUN powershell Install-WindowsFeature Web-Server \
	&& powershell Install-WindowsFeature Web-Asp-Net45 \
	&& powershell c:\inetpub\New-Website.ps1 -Path c:\inetpub\Sitecore\Website -Name Sitecore