FROM sitecore-aspnet:8.1.160519

ENV TESTVAR1 "yo!"
ENV TESTVAR2 _

RUN powershell -NoProfile -Command Write-Host "TEST RUN: $($env:TESTVAR1), $($env:TESTVAR2)"

CMD powershell -NoProfile -Command Write-Host "TEST CMD: $($env:TESTVAR1), $($env:TESTVAR2)"