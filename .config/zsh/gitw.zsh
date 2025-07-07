# fzf がインストールされているかチェック
if ! type fzf &> /dev/null; then
  echo "警告: fzf がインストールされていません。fzf関連の機能は無効になります。" >&2
fi

# Git Worktree 管理関数
# gitw add <worktree名> : 新しいworktreeを作成し移動
# gitw rm : worktreeを削除 (現在のworktreeは削除不可、fzfで選択)
# gitw cd : fzfでworktreeを選択し移動
# gitw list : worktreeの一覧を表示
function gitw() {
  local current_repo_root
  current_repo_root=$(git rev-parse --show-toplevel 2>/dev/null)

  if [ -z "$current_repo_root" ]; then
    echo "エラー: Gitリポジトリのルートディレクトリにいる必要があります。"
    return 1
  fi

  local command="$1"
  shift # 最初の引数をシフトして残りの引数を処理

  case "$command" in
    add)
      local worktree_name="$1"
      if [ -z "$worktree_name" ]; then
        echo "使用法: gitw add <worktree名>"
        return 1
      fi

      local worktree_path="${current_repo_root}/worktrees/${worktree_name}"
      local default_branch=""

      # リモートのデフォルトブランチ (HEAD) を取得
      default_branch=$(git remote show origin 2>/dev/null | grep 'HEAD branch' | awk '{print $NF}')

      # もしリモートのHEADブランチが取得できなければ、masterとmainを試す
      if [ -z "$default_branch" ]; then
        if git rev-parse --verify master &>/dev/null; then
          default_branch="master"
        elif git rev-parse --verify main &>/dev/null; then
          default_branch="main"
        else
          echo "エラー: デフォルトブランチ (main/master) を特定できませんでした。"
          return 1
        fi
      fi

      echo "デフォルトブランチ '$default_branch' を起点にworktreeを作成します。"
      git worktree add -b "${worktree_name}" "${worktree_path}" "${default_branch}"
      
      if [ $? -eq 0 ]; then
        echo "Worktree '${worktree_name}' を '${worktree_path}' に作成しました。"
        cd "${worktree_path}" || return 1
        echo "'${worktree_path}' へ移動しました。"
        gitw_update_tmux_window_name # tmuxウィンドウ名を更新
      else
        echo "エラー: Worktreeの作成に失敗しました。"
        return 1
      fi
      ;;

    rm)
      local current_worktree_path
      current_worktree_path=$(git rev-parse --show-wt-toplevel 2>/dev/null) # 現在のworktreeのルートパスを取得

      echo "削除するworktreeを選択してください (現在のworktreeは削除できません)。"

      # fzfを使ってworktreeを選択
      # HEAD (現在のディレクトリ) は除外
      local selected_worktree
      if type fzf &> /dev/null; then
        selected_worktree=$(git worktree list --porcelain | awk '/^worktree/ {print substr($0, index($0, $2))}' | grep -v "^${current_worktree_path}" | fzf --prompt="削除するworktreeを選択: ")
      else
        echo "fzfがインストールされていないため、インタラクティブな選択はできません。"
        echo "利用可能なworktree:"
        git worktree list --porcelain | awk '/^worktree/ {print substr($0, index($0, $2))}' | grep -v "^${current_worktree_path}"
        echo "手動で削除したい場合は 'git worktree remove <path>' を使ってください。"
        return 1
      fi

      if [ -z "$selected_worktree" ]; then
        echo "選択がキャンセルされました。"
        return 1
      fi

      echo "Worktree '${selected_worktree}' を削除しますか？ (y/N)"
      read -r confirmation
      if [[ "$confirmation" =~ ^[yY]$ ]]; then
        git worktree remove "${selected_worktree}"
        if [ $? -eq 0 ]; then
          echo "Worktree '${selected_worktree}' を削除しました。"
        else
          echo "エラー: Worktreeの削除に失敗しました。"
          return 1
        fi
      else
        echo "削除をキャンセルしました。"
      fi
      ;;

    cd)
      echo "移動するworktreeを選択してください。"

      local selected_worktree
      if type fzf &> /dev/null; then
        selected_worktree=$(git worktree list --porcelain | awk '/^worktree/ {print substr($0, index($0, $2))}' | fzf --prompt="移動するworktreeを選択: ")
      else
        echo "fzfがインストールされていないため、インタラクティブな選択はできません。"
        echo "利用可能なworktree:"
        git worktree list
        echo "手動で移動したい場合は 'cd <path>' を使ってください。"
        return 1
      fi

      if [ -z "$selected_worktree" ]; then
        echo "選択がキャンセルされました。"
        return 1
      fi

      if [ -d "$selected_worktree" ]; then
        cd "$selected_worktree" || return 1
        echo "'${selected_worktree}' へ移動しました。"
        gitw_update_tmux_window_name # tmuxウィンドウ名を更新
      else
        echo "エラー: 選択されたパスは有効なディレクトリではありません。"
        return 1
      fi
      ;;

    list|ls)
      echo "現在のリポジトリのWorktree一覧:"
      git worktree list
      ;;

    *)
      echo "使用法: gitw <add|rm|cd|list>"
      echo "  add <worktree名>: 新しいworktreeを作成し移動"
      echo "  rm              : worktreeを削除 (fzfで選択)"
      echo "  cd              : fzfでworktreeを選択し移動"
      echo "  list|ls         : worktreeの一覧を表示"
      return 1
      ;;
  esac
}

# tmuxのウィンドウ名を更新するヘルパー関数
function gitw_update_tmux_window_name() {
  if command -v tmux &> /dev/null && [ -n "$TMUX" ]; then
    local current_branch
    current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    local repo_name
    repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
    
    if [ -n "$repo_name" ] && [ -n "$current_branch" ]; then
      tmux rename-window "${repo_name}:${current_branch}"
    elif [ -n "$repo_name" ]; then
      tmux rename-window "${repo_name}"
    fi
  fi
}

# gitw関数をgitエイリアスとして登録
# ~/.gitconfig に以下のように記述される
# [alias]
#   w = "!f() { gitw \"$@\"; }; f"
# または
# git config --global alias.w '!f() { gitw "$@"; }; f'
