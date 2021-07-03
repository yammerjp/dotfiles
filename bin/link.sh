#!/bin/bash -e
# shellcheck disable=SC1090,SC2048,SC2086

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
source "$SCRIPT_DIR/link-function.sh"

main $*
