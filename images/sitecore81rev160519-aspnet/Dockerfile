FROM microsoft/aspnet

RUN mkdir C:\Sitecore\Website

RUN powershell -NoProfile -Command \
    Import-Module IISAdministration; \
    New-IISSite -Name "Sitecore" -PhysicalPath "C:\Sitecore\Website" -BindingInformation "*:8000:"

EXPOSE 8000

ADD Sitecore/ /Sitecore