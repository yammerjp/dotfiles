#!/bin/bash -e

# Change login shell to zsh.
which zsh ||  (echo "Please install zsh" && exit 1)
chsh -s $(shell which zsh)
