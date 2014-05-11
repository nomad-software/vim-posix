#!/bin/sh

# sudo apt-get build-dep python
# sudo apt-get build-dep python3

# sudo apt-get install python-dev
# sudo apt-get install python3-dev

# ./configure --enable-gui=gtk2 --with-features=huge --enable-python3interp --with-python3-config-dir=/usr/lib/python3.2/config

sudo apt-get install ncurses-dev
./configure --enable-gui=gtk2 --with-features=huge
make
sudo make install
