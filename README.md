# dotfiles

## Install and deploy

```
# Deploy dotfiles
$ curl -L dot.basd4g.net | sh
# or
# curl -L http://raw.githubusercontent.com/basd4g/dotfiles/master/bin/install.sh | sh

$ cd 

# Install homebrew
$ ~/dotfiles/bin/osx/brew-init.sh

# install software
$ ~/dotfiles/bin/osx/brew-install.sh

# Login Apple ID
$ mas open

# install mac app store software
$ ~/dotfiles/bin/osx/mas-install.sh
```

## clone

```sh
git clone https://github.com/basd4g/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## add new dotfile

```sh
$ mv ~/.hogerc ~/dotfiles/
$ ln -s ~/dotfiles/.hogerc ~/.hogerc
```

## ToDo

- exclude a dependency of git in dein/load.vim
- install Powerline font before setup vim
- CI
- ubuntu version
