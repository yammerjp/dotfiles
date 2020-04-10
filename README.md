![lint](https://github.com/basd4g/dotfiles/workflows/lint/badge.svg)
![macOS Setup (core packages)](https://github.com/basd4g/dotfiles/workflows/macOS%20Setup%20(core%20packages)/badge.svg)
![Ubuntu Setup (core packages)](https://github.com/basd4g/dotfiles/workflows/Ubuntu%20Setup%20(core%20packages)/badge.svg)
![Ubuntu Setup (all packages)"](https://github.com/basd4g/dotfiles/workflows/Ubuntu%20Setup%20(all%20packages)%22/badge.svg)

# dotfiles

## Setup

### Ubuntu Setup

```sh
$ curl -sL dot.basd4g.net | bash
$ cd ~/dotfiles
$ sudo make
```

### macOS Setup

```sh
# Sign in to Apple ID
$ open /Applications/App\ Store.app

# Setup Homebrew
$ xcode-select -install
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup my settings
$ curl -sL dot.basd4g.net | bash
$ cd ~/dotfiles
$ make

# Enable karabiner settings
$ open /Applications/Karabiner-Elements.app/
#   > Complex modifications > Add rule > basd4g's setting > Enable All
```

## Dotfiles

### Install and deploy dotfiles

```
$ curl -sL dot.basd4g.net | sh
$ cd ~/dotfiles
$ make link
```

### Add new dotfile

```sh
$ cd ~/dotfiles
$ mv ~/.hogerc ./
$ make link
# or
# $ ln -s ~/dotfiles/.hogerc ~/.hogerc
```

## LICENSE

MIT

## ToDo

- [ ] Add anyenv
- [ ] Add `dot.basd4g.net/help`

