# =========== help message ===========
all:
	make build
	make run
build:                  # Show this help
	docker build . -t yammerjp-dotfiles-dev:latest
# =========== setup commands ===========
run:                  # Put symlinks of a dotfile
	docker run --rm  -v "$(CURDIR)/../:/home/ubuntu/dotfiles-remote" -it yammerjp-dotfiles-dev:latest zsh
