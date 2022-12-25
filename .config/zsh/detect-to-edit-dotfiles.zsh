if [ "$FIND_DOTFILES_DIFF_EXECUTED" != "true" ]; then
  find-dotfiles-diff
  FIND_DOTFILES_DIFF_EXECUTED="true"
fi
