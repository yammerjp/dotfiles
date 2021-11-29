#!/bin/bash -e
# shellcheck disable=SC2046,SC1091

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

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

source test-util.sh

## __test_case__ macOS, Apple Silicon
test_case 'link-list.sh macOS, Apple Silicon' "$(
	MOCK_OS="Darwin"
	MOCK_ARCH="arm64"
	MOCK_DIST=""
	HOME="__this_is_home_dir__"
	assert \
		"__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Darwin--arm64:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Darwin:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/common" \
		"source ../bin/link-list.sh"
)"


## __test_case__ Ubuntu x86_64

test_case "link-list.sh Ubuntu, x86_64" "$(
	MOCK_OS="Linux"
	MOCK_ARCH="x86_64"
	MOCK_DIST="Ubuntu"
	HOME="__this_is_home_dir__"

	assert \
		"__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu-x86_64:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux:__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/common" \
		"source ../bin/link-list.sh"
)"
