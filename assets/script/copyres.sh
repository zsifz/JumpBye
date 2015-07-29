#!/bin/sh
rm -f ../../../super2_server_res/$1/res/scripts/app/config/*.xml

cp -f ../outputServer/*.xml ../../../super2_server_res/$1/res/scripts/app/config/
cp -f ../outputServer/*.version ../../../super2_server_res/$1/res/scripts/app/config/
cp -f ../outputServer/errorData.py ../../../super2_server_res/$1/res/scripts/app/common/protocol/

