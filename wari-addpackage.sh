#!/bin/sh

add_package() {
  case "$WARI_DISTRO" in
    fedora)
      add_yum_package ${@}
      ;;
    rhel)
      add_yum_package ${@}
      ;;
    centos)
      add_yum_package ${@}
      ;;
    opensuse)
      sudo zypper install ${@}
      ;;
    ubuntu)
      # TODO: if the arg is a URL then we need to grab it and use dpkg locally
      sudo apt-get update
      sudo apt-get -y install ${@}
      ;;
    arch)
      ;;
    *)
      ;;
  esac
}

add_packages_from_file() {
  FILENAME=${1}
  #echo "add_packages_from_file(): Checking for file : ${FILENAME}"
  if [ -f $FILENAME ]; then
    add_package $(cat $FILENAME)
  else
    echo "The expected list of packages files ($FILENAME) does not exist"
    exit 1
  fi
}

add_packages_from_distro_file() {
  FILENAME="wari-pacakgelist-$WARI_DISTRO.txt"
  if [ -f $FILENAME ]; then
    add_packages_from_file $FILENAME
  #else
  #  echo "Did not find list of packages '$FILENAME'"
  fi
}
