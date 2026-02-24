@echo off

:Choice
set /P prompt=Do you want to add firewall settings for DSTServer? [Y/N]? 
if /I "%prompt%" NEQ "Y" goto :end

REM Firewall Inbound for TCP and UDP
netsh advfirewall firewall show rule name="DSTServer(TCP)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "DSTServer(TCP)" dir=in action=allow protocol=TCP localport=10999
    ) ELSE (
        ECHO Rule already exists
)
netsh advfirewall firewall show rule name="DSTServer(UDP)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "DSTServer(UDP)" dir=in action=allow protocol=UDP localport=10999
    ) ELSE (
        ECHO Rule already exists
)

pause 100

REM Firewall Outbound for TCP and UDP
netsh advfirewall firewall show rule name="DSTServer(TCP-Out)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "DSTServer(TCP)" dir=out action=allow protocol=TCP localport=10999
    ) ELSE (
        ECHO Rule already exists
)
netsh advfirewall firewall show rule name="DSTServer(UDP-Out)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "DSTServer(UDP)" dir=out action=allow protocol=UDP localport=10999
    ) ELSE (
        ECHO Rule already exists
)

pause 100

:end
endlocal