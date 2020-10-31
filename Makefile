# =========== setup all ===========
inits:                 # run all scripts without packages-init, deno-init
	make link
	make packages-init-mini
	make user-defaults-init
	make gnome-terminal-load
	make ubuntu-homedir-rename
	make yarn-init
	make vim-init
	make zsh-init

# =========== setup commands ===========
link:                  # Put symlinks of a dotfile
	bash bin/link.sh
packages-init-mini:    # Install minimum homebrew or apt packages
	bash bin/packages/init.sh minimum
packages-init:         # Install homebrew or apt packages (very heavy)
	bash bin/packages/init.sh
yarn-init:             # Install nodejs packages
	yarn global add
vim-init:              # Install vim plugins
	vim -s etc/vimop
zsh-init:              # Chenge default shell to zsh
	bash bin/zsh-init.sh
deno-init:             # (ubuntu) Install deno
	bash bin/packages/deno.sh
user-defaults-init:    # (macOS) Set user-defaults (macOS)
	if [ "$(uname)" = "Darwin" ];then \
		bash bin/user-defaults/init.sh ;\
	fi
ubuntu-homedir-rename: # (ubuntu) Rename directories in homedir from Japanese to English
	if [ "$(uname)" = "Linux" ];then \
		LANG=C xdg-user-dirs-gtk-update ;\
	fi
gnome-terminal-load:   # (ubuntu) Load gnome-terminal settings
	if [ "$(uname)" = "Linux" ];then \
		dconf reset /org/gnome/terminal/ ;\
		dconf load /org/gnome/terminal/ < etc/gnome-terminal.dconf ;\
	fi

# =========== backup commands ===========
gnome-terminal-dump:   # (ubuntu) Dump gnome-terminal settings
	if [ "$(uname)" = "Linux" ];then \
		dconf dump /org/gnome/terminal/ > etc/gnome-terminal.dconf ;\
	fi
brew-dump:             # (macOS) Dump installed packages with brew to `~/dotfiles/etc/Brewfile`
	if [ "$(uname)" = "Darwin" ]; then \
		rm -f etc/Brewfile ;\
		brew bundle dump --file etc/Brewfile ;\
	fi

# =========== help message ===========
help:                  # Show this help
	@echo '# Hello, this is dotfiles written by basd4g'
	@grep -E '^[a-z]+.*' Makefile | head -1 | awk -F ':' '{ print $$2 }' | awk '{printf "make:      %s\n", $$0 }'
	@grep -E '^[a-z]+.*' Makefile | awk '{printf "make %s\n", $$0 }'

