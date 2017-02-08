#########################################################################
# File Name: uninstall.sh
# Author: Li Jiahao
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Wed 08 Feb 2017 11:49:25 AM CST
#########################################################################
#!/bin/bash

echo "感谢使用NEU IPGW登陆器 2645工作室出品"

echo "您确定要卸载吗(Y/n)？这将会删除程序安装目录内的所有文件。"
read confirm

if [[ $confirm == 'n' ]] || [[ $confirm == 'N' ]] ;
then
    exit
fi

me=`whoami`

sudo rm -rf /opt/2645/neuipgw
sudo rm -rf /usr/local/neuipgw #old version
sudo rm -rf /usr/bin/ipgw
sudo rm -f /usr/share/applications/neuipgw.desktop
rm -f /home/$me/.local/share/applications/neuipgw.desktop
sudo rm -rf /etc/neuipgw #old version

echo "是否清除密码等配置信息(y/N)？此操作将不会影响你电脑上的其他用户。"
read clconfig

if [[ $clconfig == 'y' ]] || [[ $clconfig == 'Y' ]] ;
then
    rm -rf /home/$me/.neuipgw
fi


echo "卸载成功！"
