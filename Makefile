.PHONY: help, lint, docker/build, docker/run
# https://ktrysmt.github.io/blog/write-useful-help-command-by-shell/
help: ## print this message ## make help
	@echo "Example operations by makefile."
	@echo ""
	@echo "Usage: make SUB_COMMAND argument_name=argument_value"
	@echo ""
	@echo "Command list:"
	@echo ""
	@printf "\033[36m%-30s\033[0m %-50s %s\n" "[Sub command]" "[Description]" "[Example]"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2, $$3}'
lint: ## lint shell scripts ## make lint
	@find . -type f | grep -E "\.sh$$|\.bin/dotfiles$$" | xargs shellcheck
docker/build: ## build docker image ## make docker/build
	docker build . -t yammerjp/dotfiles:latest
docker/run: ## run docker image ## make docker/run
	docker run -it -v $$(pwd):/home/yammer/dotfiles -e LOCAL_UID=$$(id -u $$USER) -e LOCAL_GID=$$(id -g $$USER) yammerjp/dotfiles bash
