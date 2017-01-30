#########################################################################
# File Name: ipgw.sh
# Author: Li Jiahao
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Sat 21 May 2016 10:50:21 AM CST
#########################################################################
#!/bin/bash

usage()  
{  
  echo "Usage: `basename $0` [-c | -d] [-q] [-f] [-m] [-u <username>] [-p <password>]"
  echo "Options:"
  echo -e "-c, --connect\tConnect Neu ip gateway"
  echo -e "-d, --disconnect\tDisconnect Neu ip gateway"
  echo -e "-f, --force\tPerform force connection"
  echo -e "-m, --mobile\tConnect as mobile device"
  echo -e "-q, --query\tQuery use of flow, balance, etc"
  echo -e "-u, --username VALUE\tSpecify username"
  echo -e "-p, --password VALUE\tSpecify password"
}     
invalidargs()
{
	echo "Invaild Options!"
	echo ""
	usage
	exit 1
}
requireuinfo()
{
  if [ ! -n "$USER_NAME" ];
  then
  	echo "请输入校园网账号："
	read USER_NAME
  fi
  if [ ! -n "$USER_PASS" ];
  then
  	echo "请输入校园网密码："
  	stty -echo
  	read USER_PASS
  	stty echo
  fi
}
disconnect()
{
  requireuinfo
  LOGOUT=`curl -s -d "action=logout&ac_id=1&user_ip=&nas_ip=&user_mac=&url=&username=$USER_NAME&password=$USER_PASS&save_me=0" "https://ipgw.neu.edu.cn/srun_portal_pc.php?ac_id=1&" 2>&1`
  if [[ "$LOGOUT" =~ "网络已断开" ]];
  then
	  echo "断开连接成功！"
  else
	  echo "断开连接失败！"
	  TEMP=${LOGOUT#*<td height=\"40\" style=\"font-weight:bold;color:orange;\">}
	  echo ${TEMP%%</td>*}
  fi
}
connectasphone()
{
  requireuinfo
  LOGIN=`curl -H "Content-type: application/x-www-form-urlencoded" -A "Mozilla/5.0 (iPhone; CPU iPhone OS 8_0_2 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12A366 Safari/600.1.4" -s -d "action=login&ac_id=1&user_ip=&nas_ip=&user_mac=&url=&username=$USER_NAME&password=$USER_PASS&save_me=0" "https://ipgw.neu.edu.cn/srun_portal_pc.php?ac_id=1&" 2>&1`
  if [[ "$LOGIN" =~ "网络已连接" ]];
  then
	  echo "网络连接成功！"
  else
	  echo "网络连接失败！"
	  TEMP=${LOGIN#*<p>}
	  echo ${TEMP%%</p>*}
  fi
  query
}
connect()
{
  requireuinfo
  LOGIN=`curl -H "Content-type: application/x-www-form-urlencoded" -A "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36" -s -d "action=login&ac_id=1&user_ip=&nas_ip=&user_mac=&url=&username=$USER_NAME&password=$USER_PASS&save_me=0" "https://ipgw.neu.edu.cn/srun_portal_pc.php?ac_id=1&" 2>&1`
  if [[ "$LOGIN" =~ "网络已连接" ]];
  then
	  echo "网络连接成功！"
  else
	  echo "网络连接失败！"
	  TEMP=${LOGIN#*<p>}
	  echo ${TEMP%%</p>*}
  fi
  query
}
query()
{
	INFO=`curl -s -d "action=get_online_info&key=$k" "https://ipgw.neu.edu.cn/include/auth_action.php?k=$k" 2>&1`
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
}

opt=""

SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
	    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
		SOURCE="$(readlink "$SOURCE")"
		[[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

if [ -f "$DIR/user.cfg" ]; then
    source $DIR/user.cfg
else
    source /etc/neuipgw/user.cfg
fi

temp=$(getopt -q -o qcdfmu:p:h --long connect,disconnect,force,mobile,query,username:,password:,help -- "$@")
if [ $? != 0 ]
then
    invalidargs
fi

eval set -- "$temp"

while [ -n "$1" ] 
do  
   case $1 in   
      -c|--connect) OPT_CONNECT=true  
		     OPT_QUERY=false
             shift  
             ;;  
	  -d|--disconnect) OPT_DISCONNECT=true
             shift  
             ;;  
	  -f|--force) OPT_FORCE=true
		     shift
			 ;;
	  -m|--mobile) OPT_MOBILE=true
		     shift
			 ;;
	  -q|--query) OPT_QUERY=true
		     OPT_DISCONNECT=false
			 shift
			 ;;
	  -u|--username) USER_NAME=$2
			 unset USER_PASS
			 shift 2
			 ;;
	  -p|--password) USER_PASS=$2
		     shift 2
			 ;;
	  -h|--help) usage
		     exit 0
			 ;;
	  --)
		     shift
			 ;;
      *)  usage  
             ;;  
   esac  
done  


k=$RANDOM
#p=$(($RANDOM % 4 + 801))

if [[ $OPT_CONNECT = true ]] || [ ! -n "$OPT_DISCONNECT" ];
then
	if [[ $OPT_FORCE = true ]];
	then
		disconnect
	fi
	if [[ $OPT_MOBILE = true ]];
	then
		connectasphone
	else
		connect
	fi
elif [[ $OPT_DISCONNECT = true ]];
then
	disconnect
fi
if [[ $OPT_QUERY = true ]];
then
	query
fi

#echo $p
#echo $LOGOUT
#echo $LOGIN

sleep 3s

