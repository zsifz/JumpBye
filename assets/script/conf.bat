@echo off

if not exist ..\outputClient mkdir ..\outputClient
if not exist ..\outputServer mkdir ..\outputServer
if not exist ..\outputAdminServer mkdir ..\outputAdminServer
if not exist ..\outputCheckServer mkdir ..\outputCheckServer

del /f /s /q ..\outputClient\*.*
del /f /s /q ..\outputServer\*.*
del /f /s /q ..\outputAdminServer\*.*
del /f /s /q ..\outputCheckServer\*.*

echo "---conf---"
cd conf
python start.py %3
cd ..


