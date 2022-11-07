if ! yadm diff --exit-code > /dev/null ; then
  echo 'Please commit and push dotfiles diff!!!'
  yadm diff --name-only | cat
fi
