#!/bin/sh

add_repo() {
  for REPO in ${@}
  do
    if [ -f $WARI_ROOT/repos/$REPO ]; then
      source $WARI_ROOT/repos/$REPO
    else
      echo "Could not find information about $REPO"
      exit 1
    fi
  done
}
