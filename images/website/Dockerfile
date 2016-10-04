FROM sitecore-aspnet:8.1.160519

ENV SQL_USER _
ENV SQL_PASSWORD _
ENV SQL_SERVER _

ADD Sitecore/ /Sitecore

RUN powershell -NoProfile -Command C:\Sitecore\Configure.ps1 -Verbose