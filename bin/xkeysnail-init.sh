#!/bin/bash -e

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi


if ! grep -E "^uinput:" /etc/group > /dev/null ; then
  echo 'groupadd uinput'
  groupadd uinput
fi

if grep -E "^xkeysnail:" /etc/passwd > /dev/null; then
  echo 'userdel xkeysnail'
  userdel xkeysnail
fi

echo 'useradd xkeysnail'
useradd -G input,uinput -M -s /bin/false xkeysnail
echo 'KERNEL=="uinput", GROUP="uinput"' > /etc/udev/rules.d/input.rules
echo 'uinput' > /etc/modules-load.d/uinput.rules
udevadm control --reload-rules && udevadm trigger

DOTFILES_DIR=$(cd "$(dirname "$0")/../" ; pwd)

rm -rf "/etc/opt/xkeysnail"
mkdir -p "/etc/opt/xkeysnail"
ln -s "$DOTFILES_DIR/etc/xkeysnail/start.sh" "/etc/opt/xkeysnail/start.sh"
ln -s "$DOTFILES_DIR/etc/xkeysnail/config.py" "/etc/opt/xkeysnail/config.py"

systemctl daemon-reload
systemctl --user enable xkeysnail
