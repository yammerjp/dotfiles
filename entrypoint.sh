#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
useradd -u "$USER_ID" -o -m yammer
groupmod -g "$GROUP_ID" yammer
export HOME=/home/yammer

chown -R yammer:yammer $HOME
exec /usr/sbin/gosu yammer "$@"
