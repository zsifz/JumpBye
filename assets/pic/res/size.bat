@echo off
set s1=%~z1
set s2=%~z2
set aimdir=%~dp3
echo s1..%s1%...s2..%s2%
if %s1% GTR %s2% (
	echo %1 is bigger than %2
	echo 1-%2---%aimdir%
	mkdir %aimdir%
	copy /y %2 %3
) else (
	echo 1-tmp.png---%aimdir%
	mkdir %aimdir%
	copy /y %1 %3
)