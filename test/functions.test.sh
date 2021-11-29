#!/bin/bash -e
# shellcheck disable=SC2046,SC1091

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
cd "$SCRIPT_DIR"

source test-util.sh

source "../bin/functions.sh"




test_case "devide_with_colon" "$(
	assert \
		"$(cat <<- EOS
			hoge
			fuga
			wara
		EOS
		)" \
		"devide_with_colon hoge:fuga:wara"
)"


test_case "find_dotfiles" "$(
	rm -rf "/tmp/dotfiles_test_functions/find_dotfiles"
	mkdir -p "/tmp/dotfiles_test_functions/find_dotfiles/.config/nvim"
	touch "/tmp/dotfiles_test_functions/find_dotfiles/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/find_dotfiles/.bashrc"
	touch "/tmp/dotfiles_test_functions/find_dotfiles/.gitconfig"

	assert \
		"$(cat <<- EOS
			.bashrc
			.config/nvim/init.nvim
			.gitconfig
		EOS
		)" \
    "find_dotfiles /tmp/dotfiles_test_functions/find_dotfiles"
)"


test_case "link_from_to, ubuntu" "$(
	HOME="__HOME_DIR__"
	assert \
		"$(cat <<- EOS
			__DOTFILES_DIRECTORY__/.config/nvim/init.nvim __HOME_DIR__/.config/nvim/init.nvim
		EOS
		)" \
		"$(cat <<- EOS
			link_from_to __DOTFILES_DIRECTORY__ .config/nvim/init.nvim
		EOS
		)"
)"


test_case "extract_should_link" "$(
	ASSERT_INPUT="$(cat <<- EOS
		__HIGH_PRIORITY_DOTFILES_DIRECTORY__/.bashrc __HOME_DIR__/.bashrc
		__HIGH_PRIORITY_DOTFILES_DIRECTORY__/.config/nvim/init.nvim __HOME_DIR__/.config/nvim/init.nvim
		__LOW_PRIORITY_DOTFILES_DIRECTORY__/.bashrc __HOME_DIR__/.bashrc
		__LOW_PRIORITY_DOTFILES_DIRECTORY__/.config/nvim/init.nvim __HOME_DIR__/.config/nvim/init.nvim
		__LOW_PRIORITY_DOTFILES_DIRECTORY__/.gitconfig __HOME_DIR__/.gitconfig
		EOS
	)"
	assert \
		"$( cat <<- EOS
			__HIGH_PRIORITY_DOTFILES_DIRECTORY__/.bashrc __HOME_DIR__/.bashrc
			__HIGH_PRIORITY_DOTFILES_DIRECTORY__/.config/nvim/init.nvim __HOME_DIR__/.config/nvim/init.nvim
			__LOW_PRIORITY_DOTFILES_DIRECTORY__/.gitconfig __HOME_DIR__/.gitconfig
			EOS
		)" \
    extract_should_link
)"

# TEST_CASE: create_dir
test_case "create_dir" "$(
	function message() {
		echo "$@" 2>&1
	}

	rm -rf "/tmp/dotfiles_test_functions/create_dir"

	assert \
		"mkdir -p /tmp/dotfiles_test_functions/create_dir" \
		"create_dir /tmp/dotfiles_test_functions/create_dir/.bashrc"

	if ! [ -d "/tmp/dotfiles_test_functions/create_dir" ]; then
		echo "test failed"
	fi
)"

# TEST_CASE: create_dir
test_case "create_dir (directory already exists)" "$(
	function message() {
		echo "$@" 2>&1
	}

	rm -rf "/tmp/dotfiles_test_functions/create_dir"
	mkdir -p "/tmp/dotfiles_test_functions/create_dir"

	assert_nothing \
		"create_dir /tmp/dotfiles_test_functions/create_dir/.bashrc"

	if ! [ -d "/tmp/dotfiles_test_functions/create_dir" ]; then
		assertFailed
	fi
)"

test_case "evacuate_file (.org0)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/evacuate_file"
	function message() {
		echo "$@" 2>&1
	}

	assert \
		"mv -f /tmp/dotfiles_test_functions/evacuate_file /tmp/dotfiles_test_functions/evacuate_file.org0" \
		"evacuate_file /tmp/dotfiles_test_functions/evacuate_file"
)"


