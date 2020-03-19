# dotfiles

## Install and deploy

```
# Install dotfiles
$ curl -L dot.basd4g.net | sh
# or
# curl -L http://raw.githubusercontent.com/basd4g/dotfiles/master/bin/install.sh | sh
# or
# git clone https://github.com/basd4g/dotfiles.git ~/dotfiles


$ cd ~/dotfiles

# Deploy dotfiles
$ make deploy

# Install homebrew
$ make brew-init

# install software
$ make brew-install

# Login Apple ID
$ mas open

# install mac app store software
$ make mas-install
```

## Add new dotfile

```sh
$ mv ~/.hogerc ~/dotfiles/
$ ln -s ~/dotfiles/.hogerc ~/.hogerc
```

## LICENSE

MIT

## ToDo

- load all vim plugin from dei.vim
- exclude a dependency of git in dein/load.vim
- install Powerline font before setup vim
- CI
- fit for ubuntu
