# Sitecore + Windows Containers + Docker #

Playground...

## Notes ##

	docker build -t sitecore-mssql:8.1.160519 .\images\sitecore81rev160519-mssql
	docker build -t sitecore-aspnet:8.1.160519 .\images\sitecore81rev160519-aspnet

	docker build -t website .\images\website
	docker run -d -p 1433:1433 --env sa_password=Sitecore_Containers_Rocks_9999 --name demo-sql sitecore-mssql:8.1.160519
	docker run -p 8000:8000 --env "SQL_USER=sa" --env "SQL_PASSWORD=Sitecore_Containers_Rocks_9999" --env "SQL_SERVER=demo-sql" --name demo-website --link demo-sql website

	docker exec -t -i demo-website powershell
	Get-Content -path C:\Sitecore\Data\logs\log.*.txt -Wait

	docker rmi $(docker images -q -f dangling=true)
	docker attach demo-website

### Persist ###

	docker build -t testsolution-sql .\images\testsolution\Docker\sql
	docker build -t testsolution-website .\images\testsolution\Docker\website

	docker run -d -p 1433:1433 --env sa_password=Sitecore_Containers_Rocks_9999 --name demo-testsolution-sql --volume d:/Projects/SitecoreContainers/images/testsolution/Docker/sql/Databases:C:/Data  testsolution-sql
	docker run -p 8000:8000 --env "SQL_USER=sa" --env "SQL_PASSWORD=Sitecore_Containers_Rocks_9999" --env "SQL_SERVER=demo-testsolution-sql" --name demo-testsolution-website --link demo-testsolution-sql --volume d:/Projects/SitecoreContainers/images/testsolution/src/Website:C:/Workspace testsolution-website

## TODO's ##

- TestSolution: Make Up and Down scripts (use parent directory name as name prefix like compose does)...
- Both website and sql needs to be stopped and started as they get new IPs...
- Switch to compose when it starts working...
