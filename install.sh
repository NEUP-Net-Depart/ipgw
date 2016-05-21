#########################################################################
# File Name: install.sh
# Author: Li Jiahao
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Sat 21 May 2016 02:18:25 PM CST
#########################################################################
#!/bin/bash

mkdir /usr/local/neuipgw
cp ./ipgw.sh /usr/local/neuipgw/ipgw.sh
cp ./user.cfg /usr/local/neuipgw/user.cfg
cp ./ipgw.png /usr/local/neuipgw/ipgw.png

echo [Desktop Entry]>/usr/share/applications/neuipgw.desktop
echo Name=NEU-IPGW>>/usr/share/applications/neuipgw.desktop
echo Comment=Speedier Internet Access>>/usr/share/applications/neuipgw.desktop
echo Exec=sh /usr/local/neuipgw/ipgw.sh>>/usr/share/applications/neuipgw.desktop
echo Icon=/usr/local/neuipgw/ipgw.png>>/usr/share/applications/neuipgw.desktop
echo Terminal=true>>/usr/share/applications/neuipgw.desktop
echo Type=Application>>/usr/share/applications/neuipgw.desktop
echo Categories=Network>>/usr/share/applications/neuipgw.desktop
