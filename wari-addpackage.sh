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


