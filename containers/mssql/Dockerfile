FROM windowsservercore

COPY ./install /install

RUN powershell Install-WindowsFeature NET-Framework-Features -Source c:\install \
	&& /install/SQLServer2016-x64-ENU/Setup.exe \
		/Q /ACTION=Install \
		/FEATURES=SQLEngine \
		/SECURITYMODE="SQL" \
		/INSTANCENAME=MSSQLSERVER \
		/SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" \
		/SAPWD="L@me d$fault passw0rd" \
		/SQLSYSADMINACCOUNTS="BUILTIN\Administrators" \
		/TCPENABLED=1 \
		/IACCEPTSQLSERVERLICENSETERMS \
	&& RMDIR /S /Q c:\install