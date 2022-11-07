help:
	@cat Makefile
lint:
	@find . -type f | grep -E "\.sh$$|\.bin/dotfiles$$" | xargs shellcheck
