# =========== help message ===========
help:                  # Show this help
	@echo '# Hello, this is dotfiles written by yammerjp'
	@grep -E '^[a-z\-]+:' Makefile | head -1 | awk -F ':' '{ print $$1 }' | awk '{printf "make:                       # %s\n", $$0 }'
	@grep -E '^[a-z\-]+:' Makefile | awk '{printf "make %s\n", $$0 }'
# =========== setup commands ===========
link:                  # Put symlinks of a dotfile
	make unlink
	bash bin/link-list.sh | xargs bash bin/link.sh skip
link-overwrite:        # Put symlinks of a dotfile with overwriting by specified dotfiles directories (stdin) if they conflict
	xargs bash bin/link.sh overwrite 
setup:                 # Run setup script for your environment (install packages, os settings, and so on ...)
	@echo "you can execute 'make setup' after excuting 'make link'"
	bash ~/.setup.sh
unlink:                # Remove symlinks of a dotfile
	pwd | xargs bash bin/unlink.sh
dotdirs:               # Show dotfile directories for your environment
	@bin/link-list.sh


