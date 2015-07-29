@echo off
set s2=%~dp2
echo 2-%1---%s2%
xcopy /y /q %1 %s2%