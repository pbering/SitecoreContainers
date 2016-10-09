FROM sitecore-aspnet:8.1.160519

ADD / /Sitecore

VOLUME C:/Workspace

CMD powershell -NoProfile -Command C:\Sitecore\Setup.ps1; C:\Sitecore\Watch.ps1 -Path 'C:\Workspace' -Destination 'C:\Sitecore\Website'