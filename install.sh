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
stty -echo
read password
echo "请再次输入校园网密码："
read repassword

while [ $password != $repassword ];
do
echo "两次输入的密码不一致，请重试！"
echo "请输入校园网密码："
read password
echo "请再次输入校园网密码："
read repassword
done
stty echo

mkdir /opt/2645
mkdir /opt/2645/neuipgw
mkdir /etc/neuipgw
cp ./ipgw.sh /opt/2645/neuipgw/ipgw
chmod 755 /opt/2645/neuipgw/ipgw
#cp ./user.cfg /usr/local/neuipgw/user.cfg
echo "#!/bin/bash" > /etc/neuipgw/user.cfg
echo "USER_NAME=$username" >> /etc/neuipgw/user.cfg
echo "USER_PASS=$password" >> /etc/neuipgw/user.cfg
cp ./ipgw.png /opt/2645/neuipgw/ipgw.png
rm -f /usr/bin/ipgw
ln -s /opt/2645/neuipgw/ipgw /usr/bin/ipgw

echo [Desktop Entry]>/usr/share/applications/neuipgw.desktop
echo Name=NEU-IPGW>>/usr/share/applications/neuipgw.desktop
echo Comment=Speedier Internet Access>>/usr/share/applications/neuipgw.desktop
echo Exec=/usr/bin/ipgw>>/usr/share/applications/neuipgw.desktop
echo Icon=/opt/2645/neuipgw/ipgw.png>>/usr/share/applications/neuipgw.desktop
echo Terminal=true>>/usr/share/applications/neuipgw.desktop
echo Type=Application>>/usr/share/applications/neuipgw.desktop
echo Categories=Network>>/usr/share/applications/neuipgw.desktop

echo "安装成功！"


