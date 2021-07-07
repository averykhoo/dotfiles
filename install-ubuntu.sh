#!/usr/bin/env bash

# we need sudo permissions

sudo echo "installing all the things"

# is apt available?
if [[ ! -x "$(command -v apt)" ]]; then
    echo "ERROR: apt not found, wrong os?" >> /dev/stderr
    exit 1
fi

# update apt
echo "updating apt"
sudo apt update

# cleanup MOTD

[[ ! -d /etc/update-motd.d.bak/ ]] && sudo mkdir /etc/update-motd.d.bak/
[[ -f /etc/update-motd.d/10-help-text ]] &&            sudo mv /etc/update-motd.d/10-help-text            /etc/update-motd.d.bak/10-help-text
[[ -f /etc/update-motd.d/50-motd-news ]] &&            sudo mv /etc/update-motd.d/50-motd-news            /etc/update-motd.d.bak/50-motd-news
[[ -f /etc/update-motd.d/90-updates-available ]] &&    sudo mv /etc/update-motd.d/90-updates-available    /etc/update-motd.d.bak/90-updates-available
[[ -f /etc/update-motd.d/91-release-upgrade ]] &&      sudo mv /etc/update-motd.d/91-release-upgrade      /etc/update-motd.d.bak/91-release-upgrade
[[ -f /etc/update-motd.d/92-unattended-upgrades ]] &&  sudo mv /etc/update-motd.d/92-unattended-upgrades  /etc/update-motd.d.bak/92-unattended-upgrades
[[ -f /etc/update-motd.d/95-hwe-eol ]] &&              sudo mv /etc/update-motd.d/95-hwe-eol              /etc/update-motd.d.bak/95-hwe-eol

# fix timezone

[[ -e /usr/share/zoneinfo/Asia/Singapore ]] && sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# file compression

echo "Installing bzip2"
[[ ! -x "$(command -v bzip2)" ]] && sudo apt install -y bzip2

echo "Installing cabextract"
[[ ! -x "$(command -v cabextract)" ]] && sudo apt install -y cabextract

echo "Installing gzip"
[[ ! -x "$(command -v gzip)" ]] && sudo apt install -y gzip

echo "Installing lzip"
[[ ! -x "$(command -v lzip)" ]] && sudo apt install -y lzip

echo "Installing p7zip"
[[ ! -x "$(command -v 7z)" ]] && sudo apt install -y p7zip p7zip-full p7zip-rar

echo "Installing pigz"
[[ ! -x "$(command -v pigz)" ]] && sudo apt install -y pigz

echo "Installing unar, lsar"
[[ ! -x "$(command -v unar)" ]] && sudo apt install -y unar

echo "Installing unrar"
[[ ! -x "$(command -v unrar)" ]] && sudo apt install -y unrar

echo "Installing unp"
[[ ! -x "$(command -v unp)" ]] && sudo apt install -y unp

echo "Installing zip"
[[ ! -x "$(command -v zip)" ]] && sudo apt install -y zip

echo "Installing unzip"
[[ ! -x "$(command -v unzip)" ]] && sudo apt install -y unzip

echo "Installing xdms"
[[ ! -x "$(command -v xdms)" ]] && sudo apt install -y xdms

echo "Installing xz-utils"
[[ ! -x "$(command -v xz)" ]] && sudo apt install -y xz-utils

echo "Installing zstd"
[[ ! -x "$(command -v zstd)" ]] && sudo apt install -y zstd

# pre-reqs

echo "Installing curl"
sudo apt install -y curl

echo "Installing gdebi-core"
sudo apt install -y gdebi-core

echo "Installing git & git-lfs"
sudo apt install -y git git-lfs

echo "Installing jq"
sudo apt install -y jq

#echo "Installing snap"
#sudo apt install -y snapd
#sudo systemctl enable --now snapd

echo "Installing software-properties-common"
sudo apt install -y software-properties-common

