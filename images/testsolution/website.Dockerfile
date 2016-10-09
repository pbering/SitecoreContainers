FROM sitecore-aspnet:8.1.160519

ADD Docker/Sitecore/ /Sitecore

VOLUME C:/Workspace

CMD powershell -NoProfile -Command C:\Sitecore\Start.ps1