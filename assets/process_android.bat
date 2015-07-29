@echo off  

rem svn版本线路:		trunk,release...(对应需要获取的svn线路)
rem 产品类型:			sg_default,...(对应translate模块使用)
rem 图片打包类型:		nopic,win32,android,ios,wp8...
rem 语言包类型:			gbk,big5,en,multi(目前multi包含gbk+big5+en,gbk无附加后缀,big5附加_big5,en附加_en)
rem 配置文件分类类型:	win32,android,ios...(win32=ios)

call setup-client.bat trunk sg_default android gbk win32