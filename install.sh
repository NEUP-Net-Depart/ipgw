#########################################################################
# File Name: install.sh
# Author: Li Jiahao
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Sat 21 May 2016 02:18:25 PM CST
#########################################################################
#!/bin/bash

echo "欢迎使用neu ipgw登陆器 2645工作室出品"
echo "请输入校园网账号："
read username
echo "请输入校园网密码："
read password
echo "请再次输入校园网密码："
read repassword

while (($password != $repassword))
do
echo "两次输入的密码不一致，请重试！"
echo "请输入校园网密码："
read password
echo "请再次输入校园网密码："
read repassword
done

mkdir /usr/local/neuipgw
cp ./ipgw.sh /usr/local/neuipgw/ipgw.sh
#cp ./user.cfg /usr/local/neuipgw/user.cfg
echo "#!/bin/bash" > /usr/local/neuipgw/user.cfg
echo "USER_NAME=$username" >> /usr/local/neuipgw/user.cfg
echo "USER_PASS=$password" >> /usr/local/neuipgw/user.cfg
cp ./ipgw.png /usr/local/neuipgw/ipgw.png

echo [Desktop Entry]>/usr/share/applications/neuipgw.desktop
echo Name=NEU-IPGW>>/usr/share/applications/neuipgw.desktop
echo Comment=Speedier Internet Access>>/usr/share/applications/neuipgw.desktop
echo Exec=sh /usr/local/neuipgw/ipgw.sh>>/usr/share/applications/neuipgw.desktop
echo Icon=/usr/local/neuipgw/ipgw.png>>/usr/share/applications/neuipgw.desktop
echo Terminal=true>>/usr/share/applications/neuipgw.desktop
echo Type=Application>>/usr/share/applications/neuipgw.desktop
echo Categories=Network>>/usr/share/applications/neuipgw.desktop

echo "安装成功！"


