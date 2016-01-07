#Sitecore + Windows Server Containers + Docker#

Playground...

## Notes ##

	$env:DOCKER_HOST = "tcp://10.20.34.227:2375"

	docker build -t sitecoredev:8.1.151003 -f .\containers\sitecore81rev151003\mssql.Dockerfile .\sitecore81rev151003
	docker build -t sitecoredev:8.1.151207 -f .\containers\sitecore81rev151207\mssql.Dockerfile .\sitecore81rev151207

	docker build -t sitecore:8.1.151003 .\containers\sitecore81rev151003\
	docker tag sitecore:8.1.151003 sitecore:latest
	docker run -it -p 80:80 sitecore:8.1.151003 powershell

	docker rm $(docker ps -a -q)
	docker rmi $(docker images -q -f dangling=true)

	docker run --name demo -d -p 80:80 sitecore81;docker exec -t -i demo powershell
	docker run --name demo -it -p 80:80 sitecore81 powershell

	get-content -path C:\inetpub\Sitecore\Data\logs\log.*.txt -tail 100 -Wait

# Issues #

- Setting NTFS permissions does not work (yet?), not even manually by running container and commiting images. Everything must run as Local System

# Ideas #

- Split webapp from mssql
- Look into using Docker build from github url
- Use ENTRYPOINT / CMD to output sitecore logs via UdpReader exe that must not exit?
		- Better yet, make powershell scipt to watch for file changes and pipe out - no changes to sitecore needed
				LIKE: get-content -path C:\inetpub\Sitecore\Data\logs\log.*.txt -tail 100 -Wait
- Test mounting, look into "Data Volume Containers"
- Split dockerfile, one for build and one for deployment