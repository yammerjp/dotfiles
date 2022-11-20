function findDotfilesDiff() {
  comparing_branch="origin/$(yadm branch  | grep -e main -e master | sed 's/*//g' | awk '{ print $1}')"
  if ! yadm diff --exit-code --quiet "$comparing_branch" ; then
    cat 1>&2 << EOF
 ____  _     _____    _    ____  _____    ____ ___  __  __ __  __ ___ _____ 
|  _ \| |   | ____|  / \  / ___|| ____|  / ___/ _ \|  \/  |  \/  |_ _|_   _|
| |_) | |   |  _|   / _ \ \___ \|  _|   | |  | | | | |\/| | |\/| || |  | |  
|  __/| |___| |___ / ___ \ ___) | |___  | |__| |_| | |  | | |  | || |  | |  
|_|   |_____|_____/_/   \_\____/|_____|  \____\___/|_|  |_|_|  |_|___| |_|  

Find diff on dotfiles. Please commit or push diff!

$(yadm diff --name-only "$comparing_branch")
EOF
  fi
}

if [ "$FIND_DOTFILES_DIFF_EXECUTED" != "true" ]; then
  findDotfilesDiff
  FIND_DOTFILES_DIFF_EXECUTED="true"
fi
