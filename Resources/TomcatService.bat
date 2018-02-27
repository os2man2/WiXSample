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
call service.bat install %ServiceName%
rem sc config %ServiceName% start= auto
sc start %ServiceName%
echo "Tomcat service installed and started"
GOTO EOF

:Stop
sc stop %ServiceName%
call service.bat uninstall %ServiceName%
echo "Tomcat Service stopped and removed"
GOTO EOF

:EOF
