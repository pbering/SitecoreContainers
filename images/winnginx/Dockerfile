FROM microsoft/windowsservercore

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"] 

ADD http://nginx.org/download/nginx-1.11.5.zip C:/server/nginx-1.11.5.zip

RUN Expand-Archive -Path "C:\server\nginx-1.11.5.zip" -DestinationPath "C:\server"; \
    Rename-Item -Path "C:\server\nginx-1.11.5" -NewName "nginx"; \
    Get-ChildItem -Path "C:\server" -Recurse | % { Unblock-File $_.FullName }; \
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ADD ./nginx.conf /server/nginx/conf/

EXPOSE 80

WORKDIR /server/nginx

ENTRYPOINT & .\nginx