install:
	bin/install.sh
deploy:
	bin/deploy.sh
brew-init:
	bin/osx/brew-init.sh
brew-install:
	bin/osx/brew-install.sh
mas-install:
	bin/osx/mas-install.sh
help:
	@echo '# Hello, this is dotfiles written by basd4g'
	@echo 'make install      # Download latest dotfiles directory. (You already downloaded dotfiles)'
	@echo 'make deploy       # Put symlinks of a dotfile'
	@echo 'make brew-init    # Install homebrew'
	@echo 'make brew-install # Install homebrew packages'
	@echo 'make mas-install  # Install Mac App Store Softwares'
