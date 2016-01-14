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
  case "$WARI_DISTRO" in
    fedora)
      add_packages_from_file fedora-packagelist.txt
      ;;
    rhel)
      add_packages_from_file redhat-packagelist.txt
      ;;
    centos)
      add_packages_from_file "redhat-packagelist.txt"
      ;;
    opensuse)
      add_packages_from_file "opensuse-packagelist.txt"
      ;;
    ubuntu)
      add_packages_from_file "ubuntu-packagelist.txt"
      ;;
    arch)
      ;;
    *)
      ;;
  esac
}

