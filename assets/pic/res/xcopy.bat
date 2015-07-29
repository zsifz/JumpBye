@echo off
echo "----------TexturePacker Begin------------"
echo %3
rem 统一打成.pvr.ccz文件格式 颜色格式通过参数进行不同的处理
set filename=%~nx1
set dir=%2
set oldfilename=%dir%\%6%filename%.png
rem 1 拷贝plist 0 不拷贝plist将plist删除
echo %cd%
set saveplist=%5

rem IOS 文件打包格式
if %3==ios-rgba8888 (
  echo "to rgba8888"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )

)
if %3==ios-rgba8888_notrim (
  echo "to rgba8888 notrim"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
)
if %3==ios-selflow (
  echo "to selflow"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
  res\pack.exe %cd%\ %1.png %1.png 30 4
)
if %3==ios-selflow_notrim (
  echo "to selflow notrim"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
  res\pack.exe %cd%\ %1.png %1.png 30 4
)
if %3==ios-selfmiddle (
  echo "to selfmiddle"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
  res\pack.exe %cd%\ %1.png %1.png 70 2	
)
if %3==ios-selfmiddle_notrim (
  echo "to selfmiddle notrim"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
  res\pack.exe %cd%\ %1.png %1.png 70 2
)
if %3==ios-selfhigh (
  echo "to selfhigh"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
  res\pack.exe %cd%\ %1.png %1.png 100 1	
)
if %3==ios-selfhigh_notrim (
  echo "to selfhigh notrim"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2 
	if exist %1_tmp.plist del %1_tmp.plist
  )
  res\pack.exe %cd%\ %1.png %1.png 100 1
)
if %3==ios-rgb565 (
  echo "to rgba565"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)
if %3==ios-rgb565_notrim (
  echo "to rgba565 notrim"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565      --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)
if %3==ios-rgba4444 (
  echo "to rgba4444"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA4444 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA4444 --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)
if %3==ios-rgba5551 (
  echo "to rgba5551"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA5551 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA5551 --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)
if %3==ios-pvrtc4 (
  echo "to pvrtc4"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt PVRTC4 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt PVRTC4 --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)
if %3==ios-pvrtc4_noalpha (
  echo "to pvrtc4_noalpha"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --opt PVRTC4_NOALPHA --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --opt PVRTC4_NOALPHA --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)

if %3==ios-pvrtc4_notrim (
  echo "to pvrtc4 no trim"
  if %saveplist%==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt PVRTC4 --sheet %1.pvr.ccz %2
  )
  if %saveplist%==0 (
	TexturePacker --data %1_tmp.plist --format cocos2d --algorithm MaxRects --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt PVRTC4 --sheet %1.pvr.ccz %2
	if exist %1_tmp.plist del %1_tmp.plist
  )
)

if %3==ios-none (
  echo to ios-none %4
  if %4==1 (
	pause
  )
  if %4==0 (
	call Image\copyfile.bat %cd%\%oldfilename%  %cd%\%1.png  
  )
)

rem Android 文件打包格式
if %3==android-rgba8888 (
  echo to rgba8888 %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)
if %3==android-rgba8888_notrim (
  echo to rgba8888 %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)

if %3==android-selflow (
  echo to rgba8888 %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
  res\pack.exe %cd%\ %1.png %1.png 30 4
)
if %3==android-selflow_notrim (
  echo to rgba8888 %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
  res\pack.exe %cd%\ %1.png %1.png 30 4
)

if %3==android-selfmiddle (
  echo to selfmiddle %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
  res\pack.exe %cd%\ %1.png %1.png 70 2
)
if %3==android-selfmiddle_notrim (
  echo to selfmiddle %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
  res\pack.exe %cd%\ %1.png %1.png 70 2
)

if %3==android-selfhigh (
  echo to selfhigh %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
  res\pack.exe %cd%\ %1.png %1.png 100 1
)
if %3==android-selfhigh_notrim (
  echo to selfhigh %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
  res\pack.exe %cd%\ %1.png %1.png 100 1
)

