@echo off
echo 拷贝到对应目录下
xcopy /q /y /s res\res\csb\ui ..\pic\res\csb\ui
xcopy /q /y /s res\*.csb ..\pic\res\csb\ui
echo 拷贝完成