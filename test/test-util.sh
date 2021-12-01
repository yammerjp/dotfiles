#!/bin/bash -e
# shellcheck disable=SC2046,SC1091

function test_message() {
	printf "%s\n" "$@" # 1>&2
}
function test_message_green() {
	printf "\033[32m%s\033[39m\n" "$@" # 1>&2
}
function test_message_red() {
	printf "\033[31m%s\033[39m\n" "$@" # 1>&2
}

function assert() {
	ASSERT_EXPECTED="$1"
	ASSERT_EXEC_COMMAND="$2"

	if diff <(echo "$ASSERT_INPUT" | $ASSERT_EXEC_COMMAND) <(echo "$ASSERT_EXPECTED"); then
		test_message_green "	success		assert()"
	else
		test_message_red   "	FAILED..		assert()"
		exit 1
	fi
}


function assert_nothing() {
	ASSERT_EXEC_COMMAND="$1"

	if diff <(echo "$ASSERT_INPUT" | $ASSERT_EXEC_COMMAND) <( echo -n ''); then
		test_message_green "	success		assert_nothing()"
	else
		test_message_red "	FAILED...		assert_nothing()"
		exit 1
	fi
}

function assertFailed() {
		test_message_red "	FAILED...		assertFailed()"
	exit 1
}

function test_case() {
	TEST_CASE_RESULT="$?"

	TEST_CASE_NAME="$1"
	TEST_CASE_RESULT_MESSAGE="$2"

	echo "test: $TEST_CASE_NAME" 1>&2
	echo "$TEST_CASE_RESULT_MESSAGE" 1>&2
	if ! [ "$TEST_CASE_RESULT" = "0" ]; then
    test_message_red "	FAILED... exit code of test case is not zero" 1>&2
	fi
}

# test_case "test case 1" "$(false)"
