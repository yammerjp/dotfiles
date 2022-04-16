[![lint](https://github.com/yammerjp/dotfiles/workflows/lint/badge.svg)](https://github.com/yammerjp/dotfiles/actions?query=workflow%3Alint)
[![macOS Setup](https://github.com/yammerjp/dotfiles/workflows/macOS%20Setup/badge.svg)](https://github.com/yammerjp/dotfiles/actions?query=workflow%3A%22macOS+Setup%22)
[![Ubuntu Setup](https://github.com/yammerjp/dotfiles/workflows/Ubuntu%20Setup/badge.svg)](https://github.com/yammerjp/dotfiles/actions?query=workflow%3A%22Ubuntu+Setup%22)

# My dotfiles

## Setup

### Ubuntu Setup

```sh
$ wget -q -O https://raw.githubusercontent.com/yammerjp/dotfiles/master/bin/download.sh | bash
$ cd ~/src/github.com/yammerjp/dotfiles/bin
$ ./dotfiles link
$ ./dotfiles setup
```

### macOS Setup

```sh
# Sign in to Apple ID
$ open /System/Applications/App\ Store.app

# Setup Homebrew
$ xcode-select --install
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup my settings
$ curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/bin/download.sh | bash
$ cd ~/src/github.com/yammerjp/dotfiles/bin
$ ./dotfiles link
$ ./dotfiles setup

# Enable macOS settings of User Defaults
$ sudo reboot

# Enable karabiner settings
$ open /Applications/Karabiner-Elements.app/
#   Complex modifications > Add rule > yammerjp's setting > Enable All

```

## LICENSE

MIT

## ToDo

- [ ] Add `dot.yammerjp.net/help`
