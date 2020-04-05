# dotfiles

## Install and deploy

### Dotfiles
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
```

### macOS apps

```
$ make brew-init

$ make brew-install

# Sign in to Apple ID
$ open /Applications/App\ Store.app

$ make mas-install

# Enable karabiner settings
$ open /Applications/Karabiner-Elements.app/
#   > Complex modifications > Add rule > basd4g's setting > Enable All
```

### Ubuntu apps

```
```

### Common apps Setup

```
# Install Yarn global packages
$ yarn global add

# Install Vim plugins
$ vim
#   And wait a few minutes
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
