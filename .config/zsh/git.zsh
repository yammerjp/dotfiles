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
  QUERY="$@"
  if [ "$QUERY" != "" ]; then
    repo_path_from_root="$(ghq list | fzf --query "$@")"
  else
    repo_path_from_root="$(ghq list | fzf )"
  fi
  ret="$?"
  if [ "$ret" -ne 0 ]; then
    return "$ret"
  fi
  cd "$(ghq root)/$repo_path_from_root"
}
