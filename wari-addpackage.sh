#!/bin/sh

add_package() {
  case "$WARI_DISTRO" in
    fedora)
      add_yum_package ${1}
      ;;
    rhel)
      add_yum_package ${1}
      ;;
    centos)
      add_yum_package ${1}
      ;;
    opensuse)
      ;;
    ubuntu)
      ;;
    arch)
      ;;
    *)
      ;;
  esac
}
