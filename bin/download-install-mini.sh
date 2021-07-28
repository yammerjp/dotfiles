#!/bin/sh -e
# -e オプションを付けると、シェルスクリプトの途中でエラーが発生する (終了コードが0でない) とその行で実行が中止されます


# 前提: このスクリプトを実行するには次のような環境である必要があります
#   1. パッケージマネージャとして yum が使える CentOS, AmazonLinux等)
#   2. sudo, curl が使える
#       それぞれインストールするには次のようなコマンドを実行します
#         $ su -c yum install -y sudo    # sudo コマンドのインストール
#         $ sudo yum install -y curl     # curl のインストール


# dotfilesをダウンロードする
# ========================================
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/env/common/.zshrc > ~/.zshrc
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/env/common/.zshrc-common > ~/.zshrc-common
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/env/common/.vimrc > ~/.vimrc
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/env/common/.vimrc-common > ~/.vimrc-common
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/env/common/.tmux.conf > ~/.tmux.conf
curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/env/common/.gitconfig > ~/.gitconfig


# 各種ソフトウェアをインストールする
# ========================================
## sudo するためのパスワードを $password 変数に格納する
printf "password: "
read password


# 格納したパスワードを使ってsudoを実行する
echo "$password" | sudo -S yum install -y git
echo "$password" | sudo -S yum install -y tmux
echo "$password" | sudo -S yum install -y zsh
echo "$password" | sudo -S yum install -y vim
echo "$password" | sudo -S yum install -y make
echo "$password" | sudo -S yum install -y util-linux-user # chshを使うために必要


# ログインシェルをzshに変更する
# ========================================

# ユーザ名を $username 変数に格納する
username=`whoami`
# 「ログインシェルをzshに変更する」を 格納した $password を使って sudo で実行
echo "$password" | sudo -S chsh --shell `which zsh` "$username"


echo "dotfiles is successfully installed!"
