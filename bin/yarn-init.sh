#!/bin/bash -e

if ! which yarn > /dev/null 3>&1 ; then
  echo "Need yarn. Prease install yarn and retry the script."
  exit 1
fi

yarn global add

