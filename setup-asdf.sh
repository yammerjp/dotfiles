#!/bin/bash

set -e

## INSTALL NODEJS
asdf plugin add nodejs || echo 'already added plugin'
asdf install nodejs latest
asdf global nodejs latest

## INSTALL RUBY
# ref: https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
if which apt-get > /dev/null; then
  sudo apt-get update -y
  sudo apt-get install -y autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
elif which brew > /dev/null; then
  brew install openssl@3 readline libyaml gmp rust bison
  prefix="$(brew --prefix openssl@3)"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$prefix"
  # need to execute other commands to install for ruby ~3.0.x
  # ref: https://github.com/rbenv/ruby-build/wiki#macos
else
  echo "Need dependencies for ruby"
  exit 1
fi
asdf plugin add ruby || echo 'already added plugin'
asdf install ruby latest
asdf global ruby latest
# brew install openssl@1.1 readline libyaml gmp
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# asdf install ruby 2.7.7
# asdf install ruby 3.0.5

## INSTALL PHP
# ref: https://github.com/asdf-community/asdf-php/blob/master/.github/workflows/workflow.yml
if which apt-get > /dev/null; then
  sudo apt-get update -y
  sudo apt-get install -y autoconf bison build-essential curl gettext git libgd-dev libcurl4-openssl-dev libedit-dev libicu-dev libjpeg-dev libmysqlclient-dev libonig-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libzip-dev openssl pkg-config re2c zlib1g-dev
elif which brew > /dev/null; then
  brew install autoconf automake bison freetype gd gettext icu4c krb5 libedit libiconv libjpeg libpng libxml2 libzip openssl@1.1 pkg-config re2c zlib libsodium bison re2c gd libiconv libzip oniguruma
else
  echo "Need dependencies for PHP"
  exit 1
fi
asdf plugin add php || echo 'already added plugin'
asdf install php latest
asdf global php latest
# https://github.com/phpbrew/phpbrew/issues/1263
# cd $HOME
# wget https://www.openssl.org/source/openssl-1.1.1i.tar.gz
# tar xzf $HOME/openssl-1.1.1i.tar.gz
# cd openssl-1.1.1i
# ./Configure --prefix=$HOME/openssl-1.1.1i/bin -fPIC -shared linux-x86_64
# make -j 8
# make install
# pkg_config_path="$PKG_CONFIG_PATH"
# export PKG_CONFIG_PATH=$HOME/openssl-1.1.1i/bin/lib/pkgconfig
# asdf install php 7.4.33