test_case "evacuate_file (.org1)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/evacuate_file"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org0"
	function message() {
		echo "$@" 2>&1
	}

	assert \
		"mv -f /tmp/dotfiles_test_functions/evacuate_file /tmp/dotfiles_test_functions/evacuate_file.org1" \
		"evacuate_file /tmp/dotfiles_test_functions/evacuate_file"
)"


test_case "evacuate_file (.org10)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/evacuate_file"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org0"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org1"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org2"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org3"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org4"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org5"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org6"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org7"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org8"
	touch "/tmp/dotfiles_test_functions/evacuate_file.org9"
	function message() {
		echo "$@" 2>&1
	}

	assert \
		"mv -f /tmp/dotfiles_test_functions/evacuate_file /tmp/dotfiles_test_functions/evacuate_file.org10" \
		"evacuate_file /tmp/dotfiles_test_functions/evacuate_file"
)"



test_case "resolve_if_conflict (no confliction)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	function message() {
		echo "$@" 2>&1
	}

	assert_nothing \
		"resolve_if_conflict /tmp/THIS_IS_NOT_EXIST_FILE-functions.test.sh invalid-on-confliction"
)"



test_case "resolve_if_conflict (evacuate)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/resolve_if_conflict"
	function message() {
		echo "$@" 2>&1
	}
	function evacuate_file() {
		echo "evacuate_file is called with $1"
	}

	assert \
		"evacuate_file is called with /tmp/dotfiles_test_functions/resolve_if_conflict" \
		"resolve_if_conflict /tmp/dotfiles_test_functions/resolve_if_conflict evacuate || echo 'exit code must be 0'"
)"


test_case "resolve_if_conflict (evacuate, but link must be delete)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/resolve_if_conflict"
	ln -s "/tmp/dotfiles_test_functions/resolve_if_conflict" "/tmp/dotfiles_test_functions/resolve_if_conflict-symlink"

	function message() {
		echo "$@" 2>&1
	}
	function evacuate_file() {
		echo "evacuate_file is called with $1"
	}

	assert \
		"delete link from /tmp/dotfiles_test_functions/resolve_if_conflict to /tmp/dotfiles_test_functions/resolve_if_conflict-symlink" \
		"resolve_if_conflict /tmp/dotfiles_test_functions/resolve_if_conflict-symlink evacuate || echo 'exit code must be 0'"
	
	if [ -e /tmp/dotfiles_test_functions/resolve_if_conflict-symlink ]; then
		assertFailed
	fi
)"

test_case "resolve_if_conflict (overwrite)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/resolve_if_conflict"

	function message() {
		echo "$@" 2>&1
	}

	assert \
		"overwrite /tmp/dotfiles_test_functions/resolve_if_conflict" \
		"resolve_if_conflict /tmp/dotfiles_test_functions/resolve_if_conflict overwrite || echo 'exit code must be 0'"

	if [ -e /tmp/dotfiles_test_functions/resolve_if_conflict ]; then
		assertFailed
	fi
)"


test_case "resolve_if_conflict (skip)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/resolve_if_conflict"

	function message() {
		echo "$@" 2>&1
	}

	assert \
		"file already exists. skip. /tmp/dotfiles_test_functions/resolve_if_conflict" \
		"resolve_if_conflict /tmp/dotfiles_test_functions/resolve_if_conflict skip || echo 'exit code must be 0'"

	if ! [ -e /tmp/dotfiles_test_functions/resolve_if_conflict ]; then
		assertFailed
	fi
)"


test_case "resolve_if_conflict (error)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions"
	touch "/tmp/dotfiles_test_functions/resolve_if_conflict"

	function message() {
		echo "$@" 2>&1
	}

	assert \
		"ERROR: ON_CONFLICTION is not specified" \
		"resolve_if_conflict /tmp/dotfiles_test_functions/resolve_if_conflict error && echo 'exit code must be 1'"

	if ! [ -e /tmp/dotfiles_test_functions/resolve_if_conflict ]; then
		assertFailed
	fi
)"


