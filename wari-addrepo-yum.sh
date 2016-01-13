get_dnf () {
    DNF=`which yum`
    if [ $(command -v dnf) ]; then
        DNF=`which dnf`
    fi
    echo ${DNF}
}

add_repo_rpm() {
    echo "sudo ${DNF} install $@"
    sudo ${DNF} install $@
}

add_repo_conf() {
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
REPO_DIR="/etc/yum.repos.d/"
REPOS=$@

# add the repositories that were requested
echo "Setting up repositories: $REPOS"
for ITEM in $REPOS
do
    if [ ! -f "$REPO_DIR/$ITEM.repod" ]; then
        case "$ITEM" in
            google-chrome)
                echo "Get the google-chrome rpm from https://www.google.com/chrome/browser/desktop/index.html"
                exit 1
                ;;

	    epel)
                add_repo_rpm epel-release
	        ;;

            rpmfusion-free)
                add_repo_rpm --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
                ;;

            rpmfusion-nonfree)
                add_repo_rpm --nogpgcheck http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                ;;

            fedora-nvidia)
                if [ ! $(rpm -E %fedora) == "%fedora" ]; then
                    add_repo_rpm --nogpgcheck  http://negativo17.org/repos/fedora-nvidia.repo
                elif [ ! $(rpm -E %rhel) == "%rhel" ]; then
                    add_repo_rpm --nogpgcheck http://negativo17.org/repos/epel-nvidia.repo
                else
                    echo "Do not have url for fedora-nvidia"
                    exit 1
                fi
                ;;
            *)
                echo "Do not no how to install '$ITEM.repo'"
                exit
        esac
    fi
done
