#!/usr/bin/env bash

# we need sudo permissions

sudo echo "installing all the things"

# is yum available?
if [[ ! -x "$(command -v yum)" ]]; then
    echo "ERROR: yum not found, wrong os?" >> /dev/stderr
    exit 1
fi

# add EPEL for RHEL 7
if [[ $(uname -r) = *el7* ]]; then
    sudo echo "adding EPEL 7 repo"
    if [[ $(rpm -qa) != *epel-release* ]]; then
        sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum update
    else
        echo 'already added'
    fi
fi

# add extended repo for more packages
if [[ $(uname -r) = *el8* ]]; then
    sudo echo "adding EPEL 8 repo"
    if [[ $(rpm -qa) != *epel-release* ]]; then
        sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
        ARCH=$( /bin/arch )
        sudo subscription-manager repos --enable "codeready-builder-for-rhel-8-${ARCH}-rpms"
        unset ARCH
    #    sudo dnf config-manager --set-enabled PowerTools
        sudo yum update
    else
        echo 'already added'
    fi
fi

# fix timezone

[[ -e /usr/share/zoneinfo/Asia/Singapore ]] && sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# file compression

echo "Installing bzip2"
[[ ! -x "$(command -v bzip2)" ]] && sudo yum install -y bzip2

#echo "Installing cabextract"
#[[ ! -x "$(command -v cabextract)" ]] && sudo yum install -y cabextract

echo "Installing gzip"
[[ ! -x "$(command -v gzip)" ]] && sudo yum install -y gzip

echo "Installing lzip"
[[ ! -x "$(command -v lzip)" ]] && sudo yum install -y lzip

echo "Installing p7zip"
[[ ! -x "$(command -v 7z)" ]] && sudo yum install -y p7zip p7zip-plugins p7zip-doc

#echo "Installing unar, lsar"
#[[ ! -x "$(command -v unar)" ]] && sudo yum install -y unar

#echo "Installing unrar"
#[[ ! -x "$(command -v unrar)" ]] && sudo yum install -y unrar

#echo "Installing unp"
#[[ ! -x "$(command -v unp)" ]] && sudo yum install -y unp

echo "Installing zip"
[[ ! -x "$(command -v zip)" ]] && sudo yum install -y zip

echo "Installing unzip"
[[ ! -x "$(command -v unzip)" ]] && sudo yum install -y unzip

#echo "Installing xdms"
#[[ ! -x "$(command -v xdms)" ]] && sudo yum install -y xdms

#echo "Installing xz-utils"
#[[ ! -x "$(command -v xz)" ]] && sudo yum install -y xz-utils

echo "Installing zstd"
[[ ! -x "$(command -v zstd)" ]] && sudo yum install -y zstd

# pre-reqs

echo "Installing curl"
sudo yum install -y curl

echo "Installing git & git-lfs"
sudo yum install -y git git-lfs

echo "Installing jq"
sudo yum install -y jq

#echo "Installing snap"
#sudo yum install -y snapd
#sudo systemctl enable --now snapd

echo "Installing wget"
sudo yum install -y wget

# vendored installs

[[ -d /usr/local/share/fonts ]] || sudo mkdir --parents /usr/local/share/fonts
[[ -d ~/.local/bin/ ]] || mkdir --parents ~/.local/bin/
[[ -d ~/.local/share/man/man1/ ]] || mkdir --parents ~/.local/share/man/man1/

echo "Installing Iosevka"
sudo cp ~/dotfiles/vendored/iosevka-*/iosevka-*.ttf /usr/local/share/fonts

echo "Installing '$' ignorer"
if [[ ! -x "$(command -v '$')" ]]; then
    cp ~/dotfiles/vendored/dollar_sign ~/.local/bin/'$'
    sudo chmod +x ~/.local/bin/'$'
fi

if [[ ! -x "$(command -v bak)" ]]; then
    echo "Installing backup.sh"
    cp ~/dotfiles/vendored/backup.sh ~/.local/bin/bak
    sudo chmod +x ~/.local/bin/bak
fi

if [[ ! -x "$(command -v bat)" ]]; then
    echo "Installing bat"
    cp ~/dotfiles/vendored/bat-*-x86_64-unknown-linux-musl/bat ~/.local/bin/bat
    cp ~/dotfiles/vendored/bat-*-x86_64-unknown-linux-musl/bat.1 ~/.local/share/man/man1/bat.1
    sudo chmod +x ~/.local/bin/bat
fi

