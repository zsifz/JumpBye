#!/bin/sh

if [ ! -d "../outputClient" ];
	then
		mkdir "../outputClient"
fi

if [ ! -d "../outputServer" ];
	then
		mkdir "../outputServer"
fi

if [ ! -d "../outputAdminServer" ];
	then
		mkdir "../outputAdminServer"
fi

echo "---sociaty---"
cd sociaty
python start.py $3
cd ..

echo "---item---"
cd item
python start.py $3
cd ..

echo "---mission---"
cd mission
python start.py $3
cd ..

echo "---monster---"
cd monster
python start.py $3
cd ..

echo "---reel---"
cd reel
python start.py $3
cd ..

echo "---skill---"
cd skill
python start.py $3 $4
cd ..

echo "---supersport---"
cd supersport
python start.py $3
cd ..

echo "---upgrade---"
cd upgrade
python start.py $3
cd ..

echo "---role---"
cd role
python start.py $3 $4
cd ..

echo "---vip---"
cd vip
python start.py $3
cd ..

echo "---shop---"
cd shop
python start.py $3
cd ..

echo "---protocol---"
cd protocol
cp Protocol.xml ../../outputClient/
cp *.xml ../../outputServer/
python start.py $1 $3
cp *.version ../../outputServer/
cp *.version ../../outputClient/
cd ..

echo "---movie---"
cd movie
python start.py $3
cp *.lua ../../outputClient/
cd ..

echo "---res---"
cd res
python start.py $3
cd ..

echo "---richmap---"
cd richmap
python start.py $3
cd ..

echo "---random---"
cd random
python start.py $3
cd ..

echo "---payment---"
cd payment
python start.py $3
cd ..

echo "---robot---"
cd robot
python start.py $3
cd ..

echo "---error---"
cd error
python start.py $3
cd ..

echo "--setting--"
cd setting
python start.py $3
cd ..

echo "--autoname--"
cd autoname
python start.py $3
cd ..

echo "--tower--"
cd tower
python start.py $3
cd ..

echo "--activity--"
cd activity
python start.py $3 $4
cd ..

echo "--upstar--"
cd upstar
python start.py $3
cd ..

echo "--luckystar--"
cd luckystar
python start.py $3
cd ..

echo "--toplist--"
cd toplist
python start.py $3
cd ..

echo "--lotteries--"
cd lotteries
python start.py $3 $4
cd ..

echo "--giftbag--"
cd giftbag
python start.py $3
cd ..

echo "--luckshop--"
cd luckshop
python start.py $3
cd ..

echo "--achievement--"
cd achievement
python start.py %3 %4
cd ..

echo "--starinvite--"
cd starinvite
python start.py %3
cd ..

echo "--dict--"
cd dict
python start.py %3
cd ..

echo "--plotpoint--"
cd plotpoint
python start.py %3
cd ..

echo "--travelworld--"
cd travelworld
python start.py %3
cd ..

echo "--headline--"
cd headline
python start.py %3 %4
cd ..

echo "--simple_config--"
cd simple_config
python start.py %3 %4
cd ..

#请保持这个在最后面
echo "--translate--"
cd translate
python start.py $2 $3
cd ..

