#!/bin/bash -e

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
source "$SCRIPT_DIR/link-function.sh"

main $*
