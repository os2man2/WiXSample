@echo off
SET Option=%1
SET ServiceName=%2

IF "%Option%" == "start" (
GOTO Start
)
IF "%Option%" == "stop" (
GOTO Stop
) ELSE (
echo "Invalid option"
GOTO EOF
)

:Start
service.bat install %ServiceName%
sc config %ServiceName% start= auto
sc start %ServiceName%
echo "Tomcat service installed and started"

:Stop
sc stop %ServiceName%
service.bat uninstall %ServiceName%
echo "Tomcat Service stopped and removed"

:EOF
