NEU-IPGW(Linux)
=

[![GitHub release](https://img.shields.io/github/release/2645Corp/neuipgw_linux.svg?maxAge=2592000)](https://github.com/2645Corp/neuipgw_linux/releases)
[![2645 Studio](https://img.shields.io/badge/Powered%20by-2645%20Studio-yellowgreen.svg)](http://www.cool2645.com/)

This program is designed to pass the neu ip gateway easily.

Find [[Wiki]](https://github.com/2645Corp/neu-ipgw_linux/wiki) if you need.

### Quick Start

**To install it to your computer,**

open terminal and run

`$ sh ./install.sh`

The program will require sudo password.

After running the installer, you may either start from the "Application Menu", or run by command `ipgw`. <br>
Use `ipgw --help` to get more information of usage. <br>

**For version v2.3 and later**

The program will be installed to `/opt/2645/neuipgw/` <br>
You may change the configuration of the installed program by editing `~/.neuipgw/user.cfg`

**For version v2.1 and before**

The program will be installed to `/usr/local/neuipgw/` <br>
The configuration file will be stored at `/usr/local/neuipgw/user.cfg`

**If you prefer not to install it,**

Just sh the ipgw.sh, it will also work okay. The configuration will be sourced from the file `user.cfg` under the same directory as the program.
