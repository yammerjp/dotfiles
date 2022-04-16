#!/bin/bash -e
# shellcheck disable=SC2046,SC1091,SC2034

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

source test-util.sh

DOTFILES_RUN_MODE="debug"
source ../bin/dotfiles

# mock
function uname() {
  if [ "$1" = '-s' ]; then
    echo -n "$MOCK_OS"
  elif [ "$1" = '-m' ]; then
    echo -n "$MOCK_ARCH"
  elif [ "$1" = '-v' ]; then
    echo -n "$MOCK_DIST"
  fi
}

test_case 'link-list.sh macOS, Apple Silicon' "$(
	OS="Darwin"
	ARCH="arm64"
	DIST=""
	HOME="__this_is_home_dir__"
	assert \
		"__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Darwin--arm64:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Darwin:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/common" \
		"echo $(dotdirs)"
)"

test_case "link-list.sh Ubuntu, x86_64" "$(
	OS="Linux"
	ARCH="x86_64"
	DIST="Ubuntu"
	HOME="__this_is_home_dir__"

	assert \
		"__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu-x86_64:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/common" \
		"echo $(dotdirs)"
)"