echo "Installing wget"
sudo apt install -y wget

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
    echo "Installing exa"
    cp ~/dotfiles/vendored/exa-linux-x86_64-*/bin/exa ~/.local/bin/exa
    sudo chmod +x ~/.local/bin/exa
    cp ~/dotfiles/vendored/exa-linux-x86_64-*/man/exa.1 ~/.local/share/man/man1/exa.1
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
    tar -xf ~/dotfiles/vendored/fzf-*.tar.gz -C ~
    git -C ~/.fzf/ pull
    ~/.fzf/install --all
fi

if [[ ! -x "$(command -v hexyl)" ]]; then
    echo "Installing hexyl"
    cp ~/dotfiles/vendored/hexyl-*-x86_64-unknown-linux-musl/hexyl ~/.local/bin/hexyl
    sudo chmod +x ~/.local/bin/hexyl
fi

if [[ ! -x "$(command -v htop)" ]]; then
    echo "Installing htop"
    #sudo apt install -y htop
    sudo gdebi --non-interactive ~/dotfiles/vendored/htop/htop_3.0.2-1_amd64.deb
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

if [[ ! -x "$(command -v klogg)" ]]; then
    echo "Installing klogg"
    sudo gdebi --non-interactive ~/dotfiles/vendored/klogg-*-Linux/klogg-*-Linux.deb
fi

if [[ ! -x "$(command -v micro)" ]]; then
    echo "Installing micro"
    cp ~/dotfiles/vendored/micro-*-linux64-static/micro ~/.local/bin/micro
    cp ~/dotfiles/vendored/micro-*-linux64-static/micro.1 ~/.local/share/man/man1/micro.1
    sudo chmod +x ~/.local/bin/micro
fi

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
    cp ~/dotfiles/vendored/safe-rm-*/safe-rm /usr/local/bin/safe-rm
    cp ~/dotfiles/vendored/safe-rm-*/safe-rm.conf /usr/local/etc/safe-rm.conf
    sudo chmod +x /usr/local/bin/safe-rm
fi

if [[ ! -x "$(command -v tldr)" ]]; then
    echo "Installing tldr"
    cp ~/dotfiles/vendored/pepa65-tldr-bash-client-*/tldr ~/.local/bin/tldr
    cp ~/dotfiles/vendored/pepa65-tldr-bash-client-*/tldr-lint ~/.local/bin/tldr-lint
    sudo chmod +x ~/.local/bin/tldr
    sudo chmod +x ~/.local/bin/tldr-lint
    [[ ! -d ~/.local/share/tldr ]] && tar -xf ~/dotfiles/vendored/pepa65-tldr-bash-client-*/tldr.tar.gz -C ~/.local/share/
    ~/.local/bin/tldr --update
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
    #sudo apt install xfce4 xfce4-goodies
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
sudo apt install -y python3-pip

if [[ ! -x "$(command -v ad)" ]]; then
    echo "Installing ad"
    pip3 install --user --no-warn-script-location advance-touch
fi

if [[ ! -x "$(command -v csvgrep)" ]]; then
    echo "Installing csvkit"
    pip3 install --user --no-warn-script-location csvkit
fi

if [[ ! -x "$(command -v glances)" ]]; then
    echo "Installing glances (and bottle)"
    pip3 install --user --no-warn-script-location bottle
    pip3 install --user --no-warn-script-location glances
fi

if [[ ! -x "$(command -v html2text)" ]]; then
    echo "Installing html2text"
    pip3 install --user --no-warn-script-location html2text
fi

if [[ ! -x "$(command -v langid)" ]]; then
    echo "Installing langid"
    pip3 install --user --no-warn-script-location langid
fi

if [[ ! -x "$(command -v powerline-daemon)" ]]; then
    echo "Installing powerline"
    pip3 install --user --no-warn-script-location powerline-status
fi

if [[ ! -x "$(command -v pydf)" ]]; then
    echo "Installing pydf"
    pip3 install --user --no-warn-script-location pydf
fi

if [[ ! -x "$(command -v pygmentize)" ]]; then
    echo "Installing pygmentize"
    pip3 install --user --no-warn-script-location pygments
fi

if [[ ! -x "$(command -v tabulate)" ]]; then
    echo "Installing tabulate"
    pip3 install --user --no-warn-script-location tabulate
