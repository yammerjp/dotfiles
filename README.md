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

# Install Vim plugins
$ vim
#   And wait a few minutes

# Install Yarn global packages
$ yarn global add
```

## Add new dotfile

```sh
$ mv ~/.hogerc ~/dotfiles/
$ ln -s ~/dotfiles/.hogerc ~/.hogerc
```

## LICENSE

MIT

## ToDo

- CI
- Correspond for ubuntu
- Add anyenv
