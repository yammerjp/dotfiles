# =========== setup all ===========
inits:                 # run all scripts without packages, ubuntu-deno
	make link
	make packages-mini
	make macos-userdefaults
	make ubuntu-gnome-term-load:
	make ubuntu-homedir-rename
	make yarn
	make vim
	make ubuntu-zsh

# =========== setup commands ===========
link:                  # Put symlinks of a dotfile
	bash bin/link.sh
packages-mini:         # Install minimum homebrew or apt packages
	if [ "$(uname)" = "Darwin" ];then \
	  bash bin/macos-packages.sh minimum;\
	elif [ "$(uname)" = "Linux" ];then \
	  bash bin/ubuntu-packages.sh minimum;\
	fi
packages:              # Install homebrew or apt packages (very heavy)
	if [ "$(uname)" = "Darwin" ];then \
	  bash bin/macos-packages.sh;\
	elif [ "$(uname)" = "Linux" ];then \
	  bash bin/ubuntu-packages.sh;\
	fi
yarn:                  # Install nodejs packages
	yarn global add
vim:                   # Install vim plugins
	vim -s etc/vimop
ubuntu-zsh:            # Chenge default shell to zsh
	bash bin/ubuntu-zsh.sh
ubuntu-deno:           # (ubuntu) Install deno
	bash bin/ubuntu-deno.sh
macos-userdefaults:    # (macOS) Set user-defaults (macOS)
	if [ "$(uname)" = "Darwin" ];then \
		bash bin/macos-userdefaults.sh ;\
	fi
ubuntu-homedir-rename: # (ubuntu) Rename directories in homedir from Japanese to English
	if [ "$(uname)" = "Linux" ];then \
		LANG=C xdg-user-dirs-gtk-update ;\
	fi
ubuntu-gnome-term-load:# (ubuntu) Load gnome-terminal settings
	if [ "$(uname)" = "Linux" ];then \
		dconf reset /org/gnome/terminal/ ;\
		dconf load /org/gnome/terminal/ < etc/gnome-terminal.dconf ;\
	fi

# =========== backup commands ===========
ubuntu-gnome-term-dump:# (ubuntu) Dump gnome-terminal settings
	if [ "$(uname)" = "Linux" ];then \
		dconf dump /org/gnome/terminal/ > etc/gnome-terminal.dconf ;\
	fi
macos-brew-dump:       # (macOS) Dump installed packages with brew to `~/dotfiles/etc/Brewfile`
	if [ "$(uname)" = "Darwin" ]; then \
		rm -f etc/Brewfile ;\
		brew bundle dump --file etc/Brewfile ;\
	fi

# =========== help message ===========
help:                  # Show this help
	@echo '# Hello, this is dotfiles written by basd4g'
	@grep -E '^[a-z]+.*' Makefile | head -1 | awk -F ':' '{ print $$2 }' | awk '{printf "make:      %s\n", $$0 }'
	@grep -E '^[a-z]+.*' Makefile | awk '{printf "make %s\n", $$0 }'

