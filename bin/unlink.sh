#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source "$SCRIPT_DIR/unlink-function.sh"

main $*