fi

if [[ ! -x "$(command -v trash)" ]]; then
    echo "Installing trash-cli"
    pip3 install --user --no-warn-script-location trash-cli
fi

if [[ ! -x "$(command -v unidecode)" ]]; then
    echo "Installing unidecode"
    pip3 install --user --no-warn-script-location unidecode
fi

if [[ ! -x "$(command -v vd)" ]]; then
    echo "Installing visidata"
    pip3 install --user --no-warn-script-location visidata
fi

if [[ ! -x "$(command -v wormhole)" ]]; then
    echo "Installing wormhole"
    pip3 install --user --no-warn-script-location magic-wormhole
fi

if [[ ! -x "$(command -v zxcvbn)" ]]; then
    echo "Installing zxcvbn"
    pip3 install --user --no-warn-script-location zxcvbn
fi


# download and install

echo "Installing browsh"
if [[ ! -x "$(command -v browsh)" ]]; then
    if ls browsh_*_linux_amd64.deb 1> /dev/null 2>&1; then
        echo "found installer"
    else
        curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
         | jq -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.deb")) | .browser_download_url' \
         | wget -i -
    fi
    sudo gdebi --non-interactive browsh_*_linux_amd64.deb
    rm browsh_*_linux_amd64.deb
else
    echo "already installed"
fi

echo "Installing chrome"
if [[ ! -x "$(command -v google-chrome)" ]]; then
    if ls google-chrome-stable_current_amd64.deb 1> /dev/null 2>&1; then
        echo "found installer"
    else
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    sudo gdebi --non-interactive google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    echo "already installed"
fi

echo "Installing tigervnc server"
if [[ ! -x "$(command -v x0vncserver)" ]]; then
    RELEASE="tigervnc-1.11.0.x86_64"
    if [[ ! -f ${RELEASE}.tar.gz ]]; then
        wget -O ${RELEASE}.tar.gz https://bintray.com/tigervnc/stable/download_file?file_path=${RELEASE}.tar.gz
    fi
    tar -xf ${RELEASE}.tar.gz
    rm ${RELEASE}.tar.gz
    sudo cp -R ${RELEASE}/usr/ /
    rm -rf ${RELEASE}/
else
    echo "already installed"
fi
if [[ ! -x "$(command -v vncserver)" ]]; then
    sudo cp ~/dotfiles/vendored/vncserver /usr/bin/
    sudo chmod +x /usr/bin/vncserver
fi

# apt installs

echo "Installing aria2"
sudo apt install -y aria2

echo "Installing atop"
sudo apt install -y atop

echo "Installing asciinema"
sudo apt install -y asciinema

echo "Installing autojump"
sudo apt install -y autojump

#echo "Installing baobab"
#sudo apt install -y baobab

echo "Installing byobu"
sudo apt install -y byobu

echo "Installing catimg"
sudo apt install -y catimg

echo "Installing cifs"
sudo apt install -y cifs-utils

echo "Installing cockpit"
sudo apt install -y cockpit cockpit-pcp
sudo systemctl enable cockpit.socket
sudo ufw allow 9090
[[ -e /etc/motd.d/cockpit ]] && sudo rm /etc/motd.d/cockpit

echo "Installing coreutils (e.g. realpath)"
sudo apt install -y coreutils

echo "Installing cuneiform"
sudo apt install -y cuneiform

echo "Installing dos2unix"
sudo apt install -y dos2unix

echo "Installing exfat-fuse"
sudo apt install -y exfat-fuse

echo "Installing feh"
sudo apt install -y feh

echo "Installing ffmpeg"
sudo apt install -y ffmpeg ffmpeg-doc

echo "Installing fio"
sudo apt install -y fio

echo "Installing firefox"
sudo apt install -y firefox

echo "Installing Noto font"
sudo apt install -y fonts-noto

#echo "Installing gedit (with plugins)"
#sudo apt install -y gedit gedit-common gedit-plugins

if [[ ! -x "$(command -v klogg)" ]]; then
    echo "Installing glogg"
    sudo apt install -y glogg
