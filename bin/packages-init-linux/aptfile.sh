apt install -y gdebi
apt install -y ffmpeg
apt install -y git
apt install -y lynx
apt install -y mysql-server
apt install -y mysql-client
apt install -y nkf
apt install -y nmap
apt install -y shellcheck
apt install -y tree
apt install -y ibus-mozc

# xkeysnail
apt install python3-pip
pip3 install xkeysnail

snap install --classic code
snap install --classic heroku

WORKING_DIR=`pwd`

bash "$WORKING_DIR/aptfile.sh"
bash "$WORKING_DIR/docker.sh"
bash "$WORKING_DIR/google-chrome.sh"
bash "$WORKING_DIR/hackgen.sh"
bash "$WORKING_DIR/hyper.sh"
bash "$WORKING_DIR/postgresql.sh"
