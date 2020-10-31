# =========== setup all ===========
inits:                 # run all scripts without packages, ubuntu-deno
	make link
	make packages-mini
	make macos-userdefaults
	make ubuntu-gnome-term-load
	make ubuntu-homedir-rename
	make yarn
	make vim
	make ubuntu-zsh

# =========== setup commands ===========
link:                  # Put symlinks of a dotfile
	bash bin/link.sh
packages-mini:         # Install minimum homebrew or apt packages
ifeq ($(shell uname), Darwin)
	bash bin/macos-packages.sh minimum
else ifeq ($(shell uname), Linux)
	bash bin/ubuntu-packages.sh minimum
endif
packages:              # Install homebrew or apt packages (very heavy)
ifeq ($(shell uname), Darwin)
	bash bin/macos-packages.sh
else ifeq ($(shell uname), Linux)
	bash bin/ubuntu-packages.sh
endif
yarn:                  # Install nodejs packages
	yarn global add
vim:                   # Install vim plugins
	vim -s etc/vimop
ubuntu-zsh:            # Chenge default shell to zsh
ifeq ($(CI), true)
	@echo "Skip on CI"
else ifeq ($(shell uname), Linux)
	bash bin/ubuntu-zsh.sh
endif
ubuntu-deno:           # (ubuntu) Install deno
ifeq ($(shell uname), Linux)
	bash bin/ubuntu-deno.sh
endif
macos-userdefaults:    # (macOS) Set user-defaults (macOS)
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
	@echo '# Hello, this is dotfiles written by basd4g'
	@grep -E '^[a-z\-]+:' Makefile | head -1 | awk -F ':' '{ print $$2 }' | awk '{printf "make:      %s\n", $$0 }'
	@grep -E '^[a-z\-]+:' Makefile | awk '{printf "make %s\n", $$0 }'

