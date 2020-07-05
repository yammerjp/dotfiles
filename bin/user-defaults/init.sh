#!/bin/bash -e

echo  "Set User Default with 'defaults' command"

SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

bash "$SCRIPT_DIR/os.sh"
