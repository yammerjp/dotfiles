install:
	bin/install.sh
deploy:
	bin/deploy.sh
brew-init:
	bin/brew-init.sh
brew-install:
	brew bundle --global
mas-install:
	brew bundle --file Brewfile-mas

help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make install      # Download latest dotfiles directory. (You already downloaded dotfiles)'
	@echo 'make deploy       # Put symlinks of a dotfile'
	@echo 'make brew-init    # Install homebrew'
	@echo 'make brew-install # Install homebrew packages'
	@echo 'make mas-install  # Install Mac App Store Softwares'
