#########################################################################
# File Name: install.sh
# Author: Li Jiahao
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Sat 21 May 2016 02:18:25 PM CST
#########################################################################
#!/bin/bash

echo "Would you like a Chinese installation prompt?(y/N)"
read zh_enable
if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "欢迎使用NEU IPGW登陆器 2645工作室出品"
else
    echo "Thanks for using NEU-IPGW, made by 2645 Studio"
fi

me=`whoami`

if [[ $me == "root" ]];
then
    if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
        echo "警告：您正在以超级管理员身份安装，您确定这是您想做的吗？"
    else
        echo "Warning: You're running as root, are you sure it's what you want to do?"
    fi
fi

if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "您想要为所有用户安装(Y)还是为当前用户安装(n)？"
else
    echo "Would you like to install for all users(Y) or for current user only(n)?"
fi
read ins4all

if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "请输入校园网账号："
else
    echo "Please enter your campus network username:"
fi
read username
if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "请输入校园网密码："
else
    echo "Please enter your password:"
fi
stty -echo
read password
if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "请再次输入校园网密码："
else
    echo "Please confirm your password:"
fi
read repassword

while [[ $password != $repassword ]];
do
if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "两次输入的密码不一致，请重试！"
    echo "请输入校园网密码："
else
    echo "Password inputted mismatch, please retry!"
    echo "Please enter your password:"
fi
read password
if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "请再次输入校园网密码："
else
    echo "Please confirm your password:"
fi
read repassword
done
stty echo

sudo mkdir -p /opt/2645
sudo mkdir -p /opt/2645/neuipgw
mkdir -p /home/$me/.neuipgw
if [[ $ins4all != 'n' ]] && [[ $ins4all != 'N' ]];
then
    sudo mkdir -p /usr/share/applications
    desktop_path="/usr/share/applications/neuipgw.desktop"
else
    mkdir -p /home/$me/.local/share/applications
    desktop_path="/home/$me/.local/share/applications/neuipgw.desktop"
fi

sudo cp ./ipgw.sh /opt/2645/neuipgw/ipgw
sudo cp ./install.sh /opt/2645/neuipgw/install.sh
sudo cp ./uninstall.sh /opt/2645/neuipgw/uninstall.sh
sudo chmod 755 /opt/2645/neuipgw/ipgw

echo "#!/bin/bash" > /home/$me/.neuipgw/user.cfg
echo "USER_NAME=$username" >> /home/$me/.neuipgw/user.cfg
echo "USER_PASS=$password" >> /home/$me/.neuipgw/user.cfg
sudo cp ./ipgw.png /opt/2645/neuipgw/ipgw.png
sudo rm -f /usr/bin/ipgw
sudo ln -s /opt/2645/neuipgw/ipgw /usr/bin/ipgw

sudo sh -c "echo [Desktop Entry]>$desktop_path"
sudo sh -c " echo Name=NEU-IPGW>>$desktop_path"
sudo sh -c "echo Comment=Speedier Internet Access>>$desktop_path"
sudo sh -c " echo Exec=/usr/bin/ipgw>>$desktop_path"
sudo sh -c " echo Icon=/opt/2645/neuipgw/ipgw.png>>$desktop_path"
sudo sh -c " echo Terminal=true>>$desktop_path"
sudo sh -c " echo Type=Application>>$desktop_path"
sudo sh -c " echo Categories=Network>>$desktop_path"

if [[ $zh_enable == 'y' ]] || [[ $zh_enable == 'Y' ]]; then
    echo "安装成功！"
else
    echo "Complete!"
fi


