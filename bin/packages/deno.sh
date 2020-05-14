#!/bin/bash -e

curl -fsSL https://deno.land/x/install/install.sh | sh

"$HOME/.deno/bin/deno" implementions zsh > /usr/local/share/zsh/site-functions/_deno

