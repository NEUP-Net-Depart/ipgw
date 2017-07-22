#!/bin/bash
#########################################################################
# File Name: get-ipgw.sh
# Author: LI JIAHAO
# ###############
# mail: lijiahao@cool2645.com
# Created Time: Fri 21 Jul 2017 10:59:43 PM CST
#########################################################################

main() {
	if [ -x "$(command -v tput)" ]; then
		ncolors=$(tput colors)
	fi
	if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
		RED="$(tput setaf 1)"
		GREEN="$(tput setaf 2)"
		YELLOW="$(tput setaf 3)"
		BLUE="$(tput setaf 4)"
		BOLD="$(tput bold)"
		NORMAL="$(tput sgr0)"
	else
		RED=""
	    GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		NORMAL=""
	fi

	SOURCE="$0"
	while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
	    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
		SOURCE="$(readlink "$SOURCE")"
		[[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	done
	DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

	if [ ! -x "$(command -v curl)" ]; then
		if [ ! -x "$(command -v wget)" ]; then
			echo "Error: Neither curl nor wget is installed"
		else
			cd /tmp
			mkdir -p neu-ipgw_linux
			cd neu-ipgw_linux
			printf "${BLUE}Downloading neu-ipgw...${NORMAL}\n"
			wget -O ipgw.sh https://ipgw.tk/neu-ipgw_linux/ipgw.sh
			wget -O install.sh https://ipgw.tk/neu-ipgw_linux/install.sh
			wget -O uninstall.sh https://ipgw.tk/neu-ipgw_linux/uninstall.sh
			wget -O user.cfg https://ipgw.tk/neu-ipgw_linux/user.cfg
			wget -O ipgw.png https://ipgw.tk/neu-ipgw_linux/ipgw.png
			wget -O README.md https://ipgw.tk/neu-ipgw_linux/README.md
			bash ./install.sh
		fi
	else
		cd /tmp
		mkdir -p neu-ipgw_linux
		cd neu-ipgw_linux
		printf "${BLUE}Downloading neu-ipgw...${NORMAL}\n"
		curl -o ipgw.sh https://ipgw.tk/neu-ipgw_linux/ipgw.sh
		curl -o install.sh https://ipgw.tk/neu-ipgw_linux/install.sh
		curl -o uninstall.sh https://ipgw.tk/neu-ipgw_linux/uninstall.sh
		curl -o user.cfg https://ipgw.tk/neu-ipgw_linux/user.cfg
		curl -o ipgw.png https://ipgw.tk/neu-ipgw_linux/ipgw.png
		curl -o README.md https://ipgw.tk/neu-ipgw_linux/README.md
		printf "${BLUE}Installing neu-ipgw...${NORMAL}\n"
		bash ./install.sh
	fi

	cd $DIR

}

main
