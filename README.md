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
$ make link
```

## macOS Setup

```sh
# Sign in to Apple ID
$ open /Applications/App\ Store.app

# Setup Homebrew
$ xcode-select -install
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup my settings
$ MAKE_RUN=1 /bin/bash -c "$(curl -fsSL dot.basd4g.net)"

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

- CI
- Correspond for ubuntu
- Add anyenv
