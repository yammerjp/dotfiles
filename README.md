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

# Install softwares from homebrew
$ make brew-install

# Login Apple ID
$ mas open

# Install softwares from Mac App Store
$ make mas-install

# Enable karabiner settings
$ open /Applications/Karabiner-Elements.app/
#   > Complex modifications > Add rule > basd4g's setting > Enable All
```

## Add new dotfile

```sh
$ mv ~/.hogerc ~/dotfiles/
$ ln -s ~/dotfiles/.hogerc ~/.hogerc
```

## LICENSE

MIT

## ToDo

- Load all vim plugin from dein.vim
- Exclude a dependency of git in dein/load.vim
- CI
- Correspond for ubuntu
- Add anyenv