if [[ ! -x "$(command -v batdiff)" ]]; then
    echo "Installing bat-extras"
    cp ~/dotfiles/vendored/bat-extras-*/bin/bat-modules ~/.local/bin/bat-modules
    cp ~/dotfiles/vendored/bat-extras-*/bin/batdiff ~/.local/bin/batdiff
    cp ~/dotfiles/vendored/bat-extras-*/bin/batgrep ~/.local/bin/batgrep
    cp ~/dotfiles/vendored/bat-extras-*/bin/batman ~/.local/bin/batman
    cp ~/dotfiles/vendored/bat-extras-*/bin/batpipe ~/.local/bin/batpipe
    cp ~/dotfiles/vendored/bat-extras-*/bin/batwatch ~/.local/bin/batwatch
    cp ~/dotfiles/vendored/bat-extras-*/bin/prettybat ~/.local/bin/prettybat
    cp ~/dotfiles/vendored/bat-extras-*/man/batdiff.1 ~/.local/share/man/man1/batdiff.1
    cp ~/dotfiles/vendored/bat-extras-*/man/batgrep.1 ~/.local/share/man/man1/batgrep.1
    cp ~/dotfiles/vendored/bat-extras-*/man/batman.1 ~/.local/share/man/man1/batman.1
    cp ~/dotfiles/vendored/bat-extras-*/man/batpipe.1 ~/.local/share/man/man1/batpipe.1
    cp ~/dotfiles/vendored/bat-extras-*/man/batwatch.1 ~/.local/share/man/man1/batwatch.1
    cp ~/dotfiles/vendored/bat-extras-*/man/prettybat.1 ~/.local/share/man/man1/prettybat.1
    sudo chmod +x ~/.local/bin/bat-modules
    sudo chmod +x ~/.local/bin/batdiff
    sudo chmod +x ~/.local/bin/batgrep
    sudo chmod +x ~/.local/bin/batman
    sudo chmod +x ~/.local/bin/batpipe
    sudo chmod +x ~/.local/bin/batwatch
    sudo chmod +x ~/.local/bin/prettybat
fi

if [[ ! -x "$(command -v delta)" ]]; then
    echo "Installing delta"
    cp ~/dotfiles/vendored/delta-*-x86_64-unknown-linux-musl/delta ~/.local/bin/delta
    sudo chmod +x ~/.local/bin/delta
fi

if [[ ! -x "$(command -v duf)" ]]; then
    echo "Installing duf"
    cp ~/dotfiles/vendored/duf_*_linux_x86_64/duf ~/.local/bin/duf
    sudo chmod +x ~/.local/bin/duf
fi

if [[ ! -x "$(command -v exa)" ]]; then
    if [[ $(uname -r) = *el7* ]]; then
        echo "Skipping exa on RHEL 7"
    else
        echo "Installing exa"
        cp ~/dotfiles/vendored/exa-linux-x86_64-*/bin/exa ~/.local/bin/exa
        sudo chmod +x ~/.local/bin/exa
        cp ~/dotfiles/vendored/exa-linux-x86_64-*/man/exa.1 ~/.local/share/man/man1/exa.1
    fi
fi

if [[ ! -x "$(command -v fd)" ]]; then
    echo "Installing fd"
    cp ~/dotfiles/vendored/fd-*-x86_64-unknown-linux-musl/fd ~/.local/bin/fd
    cp ~/dotfiles/vendored/fd-*-x86_64-unknown-linux-musl/fd.1 ~/.local/share/man/man1/fd.1
    sudo chmod +x ~/.local/bin/fd
fi

if [[ ! -d ~/.fzf ]]; then
    echo "Installing fzf"
    # git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    tar -xf ~/dotfiles/vendored/fzf-*.tar -C ~
    [[ -x "$(command -v git)" ]] && git -C ~/.fzf/ pull
    ~/.fzf/install --all
fi

if [[ ! -x "$(command -v hexyl)" ]]; then
    echo "Installing hexyl"
    cp ~/dotfiles/vendored/hexyl-*-x86_64-unknown-linux-musl/hexyl ~/.local/bin/hexyl
    sudo chmod +x ~/.local/bin/hexyl
fi

if [[ ! -x "$(command -v htop)" ]]; then
    echo "Installing htop"
    #sudo yum install -y htop
    if [[ $(uname -r) = *el7* ]]; then
        yum install -y ~/dotfiles/vendored/htop/htop-2.2.0-3.el7.x86_64.rpm
    else
        yum install -y ~/dotfiles/vendored/htop/htop-2.2.0-6.el8.x86_64.rpm
    fi
fi

