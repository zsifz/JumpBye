if "%1" == "" goto 1

if "%2" == "" goto 2

if "%4" == "" goto 4

if "%5" == "" goto 5

call script\conf.bat %1 %2 %4 %5

if "%3" == "nopic" goto 3

echo "--csb--"
cd UIlayer_source
call copyuilayerfile
cd ..

echo "--pic--"
cd pic
if "%3" == "win32" python start.py win32 %*
if "%3" == "ios" python start.py ios %*
if "%3" == "android" python start.py android %*
if "%3" == "wp8" python start.py wp8 %*
if "%3" == "multi" python start.py multi %*
cd ..

:3
call script\copyres.bat %1 %2

goto exit

:1
echo "param1 not defined!!!!!!!!!!!!!!!!!!!!" 
goto exit

:2
echo "param2 not defined!!!!!!!!!!!!!!!!!!!!" 
goto exit

:4
echo "param4 not defined!!!!!!!!!!!!!!!!!!!!"
goto exit

:5
echo "param5 not defined!!!!!!!!!!!!!!!!!!!!"
goto exit

:exit
