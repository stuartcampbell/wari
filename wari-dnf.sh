# Standard place to look for installed .repo files.
REPO_DIR="/etc/yum.repos.d/"

get_dnf () {
    DNF=`which yum`
    if [ $(command -v dnf) ]; then
        DNF=`which dnf`
    fi
    #echo ${DNF}
}

add_copr_repo() {
  if [ -z "${DNF}" ]; then
    get_dnf
  fi
  sudo ${DNF} -y copr enable $@
}

add_yum_repo_rpm() {
    URL=${1}

    # Extract the filename
    RPM_PACKAGE_FULLNAME=${URL##*/}
    RPM_PACKAGE_NAME="${RPM_PACKAGE_FULLNAME%.*}"

    if ! rpm -q --quiet $RPM_PACKAGE_NAME; then
      echo "sudo ${DNF} -y install $@"
      sudo ${DNF} -y install $@
    else
      # the RPM is already installed.
      # echo "$RPM_PACKAGE_NAME is already installed"
      return 0
    fi
}

add_yum_repo_url() {
    URL=${1}

    # Extract the filename
    REPOFILENAME=${URL##*/}

    # Determine if we are using dnf or yum
    DNF=$(get_dnf)

    # Check if the .repo file is already installed
    if [ ! -f "$REPO_DIR/$REPOFILENAME" ]; then
      if [[ $DNF == *dnf ]]; then
        CMD="${DNF} config-manager"
      elif [[ $DNF == *yum ]]; then
        CMD="yum-config-manager"
      else
        echo "Something went wrong"
        exit 1
      fi
      #echo "sudo ${CMD} --add-repo=${URL}"
      sudo ${CMD} --add-repo=${URL}
    else
      # .repo file is already installed - do nothing
      #echo "Repofile $REPOFILENAME already exists"
      return 0
    fi
}

add_yum_package() {
  if [ ! $(rpm -q --quiet ${1}) ]; then
      return 0
  fi
  if [ -z "${DNF}" ]; then
    get_dnf
  fi
  #echo "sudo ${DNF} install -y ${1}"
  sudo ${DNF} install -y ${1}
}
