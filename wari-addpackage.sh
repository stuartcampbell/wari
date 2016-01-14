#!/bin/sh

add_package() {
  case "$WARI_DISTRO" in
    fedora)
      add_yum_package ${@}
      ;;
    rhel)
      echo "add_yum_package ${@}"
      add_yum_package ${@}
      ;;
    centos)
      add_yum_package ${@}
      ;;
    opensuse)
      ;;
    ubuntu)
      sudo apt-get -y install ${@}
      ;;
    arch)
      ;;
    *)
      ;;
  esac
}


