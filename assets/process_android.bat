@echo off  

rem svn�汾��·:		trunk,release...(��Ӧ��Ҫ��ȡ��svn��·)
rem ��Ʒ����:			sg_default,...(��Ӧtranslateģ��ʹ��)
rem ͼƬ�������:		nopic,win32,android,ios,wp8...
rem ���԰�����:			gbk,big5,en,multi(Ŀǰmulti����gbk+big5+en,gbk�޸��Ӻ�׺,big5����_big5,en����_en)
rem �����ļ���������:	win32,android,ios...(win32=ios)

call setup-client.bat trunk sg_default android gbk win32