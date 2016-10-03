#Sitecore + Windows Containers + Docker#

Playground...

## Notes ##

	docker build -t sitecore-mssql:8.1.160519 .\images\sitecore81rev160519-mssql
	docker build -t sitecore-aspnet:8.1.160519 .\images\sitecore81rev160519-aspnet

	docker run -d -p 1433:1433 --name demo-sql sitecore-mssql:8.1.160519

	HACK: use inspect to get ip of sql and add to connectionstrings...

	docker build -t website .\images\website
	docker run -d -p 8000:8000 --name demo-website website

	docker exec -t -i demo-website powershell
	Get-Content -path C:\Sitecore\Data\logs\log.*.txt -Wait

## Todo's ##

- Sql and data, should image expose volumne? 
- Switch to 32 bit app pool
- What to do about connectionstrings, could environment variables be used some how?
- Sitecore logging output