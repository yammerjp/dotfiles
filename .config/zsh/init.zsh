function os_distribution() {
  if uname -v | grep -q "Ubuntu"; then  # 0 ... ubuntu / 1 ... other 
    echo 'Ubuntu'
    return
  fi
}

OS="$(uname -s)"          # Darwin Linux
ARCH="$(uname -m)"        # arm64 x86_64
DIST="$(os_distribution)" # Ubuntu         # allow empty

ZSH_SCRIPT_FILENAMES=( \
  "variables.zsh" \
  "${(L)OS}-${(L)DIST}-${(L)ARCH}.zsh" \
  "${(L)OS}-${(L)DIST}.zsh" \
  "${(L)OS}.zsh" \
  "prompt.zsh" \
  "history.zsh" \
  "completion.zsh" \
  "alias.zsh" \
  "git.zsh" \
  "gdb.zsh" \
  "detect-to-edit-dotfiles.zsh" \
)

for ELEMENT in $ZSH_SCRIPT_FILENAMES; do
  if [ -e "$HOME/.config/zsh/$ELEMENT" ]; then
    source "$HOME/.config/zsh/$ELEMENT"
  fi
done

# ---
# TODO
# commitしていないファイルがあるかを確認
# fetchの最終日から時間が経っているかを確認 (毎回fetchしてられない)
# pushの最終日から時間が経っているかを確認 (毎回pushしてられない)
# それらを確認して最新に更新し、更新日を記録する関数を追加


# # 計測
# # for i in $(seq 1 10); do time zsh -i -c exit; done
# # zmodload zsh/zprof && zprof
# 
# # 計測
# if (which zprof > /dev/null 2>&1) ;then
#   zprof | less
# fi
