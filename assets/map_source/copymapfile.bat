@echo off
echo 删除场景文件
if exist res\MainScene.csb del res\MainScene.csb
if exist res\Layer.csb del res\Layer.csb
echo 拷贝到对应目录下
xcopy /q /y /s res\*.csb ..\pic\res\csb\world
xcopy /q /y /s res\csb ..\pic\res\csb
echo 拷贝完成
pause