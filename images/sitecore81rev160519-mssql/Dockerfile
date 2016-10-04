FROM microsoft/mssql-server-2016-developer-windows

RUN mkdir C:\Temp

ADD Sitecore/Databases /Temp

ENV attach_dbs "[{'dbName':'Sitecore_Core','dbFiles':['C:\\Temp\\Sitecore.Core.mdf','C:\\Temp\\Sitecore.Core.ldf']},{'dbName':'Sitecore_Master','dbFiles':['C:\\Temp\\Sitecore.Master.mdf', 'C:\\Temp\\Sitecore.Master.ldf']},{'dbName': 'Sitecore_Web', 'dbFiles': ['C:\\Temp\\Sitecore.Web.mdf','C:\\Temp\\Sitecore.Web.ldf']},{'dbName':'Sitecore_Analytics','dbFiles':['C:\\Temp\\Sitecore.Analytics.mdf','C:\\Temp\\Sitecore.Analytics.ldf']}]"