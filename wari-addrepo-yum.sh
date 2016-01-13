get_dnf () {
    DNF=`which yum`
    if [ $(command -v dnf) ]; then
        DNF=`which dnf`
    fi
    echo ${DNF}
}

add_repo() {
    URL=${1}
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
}

DNF=$(get_dnf)
# add the repositories that were requested
