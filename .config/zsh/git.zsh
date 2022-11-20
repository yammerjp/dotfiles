alias g='git'
alias ga.='git add .'
alias gs='git status'
alias git-config-edit="vim ~/.config/git/config"

function gclone() {
  if [ -z "$1" ]; then
    echo 'Usage: gclone username reponame # clone git repository from github.com'
    return 1
  fi
  if [[ "$1" =~ '\.' ]]; then
    host="$1"
    repo="$2/$3"
  else
    host="github.com"
    if [[ "$1" =~ '/' ]]; then
      repo="$1"
    else
      repo="$1/$2"
    fi
    if [ -z "$2" ]; then
      repo="yammerjp/$1"
    fi
  fi
  clone_to="$HOME/src/${host}/${repo}"
  clone_from="git@${host}:${repo}.git"
  if ! git clone "${clone_from}" "${clone_to}"; then
    echo "Failed to clone from '${clone_from}' to '${clone_to}'"
    return 1
  fi
  cd "${clone_to}"
  echo "Cloned from '${clone_from}' to '${clone_to}', and moved there"
}

# ghqでcloneしたリポジトリ一覧
function ghq_code() {
  local repo="$(ghq list | fzf --preview "bat --color=always --style=numbers --line-range=:100 $(ghq root)/{}/README.*")"
  if [ -n "$repo" ]; then
    BUFFER="cd $(ghq root)/${repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq_code
bindkey '^f' ghq_code

function cr() {
  repo_path_from_root="$(ghq list | fzf --query "$@")"
  ret="$?"
  if [ "$ret" -ne 0 ]; then
    return "$ret"
  fi
  cd "$(ghq root)/$repo_path_from_root"
}

function git-pull-latest() {
  if ! git -C "$GIT_REPOSITORY_PATH" diff --exit-code -s; then
    echo "\e[31mfailed to pull, found diff: $GIT_REPOSITORY_PATH\e[m" 1>&2
    echo "$GIT_REPOSITORY_PATH" >> ~/.git-pull-latest.git-repository-path.found-diff.log
    return
  fi

  git -C "$GIT_REPOSITORY_PATH" fetch origin

  local head="$(git -C "$GIT_REPOSITORY_PATH" rev-parse --abbrev-ref HEAD)"
  if [ "$head" != "master" ] && [ "$head" != "main" ]; then
    git -C "$GIT_REPOSITORY_PATH" checkout master || git -C "$GIT_REPOSITORY_PATH" checkout main
  fi

  head="$(git -C "$GIT_REPOSITORY_PATH" rev-parse --abbrev-ref HEAD)"
  if [ "$head" != "master" ] && [ "$head" != "main" ]; then
    echo "\e[31mfailed to checkout to master: $GIT_REPOSITORY_PATH\e[m" 1>&2
    echo "$GIT_REPOSITORY_PATH" >> ~/.git-pull-latest.git-repository-path.failed-to-checkout.log
    return
  fi

  git -C "$GIT_REPOSITORY_PATH" merge origin/"$head" --ff-only
}

function git-pull-latest-all() {
  rm  ~/.git-pull-latest.git-repository-path.*.log
  ghq list | awk "{printf \"$(ghq root)/%s\n\", \$1}" | while read GIT_REPOSITORY_PATH; do
  echo "git-pull-latest: $GIT_REPOSITORY_PATH" 1>&2
    git-pull-latest
  done
}

function cd-failed-directory-git-pull-latest-all() {
  cd $(cat ~/.git-pull-latest.*.log | fzf)
}
