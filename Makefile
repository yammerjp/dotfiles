# =========== setup all ===========
inits:                 # link, packages-mini, yarn, vim, macos-userdefaults, ubuntu-homedir-rename, ubuntu-gnome-term-load
	make link
	make packages-mini
	make yarn
	make vim
	make macos-userdefaults
	make ubuntu-homedir-rename
	make ubuntu-gnome-term-load

# =========== setup commands ===========
link:                  # Put symlinks of a dotfile
	bash bin/link.sh

packages-mini:         # Install minimum homebrew or apt packages
ifeq ($(shell uname), Darwin)
	brew bundle --file etc/Brewfile-mini
else ifeq ($(shell uname), Linux)
	bash bin/ubuntu-packages.sh minimum
endif

packages:              # Install homebrew or apt packages (HEAVY TRAFFIC)
ifeq ($(shell uname), Darwin)
	brew bundle --file etc/Brewfile
else ifeq ($(shell uname), Linux)
	bash bin/ubuntu-packages.sh
endif

packages-macos-x86_64:    # Install homebrew packages for x86_64 machine
ifeq ($(shell uname), Darwin)
	brew bundle --file etc/Brewfile-x86_64
endif

packages-macos-private:# Install homebrew packages for private machine
ifeq ($(shell uname), Darwin)
	brew bundle --file etc/Brewfile-private
endif

yarn:                  # Install nodejs packages
	yarn global add

vim:                   # Install vim plugins
	vim -s etc/vimop

ubuntu-zsh:            # Chenge default shell to zsh
ifeq ($(shell uname), Linux)
	which zsh ||  (echo "Please install zsh" && exit 1)
	chsh -s $(shell which zsh)
endif

ubuntu-deno:           # (ubuntu) Install deno
ifeq ($(shell uname), Linux)
	bash bin/ubuntu-deno.sh
endif

macos-userdefaults:    # (macOS) Set user-defaults
ifeq ($(shell uname), Darwin)
	bash bin/macos-userdefaults.sh
endif

ubuntu-homedir-rename: # (ubuntu) Rename directories in homedir from Japanese to English
ifeq ($(CI), true)
	@echo "Skip on CI"
else ifeq ($(shell uname), Linux)
		LANG=C xdg-user-dirs-gtk-update
endif

ubuntu-gnome-term-load:# (ubuntu) Load gnome-terminal settings
ifeq ($(CI), true)
	@echo "Skip on CI"
else ifeq ($(shell uname), Linux)
	dconf reset /org/gnome/terminal/
	dconf load /org/gnome/terminal/ < etc/gnome-terminal.dconf
endif

# =========== backup commands ===========
ubuntu-gnome-term-dump:# (ubuntu) Dump gnome-terminal settings
ifeq ($(shell uname), Linux)
	dconf dump /org/gnome/terminal/ > etc/gnome-terminal.dconf
endif

macos-brew-dump:       # (macOS) Dump installed packages with brew to `~/dotfiles/etc/Brewfile`
ifeq ($(shell uname), Darwin)
	rm -f etc/Brewfile
	brew bundle dump --file etc/Brewfile
endif

# =========== help message ===========
help:                  # Show this help
	@echo '# Hello, this is dotfiles written by yammerjp'
	@grep -E '^[a-z\-]+:' Makefile | head -1 | awk -F ':' '{ print $$1 }' | awk '{printf "make:                       # %s\n", $$0 }'
	@grep -E '^[a-z\-]+:' Makefile | awk '{printf "make %s\n", $$0 }'

