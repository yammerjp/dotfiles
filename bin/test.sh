#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

# ------------------ test link-list.sh -------------------


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

## __test_case__ macOS, Apple Silicon

MOCK_OS="Darwin"
MOCK_ARCH="arm64"
MOCK_DIST=""

HOME="__this_is_home_dir__"

if ! diff <( cat <<< $(source ./link-list.sh)) <( cat  << EOF
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Darwin--arm64
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Darwin--
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/common
EOF
); then
  echo "Test failed." 1>&2
  exit 1
fi


## __test_case__ Ubuntu x86_64

MOCK_OS="Linux"
MOCK_ARCH="x86_64"
MOCK_DIST="Ubuntu"

if ! diff <( cat <<< $(source ./link-list.sh)) <( cat  << EOF
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu-x86_64
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux-Ubuntu-
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/Linux--
__this_is_home_dir__/src/github.com/yammerjp/dotfiles/env/common
EOF
); then
  echo "Test failed." 1>&2
  exit 1
fi





echo "Test succeeded." 1>&2

