# Chrome
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
apt update
apt install google-chrome-stable

# Extension
# LINE
# BitWarden

