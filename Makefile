inits:
	make link
	make os-init
	make packages-init-mini
	make yarn-init
	make vim-init
	make zsh-init
link:
	bin/link.sh
os-init:
	bin/macos-defaults.sh
packages-init-mini:
	bin/packages-init.sh minimum
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
	@echo 'make               # make inits'
	@echo 'make inits         # run all scripts without packages-init'
	@echo 'make link          # Put symlinks of a dotfile'
	@echo 'make os-init       # set macOS settings with `defaults` commands'
	@echo 'make packages-init # Install homebrew or apt packages (very heavy)'
	@echo 'make packages-init-mini # Install minimum homebrew or apt packages'
	@echo 'make yarn-init     # Install nodejs packages'
	@echo 'make vim-init      # Install vim plugins'
	@echo 'make zsh-init      # Chenge default shell to zsh'
	@echo 'make brew-dump     # Dump installed packages with brew to `~/dotfiles/Brewfile`'

