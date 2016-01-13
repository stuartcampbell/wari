#!/bin/sh

add_repo() {
  REPO=${1}
  if [ -f $WARI_ROOT/repos/$REPO ]; then
    source $REPO
  else
    echo "Could not find information about $REPO"
    exit 1
  fi
}

