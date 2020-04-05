download:
	bin/download.sh
run:
	make link
	make packages-init
	make yarn-init
	make vim-init
link:
	bin/link.sh
packages-init:
	bin/packages-init.sh
yarn-init:
	yarn global add
vim-init:
	vim -s bin/vimop
help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make download      # Download dotfiles directory. (You already downloaded dotfiles)'
	@echo 'make run           # link, packages-init, yarn-init, vim-init'
	@echo 'make link          # Put symlinks of a dotfile'
	@echo 'make packages-init # Install homebrew packages'
	@echo 'make yarn-init     # Install nodejs packages'
	@echo 'make vim-init      # Install vim plugins'
