#!/bin/bash

xhost +SI:localuser:xkeysnail
exec /bin/sudo -u xkeysnail /usr/local/bin/xkeysnail /etc/opt/xkeysnail/config.py >> /home/basd4g/.xkeysnail.log 2>&1