if [[ ! -x "$(command -v hyperfine)" ]]; then
    echo "Installing hyperfine"
    cp ~/dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/hyperfine ~/.local/bin/hyperfine
    cp ~/dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/hyperfine.1 ~/.local/share/man/man1/hyperfine.1
    sudo chmod +x ~/.local/bin/hyperfine
fi

if [[ ! -f /etc/sysctl.d/jetbrains_watch_limit.conf ]]; then
    echo "Increase inotify watch limit for pycharm"
    sudo cp ~/dotfiles/vendored/jetbrains_watch_limit.conf /etc/sysctl.d/jetbrains_watch_limit.conf
    sudo sysctl -p --system
fi

if [[ ! -x "$(command -v micro)" ]]; then
    echo "Installing micro"
    cp ~/dotfiles/vendored/micro-*-linux64-static/micro ~/.local/bin/micro
    cp ~/dotfiles/vendored/micro-*-linux64-static/micro.1 ~/.local/share/man/man1/micro.1
    sudo chmod +x ~/.local/bin/micro
fi

#if [[ ! -x "$(command -v osqueryi)" ]]; then
#    echo "Installing osquery"
#    yum install -y ~/dotfiles/vendored/osquery/osquery-4.9.0-1.linux.x86_64.rpm
#fi

if [[ ! -x "$(command -v pipes.sh)" ]]; then
    echo "Installing pipes.sh"
    cp ~/dotfiles/vendored/pipes.sh-master-*/pipes.sh ~/.local/bin/pipes.sh
    cp ~/dotfiles/vendored/pipes.sh-master-*/pipes.sh.6 ~/.local/share/man/man1/pipes.sh.6
    sudo chmod +x ~/.local/bin/pipes.sh
fi

if [[ ! -f ~/.local/share/fonts/PowerlineSymbols.otf ]]; then
    echo "Installing powerline font"
    mkdir --parents ~/.local/share/fonts/
    cp ~/dotfiles/vendored/powerline-raw-develop-font-*/PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
fi

if [[ ! -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]]; then
    echo "Installing powerline fontconfig"
    mkdir --parents ~/.config/fontconfig/conf.d/
    cp ~/dotfiles/vendored/powerline-raw-develop-font-*/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
else
    echo "already installed"
fi

if [[ ! -x "$(command -v rg)" ]]; then
    echo "Installing ripgrep"
    cp ~/dotfiles/vendored/ripgrep-*-x86_64-unknown-linux-musl/rg ~/.local/bin/rg
    cp ~/dotfiles/vendored/ripgrep-*-x86_64-unknown-linux-musl/doc/rg.1 ~/.local/share/man/man1/rg.1
    sudo chmod +x ~/.local/bin/rg
fi

if [[ ! -x "$(command -v safe-rm)" ]]; then
    echo "Installing safe-rm"
    # cp ~/dotfiles/vendored/safe-rm-*/safe-rm ~/.local/bin/safe-rm
    # cp ~/dotfiles/vendored/safe-rm-*/safe-rm.conf ~/.config/safe-rm
    # sudo chmod +x ~/.local/bin/safe-rm
    sudo cp ~/dotfiles/vendored/safe-rm-*/safe-rm /usr/local/bin/safe-rm
    sudo cp ~/dotfiles/vendored/safe-rm-*/safe-rm.conf /usr/local/etc/safe-rm.conf
    sudo chmod +x /usr/local/bin/safe-rm
fi

if [[ ! -x "$(command -v tldr)" ]]; then
    echo "Installing tldr"
    cp ~/dotfiles/vendored/pepa65-tldr-bash-client-*/tldr ~/.local/bin/tldr
    cp ~/dotfiles/vendored/pepa65-tldr-bash-client-*/tldr-lint ~/.local/bin/tldr-lint
    sudo chmod +x ~/.local/bin/tldr
    sudo chmod +x ~/.local/bin/tldr-lint
    [[ ! -d ~/.local/share/tldr ]] && tar -xf ~/dotfiles/vendored/pepa65-tldr-bash-client-*/tldr.tar -C ~/.local/share/
fi

echo "Configuring xstartup"
[[ -d ~/.vnc ]] || mkdir ~/.vnc
[[ -f ~/.vnc/xstartup ]] && mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
if [[ -x "$(command -v gnome-session)" ]]; then
    cp ~/dotfiles/vendored/xstartup_gnome ~/.vnc/xstartup
elif [[ -x "$(command -v startxfce4)" ]]; then
    cp ~/dotfiles/vendored/xstartup_xfce ~/.vnc/xstartup
