download:
	bin/download.sh
run:
	make link
	make packages-init
	make yarn-init
	make vim-init
	make zsh-init
link:
	bin/link.sh
packages-init:
	bin/packages-init.sh
yarn-init:
	bin/yarn-init.sh
vim-init:
	vim -s etc/vimop
zsh-init:
	bin/zsh-init.sh
brew-dump:
	bin/brew-dump.sh
help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make download      # Download dotfiles directory. (You already downloaded dotfiles)'
	@echo 'make run           # link, packages-init, yarn-init, vim-init'
	@echo 'make link          # Put symlinks of a dotfile'
	@echo 'make packages-init # Install homebrew packages'
	@echo 'make yarn-init     # Install nodejs packages'
	@echo 'make vim-init      # Install vim plugins'
	@echo 'make zsh-init      # Chenge default shell to zsh'