test_case "dotfiles_list" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions/dotfiles_list/high_priority_dotdir/.config/nvim"
	mkdir -p "/tmp/dotfiles_test_functions/dotfiles_list/low_priority_dotdir/.config/nvim"
	touch "/tmp/dotfiles_test_functions/dotfiles_list/high_priority_dotdir/.bashrc"
	touch "/tmp/dotfiles_test_functions/dotfiles_list/high_priority_dotdir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/dotfiles_list/low_priority_dotdir/.bashrc"
	touch "/tmp/dotfiles_test_functions/dotfiles_list/low_priority_dotdir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/dotfiles_list/low_priority_dotdir/.gitconfig"
	HOME="__HOME_DIR__"

	assert \
		"$(cat <<- EOF
			/tmp/dotfiles_test_functions/dotfiles_list/high_priority_dotdir/.bashrc __HOME_DIR__/.bashrc
			/tmp/dotfiles_test_functions/dotfiles_list/high_priority_dotdir/.config/nvim/init.nvim __HOME_DIR__/.config/nvim/init.nvim
			/tmp/dotfiles_test_functions/dotfiles_list/low_priority_dotdir/.gitconfig __HOME_DIR__/.gitconfig
		EOF
		)" \
		"dotfiles_list /tmp/dotfiles_test_functions/dotfiles_list/high_priority_dotdir:/tmp/dotfiles_test_functions/dotfiles_list/low_priority_dotdir"
)"


test_case "create_link (already linked)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim"
	mkdir -p "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim"
	touch "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim"
	ln -s "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim" "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim"

	function message() {
		echo "$@" 2>&1
	}

	assert \
		"symlink already exists. /tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim -> /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim" \
		"create_link /tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim invalid-on-confliction"
)"

test_case "create_link (skip)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim"
	mkdir -p "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim"
	touch "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim"

		function message() {
		echo "$@" 2>&1
	}

	assert \
		"file already exists. skip. /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim" \
		"create_link /tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim skip && echo 'exit code must be 1'"
)"


test_case "create_link (linking)" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim"
	mkdir -p "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim"
	touch "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim.org0"

	function message() {
		echo "$@" 2>&1
	}

	assert \
		"$( cat <<- EOF
			mv -f /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim.org1
			ln -s /tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim
		EOF
		)" \
		"create_link /tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim evacuate"

	if [ "$(readlink /tmp/dotfiles_test_functions/create_link/home_dir/.config/nvim/init.nvim)" != "/tmp/dotfiles_test_functions/create_link/dot_dir/.config/nvim/init.nvim" ]; then
		assertFailed
	fi
)"


test_case "create_links" "$(
	rm -rf "/tmp/dotfiles_test_functions"
	mkdir -p "/tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.config/nvim"
	mkdir -p "/tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir/.config/nvim"
	touch "/tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.bashrc"
	touch "/tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir/.bashrc"
	touch "/tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir/.config/nvim/init.nvim"
	touch "/tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir/.gitconfig"

	HOME="/tmp/dotfiles_test_functions/create_links/home_dir"
	mkdir -p "/tmp/dotfiles_test_functions/create_links/home_dir"
	touch "/tmp/dotfiles_test_functions/create_links/home_dir/.bashrc"
	touch "/tmp/dotfiles_test_functions/create_links/home_dir/.bashrc.org0"

	function message() {
		echo "$@" 2>&1
	}

	assert \
		"$(cat <<- EOF
			mv -f /tmp/dotfiles_test_functions/create_links/home_dir/.bashrc /tmp/dotfiles_test_functions/create_links/home_dir/.bashrc.org1
			ln -s /tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.bashrc /tmp/dotfiles_test_functions/create_links/home_dir/.bashrc
			mkdir -p /tmp/dotfiles_test_functions/create_links/home_dir/.config/nvim
			ln -s /tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.config/nvim/init.nvim /tmp/dotfiles_test_functions/create_links/home_dir/.config/nvim/init.nvim
			ln -s /tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir/.gitconfig /tmp/dotfiles_test_functions/create_links/home_dir/.gitconfig
		EOF
		)" \
		"create_links /tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir:/tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir evacuate"

		if [ -e  /tmp/dotfiles_test_functions/create_links/home_dir/.bashrc.org1 ] && \
			[ "$(readlink /tmp/dotfiles_test_functions/create_links/home_dir/.bashrc)" =  "/tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.bashrc" ] && \
			[ "$(readlink /tmp/dotfiles_test_functions/create_links/home_dir/.config/nvim/init.nvim)" =  "/tmp/dotfiles_test_functions/create_links/dotdirs/high_priority_dotdir/.config/nvim/init.nvim" ] && \
			[ "$(readlink /tmp/dotfiles_test_functions/create_links/home_dir/.gitconfig)" =  "/tmp/dotfiles_test_functions/create_links/dotdirs/low_priority_dotdir/.gitconfig" ]
		then
			:
		else
			assertFailed
		fi
)"
