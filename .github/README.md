[![lint](https://github.com/yammerjp/dotfiles/workflows/lint/badge.svg)](https://github.com/yammerjp/dotfiles/actions?query=workflow%3Alint)
[![macOS Setup](https://github.com/yammerjp/dotfiles/workflows/macOS%20Setup/badge.svg)](https://github.com/yammerjp/dotfiles/actions?query=workflow%3A%22macOS+Setup%22)
[![Ubuntu Setup](https://github.com/yammerjp/dotfiles/workflows/Ubuntu%20Setup/badge.svg)](https://github.com/yammerjp/dotfiles/actions?query=workflow%3A%22Ubuntu+Setup%22)

# My dotfiles

## Setup

### Ubuntu Setup

```sh
DOTFILES_EXECUTE_LINK=true DOTFILES_EXECUTE_SETUP=true bash -c "$(wget -q -O https://raw.githubusercontent.com/yammerjp/dotfiles/master/.bin/download.sh )"
```

### macOS Setup

```sh
# Sign in to Apple ID
open /System/Applications/App\ Store.app

# Setup Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup my settings
DOTFILES_EXECUTE_LINK=true DOTFILES_EXECUTE_SETUP=true bash -c "$(curl -sL https://raw.githubusercontent.com/yammerjp/dotfiles/master/.bin/download.sh )"

# Enable macOS settings of User Defaults
sudo reboot

# Enable karabiner settings
open /Applications/Karabiner-Elements.app/
#   Complex modifications > Add rule > yammerjp's setting > Enable All

```

## LICENSE

```
MIT License

Copyright (c) 2020 Keisuke Nakayama

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## ToDo

- [ ] Add `dot.yammerjp.net/help`