else
    echo "no GUI found, copying XFCE-based xstartup"
    cp ~/dotfiles/vendored/xstartup_xfce ~/.vnc/xstartup
    #echo "DO YOU WANT TO INSTALL XFCE?"
    #sudo yum group install xfce
fi
sudo chmod +x ~/.vnc/xstartup
sudo chmod +r ~/.vnc/xstartup

if [[ ! -x "$(command -v xsv)" ]]; then
    echo "Installing xsv"
    cp ~/dotfiles/vendored/xsv-*-x86_64-unknown-linux-musl ~/.local/bin/xsv
    sudo chmod +x ~/.local/bin/xsv
fi

# pip installs

echo "Installing pip3"
sudo yum install -y python3-pip

if [[ ! -x "$(command -v ad)" ]]; then
    echo "Installing ad"
    pip3 install --user advance-touch
fi

if [[ ! -x "$(command -v csvgrep)" ]]; then
    echo "Installing csvkit"
    pip3 install --user csvkit
fi

#if [[ ! -x "$(command -v glances)" ]]; then
#    echo "Installing glances (and bottle)"
#    pip3 install --user bottle
#    pip3 install --user glances
#fi

if [[ ! -x "$(command -v html2text)" ]]; then
    echo "Installing html2text"
    pip3 install --user html2text
fi

if [[ ! -x "$(command -v langid)" ]]; then
    echo "Installing langid"
    pip3 install --user langid
fi

if [[ ! -x "$(command -v powerline-daemon)" ]]; then
    echo "Installing powerline"
    pip3 install --user powerline-status
fi

if [[ ! -x "$(command -v pydf)" ]]; then
    echo "Installing pydf"
    pip3 install --user pydf
fi

if [[ ! -x "$(command -v pygmentize)" ]]; then
    echo "Installing pygmentize"
    pip3 install --user pygments
fi

if [[ ! -x "$(command -v tabulate)" ]]; then
    echo "Installing tabulate"
    pip3 install --user tabulate
fi

if [[ ! -x "$(command -v trash)" ]]; then
    echo "Installing trash-cli"
    pip3 install --user trash-cli
fi

if [[ ! -x "$(command -v unidecode)" ]]; then
    echo "Installing unidecode"
    pip3 install --user unidecode
fi

if [[ ! -x "$(command -v vd)" ]]; then
    echo "Installing visidata"
    pip3 install --user visidata
fi

if [[ ! -x "$(command -v wormhole)" ]]; then
    echo "Installing wormhole"
    pip3 install --user magic-wormhole
fi

if [[ ! -x "$(command -v zxcvbn)" ]]; then
    echo "Installing zxcvbn"
    pip3 install --user zxcvbn
fi


# download and install

#echo "Installing browsh"
#if [[ ! -x "$(command -v browsh)" ]]; then
#    if ls browsh_*_linux_amd64.rpm 1> /dev/null 2>&1; then
#        echo "found installer"
#    else
#        curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
#         | jq -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.rpm")) | .browser_download_url' \
#         | wget -i -
#    fi
#    sudo yum install -y browsh_*_linux_amd64.rpm
#    rm browsh_*_linux_amd64.rpm
#else
#    echo "already installed"
#fi

#echo "Installing chrome"
#if [[ ! -x "$(command -v google-chrome)" ]]; then
#    if ls google-chrome-stable_current_x86_64.rpm 1> /dev/null 2>&1; then
#        echo "found installer"
#    else
#        wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
#    fi
#    sudo yum install -y google-chrome-stable_current_x86_64.rpm
#    rm google-chrome-stable_current_x86_64.rpm
#else
#    echo "already installed"
#fi

#echo "Installing tigervnc server"
#if [[ ! -x "$(command -v x0vncserver)" ]]; then
#    RELEASE="tigervnc-1.11.0.x86_64"
#    if [[ ! -f ${RELEASE}.tar.gz ]]; then
#        wget -O ${RELEASE}.tar.gz https://bintray.com/tigervnc/stable/download_file?file_path=${RELEASE}.tar.gz
#    fi
#    tar -xf ${RELEASE}.tar.gz
#    rm ${RELEASE}.tar.gz
#    sudo cp -R ${RELEASE}/usr/ /
#    rm -rf ${RELEASE}/
#else
#    echo "already installed"
#fi
#if [[ ! -x "$(command -v vncserver)" ]]; then
#    sudo cp ~/dotfiles/vendored/vncserver /usr/bin/
#    sudo chmod +x /usr/bin/vncserver
#fi
#sudo firewall-cmd --add-port=5900-5999/tcp
#sudo firewall-cmd --add-port=5900-5999/tcp --permanent
#sudo firewall-cmd --reload

