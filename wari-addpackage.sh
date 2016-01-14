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
      sudo apt-get -y install ${@}
      ;;
    arch)
      ;;
    *)
      ;;
  esac
}