fi

echo "Installing gparted"
sudo apt install -y gparted

#echo "Installing gufw (and ufw)"
#sudo apt install -y gufw

echo "Installing httpie"
sudo apt install -y httpie

echo "Installing ifconfig"
sudo apt install -y net-tools

echo "Installing iftop"
sudo apt install -y iftop

echo "Installing imagemagick"
sudo apt install -y imagemagick

echo "Installing iotop"
sudo apt install -y iotop

echo "Installing jid"
sudo apt install -y jid

echo "Installing less"
sudo apt install -y less

echo "Installing locate, updatedb (and findutils)"
sudo apt install -y mlocate

echo "Installing lnav"
sudo apt install -y lnav

echo "Installing lsof"
sudo apt install -y lsof

echo "Installing masscan"
sudo apt install -y masscan

echo "Installing midnight commander"
sudo apt install -y mc

echo "Installing mosh"
sudo apt install -y mosh
[[ -x "$(command -v ufw)" ]] && [[ $(sudo ufw app list) = *mosh* ]] && sudo ufw allow mosh

echo "Installing mousepad"
sudo apt install -y mousepad

echo "Installing mtr"
sudo apt install -y mtr-tiny

echo "Installing multitail"
sudo apt install -y multitail

echo "Installing nano"
sudo apt install -y nano

echo "Installing ncdu"
sudo apt install -y ncdu

echo "Installing nfs-server"
sudo apt install -y nfs-kernel-server

echo "Installing nmap"
sudo apt install -y nmap

echo "Installing nmtui"
sudo apt install -y network-manager

echo "Installing nslookup, dig"
sudo apt install -y dnsutils

echo "Installing ntfs-3g"
sudo apt install -y ntfs-3g

echo "Installing pandoc"
sudo apt install -y pandoc

echo "Installing parallel"
sudo apt install -y parallel

echo "Installing peco"
sudo apt install -y peco

echo "Installing pexec"
sudo apt install -y pexec

echo "Installing pglob, pkill"
sudo apt install -y procps

echo "Installing poppler-utils"
sudo apt install -y poppler-utils

echo "Installing prettyping"
sudo apt install -y prettyping

echo "Installing psmisc"
sudo apt install -y psmisc

echo "Installing pv"
sudo apt install -y pv

echo "Installing ranger"
sudo apt install -y ranger

echo "Installing samba"
sudo apt install -y samba smbclient
sudo systemctl enable --now smbd
sudo systemctl enable --now nmbd

echo "Installing screen"
sudo apt install -y screen

echo "Installing shellcheck"
sudo apt install -y shellcheck

echo "Installing socat"
sudo apt install -y socat

echo "Installing sox"
sudo apt install -y sox

echo "Installing sshd (openssh-server)"
sudo apt install -y openssh-server
[[ -x "$(command -v ufw)" ]] && [[ $(sudo ufw app list) = *OpenSSH* ]] && sudo ufw allow OpenSSH

echo "Installing sshfs"
sudo apt install -y sshfs

echo "Installing sshpass"
sudo apt install -y sshpass

echo "Installing tesseract"
sudo apt install -y tesseract-ocr

echo "Installing tmux"
sudo apt install -y tmux

echo "Installing traceroute"
sudo apt install -y traceroute

echo "Installing tree"
sudo apt install -y tree

echo "Installing uidmap"
sudo apt install -y uidmap

echo "Installing update-java-alternatives"
sudo apt install -y java-common

#echo "Installing vlc"
#sudo apt install -y vlc

echo "Installing wordlists"
sudo apt install -y wamerican wamerican-huge wbritish wbritish-huge

echo "Installing xclip"
sudo apt install -y xclip

echo "Installing xclock"
sudo apt install -y x11-apps

echo "Installing youtube-dl"
sudo apt install -y youtube-dl

echo "Installing yagf"
sudo apt install -y yagf

echo "Installing zcat, zgrep (wrapper)"
sudo apt install -y zutils

echo "Installing zmap"
sudo apt install -y zmap
