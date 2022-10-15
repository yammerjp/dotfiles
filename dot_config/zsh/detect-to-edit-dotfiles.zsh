DOTFILES_DIR="$HOME/src/github.com/yammerjp/dotfiles"
if ! git --work-tree=$DOTFILES_DIR --git-dir=$DOTFILES_DIR/.git diff --exit-code > /dev/null ; then
  echo 'Please commit and push dotfiles diff!!!'
  git --work-tree=$DOTFILES_DIR --git-dir=$DOTFILES_DIR/.git diff --name-only | cat
fi
