all:
	make link
	make os-init
	make packages-init
	make yarn-init
	make vim-init
	make zsh-init
link:
	bin/link.sh
os-init:
	bin/macos-defaults.sh
packages-init:
	bin/packages-init.sh
yarn-init:
	bin/yarn-init.sh
vim-init:
	vim -s etc/vimop
zsh-init:
	bin/zsh-init.sh
brew-dump:
	brew bundle dump --file Brewfile
help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make download      # Download dotfiles directory. (You already downloaded dotfiles)'
	@echo 'make run           # link, packages-init, yarn-init, vim-init, zsh-init'
	@echo 'make link          # Put symlinks of a dotfile'
	@echo 'make packages-init # Install homebrew packages'
	@echo 'make yarn-init     # Install nodejs packages'
	@echo 'make vim-init      # Install vim plugins'
	@echo 'make zsh-init      # Chenge default shell to zsh'
	@echo 'make brew-dump     # Dump installed packages with brew to `~/dotfiles/etc/brewfile-core` and `~/dotfiles/etc/brewfile`'

