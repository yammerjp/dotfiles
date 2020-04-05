install:
	bin/install.sh
deploy:
	bin/deploy.sh
brew-install:
	brew bundle --global

help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make install      # Download latest dotfiles directory. (You already downloaded dotfiles)'
	@echo 'make deploy       # Put symlinks of a dotfile'
	@echo 'make brew-install # Install homebrew packages'