if %3==android-rgb888 (
  echo to rgb888 %4
  if %4==1 (
 	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGB888 --sheet %1.pvr.ccz %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGB888 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGB888 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)
if %3==android-rgb565 (
 echo to rgb565 %4
  if %4==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)
if %3==android-rgb565_notrim (
 echo to rgb565 %4
  if %4==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)
if %3==android-rgba4444 (
 echo to rgba4444 %4
  if %4==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA4444 --sheet %1.pvr.ccz %2
  )
  if %4==0 (
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA4444 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA4444 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)
if %3==android-rgba5551 (
 echo to rgba5551 %4
  if %4==1 (
	TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA5551 --sheet %1.pvr.ccz %2
  )
  if %4==0 (	
	if %saveplist%==1 (
		TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA5551 --sheet %1.pvr.ccz %2
	)
	if %saveplist%==0 (
		TexturePacker --data %1_tmp.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA5551 --sheet %1.pvr.ccz %2
		if exist %1_tmp.plist del %1_tmp.plist
	)
  )
)
rem ---------------------------
rem +        android png      +
rem ---------------------------
if %3==android-rgba8888-png (
  echo to rgba8888 %4 png
  if %4==1 (
	echo "pack to png error"
	pause
  )
  if %4==0 (
	TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
	if exist %1.plist del %1.plist 
  )
)
if %3==android-rgb888-png (
  echo to rgb888 %4 png
   if %4==1 (
	echo "pack to png error"
	pause
  )
  if %4==0 (
	TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGB888 --sheet %1.png %2
	if exist %1.plist del %1.plist
  )
)
if %3==android-rgb565-png (
 echo to rgb565 %4 png
  if %4==1 (
	echo "pack to png error"
	pause
  )
  if %4==0 (
	TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.png %2
	if exist %1.plist del %1.plist 
  )
)
if %3==android-rgba4444-png (
 echo to rgba4444 %4 png
  if %4==1 (
	echo "pack to png error"
	pause
  )
  if %4==0 (
	TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA4444 --sheet %1.png %2
	if exist %1.plist del %1.plist 
  )
)
if %3==android-rgba5551-png (
 echo to rgba5551 %4 png
  if %4==1 (
	echo "pack to png error"
	pause
  )
  if %4==0 (
	TexturePacker --data %1.plist --format cocos2d --algorithm Basic --no-trim --disable-rotation --padding 0 --shape-padding 0 --border-padding 0 --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGBA5551 --sheet %1.png %2
 	if exist %1.plist del %1.plist 
  )
)

if %3==android-none (
  echo to android-none %4
  if %4==1 (
	pause
  )
  if %4==0 (
	call Image\copyfile.bat %cd%\%oldfilename%  %cd%\%1.png  
  )
)

rem windows phone
if %3 == wp8-rgba8888 (
 echo "wp to rgba8888"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
)
if %3 == wp8-rgba8888_notrim (
 echo "wp to rgba8888"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
)
if %3 == wp8-selflow (
 echo "wp to selflow"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 res\pack.exe %cd%\ %1.png %1.png 30 4
)
if %3 == wp8-selflow_notrim (
 echo "wp to selflow"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 res\pack.exe %cd%\ %1.png %1.png 30 4
)
if %3 == wp8-selfmiddle (
 echo "wp to selfmiddle"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 res\pack.exe %cd%\ %1.png %1.png 70 2
)
if %3 == wp8-selfmiddle_notrim (
 echo "wp to selfmiddle"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 res\pack.exe %cd%\ %1.png %1.png 70 2
)
if %3 == wp8-selfhigh (
 echo "wp to selfhigh"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 res\pack.exe %cd%\ %1.png %1.png 100 1
)
if %3 == wp8-selfhigh_notrim (
 echo "wp to selfhigh"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 res\pack.exe %cd%\ %1.png %1.png 100 1
)
if %3 == wp8-rgba888 (
 echo "wp to rgba888"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA888 --sheet %1.png %2
)
if %3==wp8-rgb565 (
 echo "wp to rgba565"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.png %2
)
if %3==wp8-rgb565_notrim (
 echo "wp to rgba565 notrim"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --allow-free-size --opt RGB565 --sheet %1.png %2
)
if %3==wp8-rgba4444 (
 echo "wp to rgba4444"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --allow-free-size --dither-fs-alpha --opt RGBA4444 --sheet %1.png %2
)
if %3==wp8-dxt1 (
 echo "wp to dxt1"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt RGB888 --sheet %1.png %2
 nvdxt -file %1.png -output %1.dds -dxt1c
 if exist %1.png del %1.png
)
if %3==wp8-dxt3 (
 echo "wp to dxt3"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --trim --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
 nvdxt -file %1.png -output %1.dds -dxt3
 if exist %1.png del %1.png
)
if %3==wp8-dxt3_notrim (
 echo "wp to dxt3 no trim"
 TexturePacker --data %1.plist --format cocos2d --algorithm MaxRects --no-trim --replace [/+]=# --trim-sprite-names --dither-fs-alpha --opt RGBA8888 --sheet %1.png %2
  nvdxt -file %1.png -output %1.dds -dxt3
 if exist %1.png del %1.png
)
if %3==wp8-none (
  echo to wp8-none %4
  if %4==1 (
	pause
  )
  if %4==0 (
	call Image\copyfile.bat %cd%\%oldfilename%  %cd%\%1.png  
  )
)
echo "----------TexturePacker End--------------"
