# Sitecore + Windows Containers + Docker #

Playground...

## Commands ##

	docker build -t sitecore-mssql:8.1.160519 .\images\sitecore81rev160519-mssql
	docker build -t sitecore-aspnet:8.1.160519 .\images\sitecore81rev160519-aspnet

	docker build -t website .\images\website
	docker run -d -p 1433:1433 --env sa_password=Sitecore_Containers_Rocks_9999 --name demo-sql sitecore-mssql:8.1.160519
	docker run -p 8000:8000 --env "SQL_USER=sa" --env "SQL_PASSWORD=Sitecore_Containers_Rocks_9999" --env "SQL_SERVER=demo-sql" --name demo-website --link demo-sql website

---

	docker exec -t -i demo-website powershell
	Get-Content -path C:\Sitecore\Data\logs\log.*.txt -Wait

	docker rmi $(docker images -q -f dangling=true)
	docker attach demo-website

---

	docker build -t testsolution-sql .\images\testsolution\docker\sql
	docker build -t testsolution-website .\images\testsolution\docker\website

	docker run -d -p 1433:1433 --env sa_password=Sitecore_Containers_Rocks_9999 --name demo-testsolution-sql --volume d:/Projects/SitecoreContainers/images/testsolution/docker/sql/Sitecore/Databases:C:/Data testsolution-sql
	docker run -p 8000:8000 --env "SQL_USER=sa" --env "SQL_PASSWORD=Sitecore_Containers_Rocks_9999" --env "SQL_SERVER=demo-testsolution-sql" --name demo-testsolution-website --link demo-testsolution-sql --volume d:/Projects/SitecoreContainers/images/testsolution/src/Website:C:/Workspace testsolution-website

---

## Test Solution ##

Compose 1.9+ required

	docker-compose build
	docker-compose up
	docker-compose up --build
	docker-compose scale web=3

## TODO's ##

- Cleanup (delete website and sitecore specific sql variant?)
- Logging?...

## Known issues ##

- Doesn't matter which port you publish to on host since you can only talk to containers with their internal IPs. Known Windows NAT / Docker issue.
