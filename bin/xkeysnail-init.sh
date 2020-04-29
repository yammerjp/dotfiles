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

DOT_XKEYSNAIL_DIR=$(cd "$(dirname "$0")/../etc/xkeysnail" ; pwd)

echo 'symlink start.sh, config.py'
rm -rf "/etc/opt/xkeysnail"
mkdir -p "/etc/opt/xkeysnail"
ln -s "$DOT_XKEYSNAIL_DIR/start.sh" "/etc/opt/xkeysnail/start.sh"
ln -s "$DOT_XKEYSNAIL_DIR/config.py" "/etc/opt/xkeysnail/config.py"

echo 'Add line to /etc/sudoers'
unroot_user="${SUDO_USER:-$USER}"
sudoers_line="$unroot_user ALL=(xkeysnail) NOPASSWD: /usr/local/bin/xkeysnail"
if ! grep -x "$sudoers_line" /etc/sudoers > /dev/null 2>&1 ; then
  echo "$sudoers_line" | EDITOR='tee -a' visudo > /dev/null
fi

# echo 'systemctl reload and enable xkeysnail'
# systemctl daemon-reload
# systemctl enable "$DOT_XKEYSNAIL_DIR/xkeysnail.service"
# systemctl start xkeysnail

