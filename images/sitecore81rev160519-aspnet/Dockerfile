FROM microsoft/aspnet

RUN mkdir C:\Sitecore\Website && powershell -NoProfile -Command \
    Import-Module IISAdministration; \
    New-IISSite -Name "Sitecore" -PhysicalPath "C:\Sitecore\Website" -BindingInformation "*:8000:"; \
    Import-Module WebAdministration; \
    Set-ItemProperty "IIS:\apppools\DefaultAppPool" -Name "enable32BitAppOnWin64" -Value "True";

EXPOSE 8000

ADD Sitecore/ /Sitecore