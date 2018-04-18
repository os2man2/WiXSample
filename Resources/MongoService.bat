@echo off
SET Option=%1

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
SET DB="C:\Program Files\LTSSService\MongoDB\Data"
SET Log="C:\Program Files\LTSSService\MongoDB\Log"
Set Log=%Log:"=%

mkdir %DB%
mkdir "%Log%"

mongod --install --dbpath %DB% --logpath "%Log%\mongo.log" --logappend

sc start MongoDB

rem mongo.exe ltss-offline --eval "db.ltssofflineTest.insert({key:'value'});"
echo "Mongo Service installed and started"

GOTO EOF

:Stop
sc stop MongoDB
sc delete MongoDB

echo "Mongo Service stopped and removed"
GOTO EOF

:EOF