# yum installs

echo "Installing aria2"
sudo yum install -y aria2

echo "Installing atop"
sudo yum install -y atop

#echo "Installing asciinema"
#sudo yum install -y asciinema

#echo "Installing autojump"
#sudo yum install -y autojump

#echo "Installing byobu"
#sudo yum install -y byobu

#echo "Installing catimg"
#sudo yum install -y catimg

echo "Installing cifs"
sudo yum install -y cifs-utils

echo "Installing cockpit"
sudo yum install -y cockpit cockpit-pcp
sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --add-service=cockpit
sudo firewall-cmd --add-service=cockpit --permanent
sudo firewall-cmd --reload
[[ -e /etc/motd.d/cockpit ]] && sudo rm /etc/motd.d/cockpit

echo "Installing coreutils (e.g. realpath)"
sudo yum install -y coreutils

echo "Installing dos2unix"
sudo yum install -y dos2unix

#echo "Installing exfat-fuse"
#sudo yum install -y exfat-fuse

#echo "Installing ffmpeg"
#sudo yum install -y ffmpeg ffmpeg-doc

#echo "Installing firefox"
#sudo yum install -y firefox

#echo "Installing Noto font"
#sudo yum install -y google-noto-*

#echo "Installing gparted"
#sudo yum install -y gparted

#echo "Installing httpie"
#sudo yum install -y httpie

echo "Installing ifconfig"
sudo yum install -y net-tools

echo "Installing iftop"
sudo yum install -y iftop

echo "Installing imagemagick"
sudo yum install -y ImageMagick

echo "Installing iotop"
sudo yum install -y iotop

echo "Installing less"
sudo yum install -y less

echo "Installing locate, updatedb (and findutils)"
sudo yum install -y findutils
sudo yum install -y mlocate

#echo "Installing lnav"
#sudo yum install -y lnav

echo "Installing lsof"
sudo yum install -y lsof

echo "Installing mosh"
sudo yum install -y mosh
sudo firewall-cmd --add-service=mosh
sudo firewall-cmd --add-service=mosh --permanent
sudo firewall-cmd --reload

echo "Installing mtr"
sudo yum install -y mtr

echo "Installing nano"
sudo yum install -y nano

echo "Installing ncdu"
sudo yum install -y ncdu

#echo "Installing nmtui"
#sudo yum install -y network-manager

echo "Installing nslookup, dig"
sudo yum install -y bind-utils

echo "Installing ntfs-3g"
sudo yum install -y ntfs-3g ntfsprogs

echo "Installing pandoc"
sudo yum install -y pandoc

echo "Installing parallel"
sudo yum install -y parallel

#echo "Installing pexec"
#sudo yum install -y pexec

#echo "Installing pglob, pkill"
#sudo yum install -y procps

#echo "Installing prettyping"
#sudo yum install -y prettyping

echo "Installing psmisc"
sudo yum install -y psmisc

echo "Installing pv"
sudo yum install -y pv

#echo "Installing ranger"
#sudo yum install -y ranger

echo "Installing redhat-lsb-core"
sudo yum install -y redhat-lsb-core

echo "Installing samba"
sudo yum install -y samba samba-client
sudo systemctl enable --now smb
sudo systemctl enable --now nmb

echo "Installing screen"
sudo yum install -y screen

echo "Installing socat"
sudo yum install -y socat

echo "Installing sox"
sudo yum install -y sox

echo "Installing sshd (openssh-server)"
sudo yum install -y openssh-server
sudo firewall-cmd --add-service=ssh
sudo firewall-cmd --add-service=ssh --permanent
sudo firewall-cmd --reload

echo "Installing sshfs"
sudo yum install -y fuse-sshfs

echo "Installing sshpass"
sudo yum install -y sshpass

#echo "Installing tmux"
#sudo yum install -y tmux

echo "Installing traceroute"
sudo yum install -y traceroute

echo "Installing tree"
sudo yum install -y tree

#echo "Installing update-java-alternatives"
#sudo yum install -y java-common

#echo "Installing wordlists"
#sudo yum install -y wamerican wamerican-huge wbritish wbritish-huge

#echo "Installing xclip"
#sudo yum install -y xclip

#echo "Installing xclock"
#sudo yum install -y xorg-x11-apps

#echo "Installing zcat, zgrep (wrapper)"
#sudo yum install -y zutils
