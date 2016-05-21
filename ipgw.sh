#########################################################################
# File Name: ipgw.sh
# Author: Li Jiahao
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Sat 21 May 2016 10:50:21 AM CST
#########################################################################
#!/bin/bash

SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
	    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
		SOURCE="$(readlink "$SOURCE")"
		[[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

source $DIR/user.cfg

LOGOUT=`curl -s -d "action=logout&ac_id=1&user_ip=&nas_ip=&user_mac=&url=&username=$USER_NAME&password=$USER_PASS&save_me=0" "http://ipgw.neu.edu.cn:803/srun_portal_pc.php?ac_id=1&" 2>&1`
LOGIN=`curl -s -d "action=login&ac_id=1&user_ip=&nas_ip=&user_mac=&url=&username=$USER_NAME&password=$USER_PASS&save_me=0" "http://ipgw.neu.edu.cn:803/srun_portal_pc.php?ac_id=1&" 2>&1`

k=$RANDOM


if [[ "$LOGIN" =~ "网络已连接" ]];
then
    echo "连接成功！"
	INFO=`curl -s -d "action=get_online_info&key=$k" "http://ipgw.neu.edu.cn:803/include/auth_action.php?k=$k" 2>&1`
	#echo $k;
	#echo $INFO;
	DATA=${INFO%%,*}
	DATAG=$[$DATA/(1024*1024*1024)]
	DATAM=$[$DATA%(1024*1024*1024)/(1024*1024)]
	if [ $DATAG != 0 ];
	then
		echo "已用流量：$DATAG GiB $DATAM MiB"
	else
		echo "已用流量：$DATAM MiB"
	fi
	TEMP=${INFO#*,}
	TIME=${TEMP%%,*}
	TIMEH=$[$TIME/(60*60)]
	TIMEM=$[$TIME%(60*60)/(60)]
	TIMES=$[$TIME%60]
	echo "已用时长：$TIMEH:$TIMEM:$TIMES"
	TEMP=${TEMP#*,}
	BALANCE=${TEMP%%,*}
	echo "账户余额：$BALANCE"
	IP=${INFO##*,}
	echo "IP地址：$IP"

else
	echo "连接失败！"
	TEMP=${LOGIN#*<p>}
	echo ${TEMP%%</p>*}
fi

#echo $LOGOUT
#echo $LOGIN

sleep 3s

