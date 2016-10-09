FROM microsoft/mssql-server-2016-developer-windows

VOLUME C:/Data

ENV attach_dbs "[{'dbName':'Sitecore_Core','dbFiles':['C:\\Data\\Sitecore.Core.mdf','C:\\Data\\Sitecore.Core.ldf']},{'dbName':'Sitecore_Master','dbFiles':['C:\\Data\\Sitecore.Master.mdf', 'C:\\Data\\Sitecore.Master.ldf']},{'dbName': 'Sitecore_Web', 'dbFiles': ['C:\\Data\\Sitecore.Web.mdf','C:\\Data\\Sitecore.Web.ldf']},{'dbName':'Sitecore_Analytics','dbFiles':['C:\\Data\\Sitecore.Analytics.mdf','C:\\Data\\Sitecore.Analytics.ldf']}]"