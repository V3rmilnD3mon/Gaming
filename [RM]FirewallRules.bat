@echo off

:Choice
set /P prompt=Do you want to remove firewall settings for ExampleServer? [Y/N]? 
if /I "%prompt%" NEQ "Y" goto :end

set "startPort=10001"
set "endPort=10002"
set "freePort=%startPort%-%endPort%"
set n="Example"

REM Firewall Inbound for TCP and UDP
netsh advfirewall firewall show rule name="(TCP-in)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall delete rule name= "(TCP)%n%" dir=in protocol=TCP
    ) ELSE (
        ECHO Rule does not exists
)
netsh advfirewall firewall show rule name="(UDP-in)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall delete rule name= "(UDP)%n%" dir=in protocol=UDP
    ) ELSE (
        ECHO Rule does not exists
)

pause 100

REM Firewall Outbound for TCP and UDP
netsh advfirewall firewall show rule name="(TCP-Out)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall delete rule name= "(TCP)%n%" dir=out protocol=TCP remoteport=%freePort%
    ) ELSE (
        ECHO Rule does not exists
)
netsh advfirewall firewall show rule name="(UDP-Out)%n%" > NUL 2>&1
IF ERRORLEVEL 1 (
        netsh advfirewall firewall delete rule name= "(UDP)%n%" dir=out protocol=UDP remoteport=%freePort%
    ) ELSE (
        ECHO Rule does not exists
)

ECHO.
set x=The firewall settings should now be removed completely.;Feel free to double-check or just close out of the window when it pops up.;
echo %x:;=&echo.%

pause 100

REM Opens up the adv firewall settings for user to double-check.
start wf.msc

:end
endlocal