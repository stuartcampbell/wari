#!/bin/sh

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

url_exists () {
  URL=${1}

  if [ $(command -v curl) ]; then
    return $(! curl --output /dev/null --silent --head --fail "$URL")
  elif [ $(command -v wget) ]; then
    return $(! wget --spider "$URL" 2> /dev/null)
  else
    # can't be checked so just say yes
    return 0
  fi
}

WARI_ROOT=$(get_script_dir)

echo "Running wari from $WARI_ROOT"

# Now let's determine what distro we are running on.
if [ -f "/etc/os-release" ]; then
  . /etc/os-release
  WARI_DISTRO=$ID
  WARI_DISTRO_VERSION=$VERSION_ID
else
  echo "/etc/os-release not available - your distro is too old! Upgrade! :-)"
  exit -1
fi

if [[ "$(uname -m)" = "x86_64" ]]; then
	WARI_ARCH="64"
else
	WARI_ARCH="32"
fi

# Let's source all our helper libraries
. $WARI_ROOT/wari-addrepo.sh
. $WARI_ROOT/wari-dnf.sh
. $WARI_ROOT/wari-addpackage.sh
