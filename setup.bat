@echo off

REM variable %1 value comes from bomboo
rem SET VERSION=%1  
SET VERSION=1.0.0  
SET PRODUCTVER=%VERSION%

REM start clean, delete any previous staging folderS
rmdir /Q /S staging
rmdir /Q /S target

mkdir staging
mkdir target

xcopy /Y /I /E PreReq\Tomcat staging\Tomcat
xcopy /Y /I /E PreReq\MongoDB staging\MongoDB

REM HARVESTED files to be installed to -dr (directory Tomcat); var.TomcatDir values are passed in THROUGH candle below
heat dir "staging\Tomcat" -dr Tomcat -var var.TomcatDir -srd -gg -ke -cg cg_Tomcat -sfrag -sreg -out staging\Tomcat.wxs
heat dir "staging\MongoDB" -dr MongoDB -var var.MongoDBDir -srd -gg -ke -cg cg_MongoDB -sfrag -sreg -out staging\MongoDB.wxs

REM build wix proj file into object files
REM -dProductVer and -dFullVer sets values to variables used in the .wix file
REM -d Candle in building, sets a value to variables used; HERE USED IN heat ABOVE
candle -arch x64 -dProductVer=%PRODUCTVER% LTSSInstaller\Product.wxs -out staging\Product.wixobj

candle -arch x64 -dTomcatDir=staging\Tomcat staging\Tomcat.wxs -out staging\Tomcat.wixobj

candle -arch x64 -dMongoDBDir=staging\MongoDB staging\MongoDB.wxs -out staging\MongoDB.wixobj

REM Combine multiple .wixobj files into libraries that can be consumed by Light; output to staging\complete.wixobg
lit -ext WixUIExtension -ext WixNetFxExtension staging\Product.wixobj staging\MongoDB.wixobj staging\Tomcat.wixobj -out staging\complete.wixobj
 
light -out staging\LTSSInstaller.msi staging\complete.wixobj

candle -ext WixBalExtension -arch x64 -dProductVer=%PRODUCTVER% LTSSBootstrapper\Bundle.wxs -out staging\Bundle.wixobj

light -ext WixBalExtension -out target\LTSSBootstrapper.exe staging\Bundle.wixobj