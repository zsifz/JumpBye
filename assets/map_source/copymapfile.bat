@echo off
echo ɾ�������ļ�
if exist res\MainScene.csb del res\MainScene.csb
if exist res\Layer.csb del res\Layer.csb
echo ��������ӦĿ¼��
xcopy /q /y /s res\*.csb ..\pic\res\csb\world
xcopy /q /y /s res\csb ..\pic\res\csb
echo �������
pause