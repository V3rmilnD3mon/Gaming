@echo off

:Choice
set /P prompt=Do you want to add firewall settings for ValheimServer? [Y/N]? 
if /I "%prompt%" NEQ "Y" goto :end

REM Firewall Inbound for TCP and UDP
netsh advfirewall firewall show rule name="ValheimServer(TCP)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "ValheimServer(TCP)" dir=in action=allow protocol=TCP localport=2456-2458
    ) ELSE (
        ECHO Rule already exists
)
netsh advfirewall firewall show rule name="ValheimServer(UDP)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "ValheimServer(UDP)" dir=in action=allow protocol=UDP localport=2456-2458
    ) ELSE (
        ECHO Rule already exists
)

pause 100

REM Firewall Outbound for TCP and UDP
netsh advfirewall firewall show rule name="ValheimServer(TCP-Out)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "ValheimServer(TCP)" dir=out action=allow protocol=TCP localport=2456-2458
    ) ELSE (
        ECHO Rule already exists
)
netsh advfirewall firewall show rule name="ValheimServer(UDP-Out)" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "ValheimServer(UDP)" dir=out action=allow protocol=UDP localport=2456-2458
    ) ELSE (
        ECHO Rule already exists
)

pause 100

:end
endlocal