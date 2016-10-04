#Sitecore + Windows Containers + Docker#

Playground...

## Notes ##

	docker build -t sitecore-mssql:8.1.160519 .\images\sitecore81rev160519-mssql
	docker build -t sitecore-aspnet:8.1.160519 .\images\sitecore81rev160519-aspnet

	docker run -d -p 1433:1433 --env sa_password=Sitecore_Containers_Rocks_9999 --name demo-sql sitecore-mssql:8.1.160519

	HACK: use inspect to get ip of sql...

	docker build -t website .\images\website
	docker run -d -p 8000:8000 --env "SQL_USER=sa" --env "SQL_PASSWORD=Sitecore_Containers_Rocks_9999" --env "SQL_SERVER=172.18.10.183" --name demo-website website

	docker exec -t -i demo-website powershell
	Get-Content -path C:\Sitecore\Data\logs\log.*.txt -Wait
	docker rmi $(docker images -q -f dangling=true)

## Todo's ##

- Sql and data, should image expose volumne so demo-sql was mapping volumne? 
- What to do about connectionstrings, could environment variables be used some how?
- Sitecore logging output