@echo off

:Choice
set /P prompt=Do you want to add firewall settings for this Server? [Y/N]? 
if /I "%prompt%" NEQ "Y" goto :end

REM Update Start & End with desired port(s)
set "startPort=10001"
set "endPort=10002"
set "freePort=%startPort%-%endPort%"

REM Update the "Example" with name of Firewall
set n="Example"

REM Firewall Inbound for TCP and UDP
netsh advfirewall firewall show rule name="(TCP-in)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "(TCP)%n%" dir=in action=allow protocol=TCP localport=%freePort%
        ECHO TCP-Inbound Rules added.
    ) ELSE (
        ECHO Rule already exists
)
netsh advfirewall firewall show rule name="(UDP-in)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "(UDP)%n%" dir=in action=allow protocol=UDP localport=%freePort%
        ECHO UDP-Inbound Rules added.
    ) ELSE (
        ECHO Rule already exists
)

pause 100

REM Firewall Outbound for TCP and UDP
netsh advfirewall firewall show rule name="(TCP-Out)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "(TCP)%n%" dir=out action=allow protocol=TCP remoteport=%freePort%
        ECHO TCP-Outbound Rules added.
    ) ELSE (
        ECHO Rule already exists
)
netsh advfirewall firewall show rule name="(UDP-Out)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall add rule name= "(UDP)%n%" dir=out action=allow protocol=UDP remoteport=%freePort%
        ECHO UDP-Outbound Rules added.
    ) ELSE (
        ECHO Rule already exists
)

pause 100

:end

endlocal
