# Standard place to look for installed .repo files.
REPO_DIR="/etc/yum.repos.d/"

get_dnf () {
    DNF=`which yum`
    if [ $(command -v dnf) ]; then
        DNF=`which dnf`
    fi
    echo ${DNF}
}

add_yum_repo_rpm() {
    echo "sudo ${DNF} install $@"
    sudo ${DNF} install $@
}

add_yum_repo_url() {
    URL=${1}

    # Extract the filename
    REPOFILENAME=${URL##/*/}

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
      echo "sudo ${CMD} --add-repo=${URL}"
      sudo ${CMD} --add-repo=${URL}
    else
      # .repo file is already installed - do nothing
      echo "Repofile $REPOFILENAME already exists"
    fi
}

