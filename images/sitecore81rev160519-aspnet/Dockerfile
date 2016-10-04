FROM microsoft/windowsservercore

RUN mkdir C:\Sitecore\Website \
    && powershell -NoProfile -Command \
        Add-WindowsFeature Web-Server; \
        Add-WindowsFeature NET-Framework-45-ASPNET; \
        Add-WindowsFeature Web-Asp-Net45; \
        Import-Module IISAdministration; \
        New-IISSite -Name "Sitecore" -PhysicalPath "C:\Sitecore\Website" -BindingInformation "*:8000:"; \
        Import-Module WebAdministration; \
        Set-ItemProperty "IIS:\apppools\DefaultAppPool" -Name "enable32BitAppOnWin64" -Value "True";

EXPOSE 8000

ADD Sitecore/ /Sitecore