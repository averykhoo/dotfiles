#!/usr/bin/env bash

# we need sudo permissions

sudo echo "installing all the things"

# add extended repo for more packages

sudo echo "adding epel repo"
if [[ $(rpm -qa) != *epel-release* ]]; then
    sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    ARCH=$( /bin/arch )
    sudo subscription-manager repos --enable "codeready-builder-for-rhel-8-${ARCH}-rpms"
    unset ARCH
    sudo dnf config-manager --set-enabled PowerTools
else
    echo 'already added'
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

echo "Installing pigz"
[[ ! -x "$(command -v pigz)" ]] && sudo yum install -y pigz

#echo "Installing unar, lsar"
#[[ ! -x "$(command -v unar)" ]] && sudo yum install -y unar

#echo "Installing unrar"
#[[ ! -x "$(command -v unrar)" ]] && sudo yum install -y unrar

#echo "Installing unp"
#[[ ! -x "$(command -v unp)" ]] && sudo yum install -y unp

echo "Installing unzip"
[[ ! -x "$(command -v unzip)" ]] && sudo yum install -y unzip

#echo "Installing xdms"
#[[ ! -x "$(command -v xdms)" ]] && sudo yum install -y xdms

#echo "Installing xz-utils"
#[[ ! -x "$(command -v xz)" ]] && sudo yum install -y xz-utils

echo "Installing zstd"
[[ ! -x "$(command -v zstd)" ]] && sudo yum install -y zstd

# vendored installs

[[ -d /usr/local/share/fonts ]] || sudo mkdir -p /usr/local/share/fonts
[[ -d ~/.local/bin/ ]] || mkdir -p ~/.local/bin/
[[ -d ~/.local/share/man/man1/ ]] || mkdir -p ~/.local/share/man/man1/

echo "Installing Iosevka"
sudo cp ~/dotfiles/vendored/iosevka-3.0.0-rc.8/iosevka-*.ttf /usr/local/share/fonts

echo "Installing '$' ignorer"
cp ~/dotfiles/vendored/dollar_sign ~/.local/bin/'$'
sudo chmod +x ~/.local/bin/'$'

echo "Installing bat-extras"
cp ~/dotfiles/vendored/bat-extras-20200501/batdiff ~/.local/bin/batdiff
cp ~/dotfiles/vendored/bat-extras-20200501/batgrep ~/.local/bin/batgrep
cp ~/dotfiles/vendored/bat-extras-20200501/batman ~/.local/bin/batman
cp ~/dotfiles/vendored/bat-extras-20200501/batwatch ~/.local/bin/batwatch
cp ~/dotfiles/vendored/bat-extras-20200501/prettybat ~/.local/bin/prettybat
sudo chmod +x ~/.local/bin/batdiff
sudo chmod +x ~/.local/bin/batgrep
sudo chmod +x ~/.local/bin/batman
sudo chmod +x ~/.local/bin/batwatch
sudo chmod +x ~/.local/bin/prettybat

echo "Installing exa"
cp ~/dotfiles/vendored/exa-linux-x86_64-0.9.0 ~/.local/bin/exa
sudo chmod +x ~/.local/bin/exa

echo "Increase inotify watch limit for pycharm"
sudo cp ~/dotfiles/vendored/jetbrains_watch_limit.conf /etc/sysctl.d/jetbrains_watch_limit.conf
sudo sysctl -p --system

echo "Installing tldr"
cp ~/dotfiles/vendored/pepa65-tldr-bash-client-0.45/tldr ~/.local/bin/tldr
cp ~/dotfiles/vendored/pepa65-tldr-bash-client-0.45/tldr-lint ~/.local/bin/tldr-lint
sudo chmod +x ~/.local/bin/tldr
sudo chmod +x ~/.local/bin/tldr-lint
[[ ! -d ~/.local/share/tldr ]] && tar -xvf ~/dotfiles/vendored/pepa65-tldr-bash-client-0.45/tldr.tar.gz -C ~/.local/share/
~/.local/bin/tldr --update

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
fi
sudo chmod +x ~/.vnc/xstartup
sudo chmod +r ~/.vnc/xstartup

echo "Installing xsv"
cp ~/dotfiles/vendored/xsv-0.13.0-x86_64-unknown-linux-musl ~/.local/bin/xsv
sudo chmod +x ~/.local/bin/xsv

# pre-reqs

echo "Installing curl"
sudo yum install -y curl

echo "Installing git & git-lfs"
sudo yum install -y git git-lfs

echo "Installing jq"
sudo yum install -y jq

echo "Installing pip3"
sudo yum install -y python3-pip

echo "Installing snap"
sudo yum install -y snapd
sudo systemctl enable --now snapd

echo "Installing wget"
sudo yum install -y wget

# pip installs

echo "Installing ad"
pip3 install --user advance-touch

echo "Installing tabulate"
pip3 install --user tabulate

echo "Installing unidecode"
pip3 install --user unidecode

echo "Installing trash-cli"
pip3 install --user trash-cli

echo "Installing pydf"
pip3 install --user pydf

#echo "Installing glances (and bottle)"
#pip3 install --user bottle
#pip3 install --user glances

echo "Installing powerline"
pip3 install --user powerline-status

# java

echo "Installing JDK 11.0.7"
sudo yum install -y jdk-11.0.7
if [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then

    echo "Acquiring java from Adobe's legally questionable but very helpful mirror"
    # https://www.oracle.com/webfolder/s/digest/11-0-7-checksum.html
    CHECKSUM=0eb9441dfd2be041ca1075842c5335a731e60c6ea2bfb1e947224136098c2670
    # https://www.adobe.com/support/coldfusion/downloads.html
    wget http://download.macromedia.com/pub/coldfusion/java/java11/1107/jdk-11.0.7_linux-x64_bin.rpm

    if echo "$CHECKSUM jdk-11.0.7_linux-x64_bin.rpm" | sha256sum --check -; then
        echo "Downloaded and verified sha256 hash, finally actually installing java"
        sudo yum install -y jdk-11.0.7_linux-x64_bin.rpm
        sudo rm jdk-11.0.7_linux-x64_bin.rpm
    else
        echo "ERROR: java checksum failed!"
    fi
    unset CHECKSUM
    rm jdk-11.0.7_linux-x64_bin.rpm

else
    echo "already installed"
fi

# download and install

echo "Installing browsh"
if [[ ! -x "$(command -v browsh)" ]]; then
    curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
     | jq -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.rpm")) | .browser_download_url' \
     | wget -i -
    sudo yum install -y browsh_*_linux_amd64.rpm
    rm browsh_*_linux_amd64.rpm
else
    echo "already installed"
fi

echo "Installing bat"
if [[ ! -x "$(command -v bat)" ]]; then
    curl "https://api.github.com/repos/sharkdp/bat/releases/latest" \
     | jq -r '.assets[] | select(.name|test("bat-.*-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
     | wget -i -
    tar -xvf ./bat-*-x86_64-unknown-linux-musl.tar.gz
    cp ./bat-*-x86_64-unknown-linux-musl/bat ~/.local/bin/bat
    sudo chmod +x ~/.local/bin/bat
    cp ./bat-*-x86_64-unknown-linux-musl/bat.1 ~/.local/share/man/man1/bat.1
    rm -rf ./bat-*-x86_64-unknown-linux-musl/
    rm ./bat-*-x86_64-unknown-linux-musl.tar.gz
else
    echo "already installed"
fi

echo "Installing chrome"
if [[ ! -x "$(command -v google-chrome)" ]]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.rpm
    sudo yum install -y google-chrome-stable_current_amd64.rpm
    rm google-chrome-stable_current_amd64.rpm
else
    echo "already installed"
fi

echo "Installing delta"
if [[ ! -x "$(command -v delta)" ]]; then
    curl "https://api.github.com/repos/dandavison/delta/releases/latest" \
     | jq -r '.assets[] | select(.name|test("delta-.*-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
     | wget -i -
    tar -xvf ./delta-*-x86_64-unknown-linux-musl.tar.gz
    cp ./delta-*-x86_64-unknown-linux-musl/delta ~/.local/bin/delta
    sudo chmod +x ~/.local/bin/delta
    rm -rf ./delta-*-x86_64-unknown-linux-musl/
    rm ./delta-*-x86_64-unknown-linux-musl.tar.gz
else
    echo "already installed"
fi

echo "Installing fd"
if [[ ! -x "$(command -v fd)" ]]; then
    curl "https://api.github.com/repos/sharkdp/fd/releases/latest" \
     | jq -r '.assets[] | select(.name|test("fd-.*-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
     | wget -i -
    tar -xvf ./fd-*-x86_64-unknown-linux-musl.tar.gz
    cp ./fd-*-x86_64-unknown-linux-musl/fd ~/.local/bin/fd
    sudo chmod +x ~/.local/bin/fd
    cp ./fd-*-x86_64-unknown-linux-musl/fd.1 ~/.local/share/man/man1/fd.1
    rm -rf ./fd-*-x86_64-unknown-linux-musl/
    rm ./fd-*-x86_64-unknown-linux-musl.tar.gz
else
    echo "already installed"
fi

echo "Installing fzf"
if [[ ! -d ~/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "already installed"
fi

echo "Installing hexyl"
if [[ ! -x "$(command -v hexyl)" ]]; then
    curl "https://api.github.com/repos/sharkdp/hexyl/releases/latest" \
     | jq -r '.assets[] | select(.name|test("hexyl-.*-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
     | wget -i -
    tar -xvf ./hexyl-*-x86_64-unknown-linux-musl.tar.gz
    cp ./hexyl-*-x86_64-unknown-linux-musl/hexyl ~/.local/bin/hexyl
    sudo chmod +x ~/.local/bin/hexyl
    cp ./hexyl-*-x86_64-unknown-linux-musl/hexyl.1 ~/.local/share/man/man1/hexyl.1
    rm -rf ./hexyl-*-x86_64-unknown-linux-musl/
    rm ./hexyl-*-x86_64-unknown-linux-musl.tar.gz
else
    echo "already installed"
fi

echo "Installing hyperfine"
if [[ ! -x "$(command -v hyperfine)" ]]; then
    curl "https://api.github.com/repos/sharkdp/hyperfine/releases/latest" \
     | jq -r '.assets[] | select(.name|test("hyperfine-.*-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
     | wget -i -
    tar -xvf ./hyperfine-*-x86_64-unknown-linux-musl.tar.gz
    cp ./hyperfine-*-x86_64-unknown-linux-musl/hyperfine ~/.local/bin/hyperfine
    sudo chmod +x ~/.local/bin/hyperfine
    cp ./hyperfine-*-x86_64-unknown-linux-musl/hyperfine.1 ~/.local/share/man/man1/hyperfine.1
    rm -rf ./hyperfine-*-x86_64-unknown-linux-musl/
    rm ./hyperfine-*-x86_64-unknown-linux-musl.tar.gz
else
    echo "already installed"
fi

echo "Installing micro"
if [[ ! -x "$(command -v micro)" ]]; then
    curl https://getmic.ro | bash
    mv micro ~/.local/bin/
else
    echo "already installed"
fi

echo "Installing powerline font"
if [[ ! -f ~/.local/share/fonts/PowerlineSymbols.otf ]]; then
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mkdir -p ~/.local/share/fonts/
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
else
    echo "already installed"
fi

echo "Installing powerline fontconfig"
if [[ ! -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]]; then
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.config/fontconfig/conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
else
    echo "already installed"
fi

echo "Installing ripgrep"
if [[ ! -x "$(command -v ripgrep)" ]]; then
    curl "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" \
     | jq -r '.assets[] | select(.name|test("ripgrep-.*-x86_64-unknown-linux-musl.tar.gz")) | .browser_download_url' \
     | wget -i -
    tar -xvf ./ripgrep-*-x86_64-unknown-linux-musl.tar.gz
    cp ./ripgrep-*-x86_64-unknown-linux-musl/rg ~/.local/bin/rg
    sudo chmod +x ~/.local/bin/rg
    cp ./ripgrep-*-x86_64-unknown-linux-musl/doc/rg.1 ~/.local/share/man/man1/rg.1
    rm -rf ./ripgrep-*-x86_64-unknown-linux-musl/
    rm ./ripgrep-*-x86_64-unknown-linux-musl.tar.gz
else
    echo "already installed"
fi

#echo "Installing snowflake (renamed to muon)"
#if [[ ! -x "$(command -v snowflake)" ]]; then
#    curl "https://api.github.com/repos/subhra74/snowflake/releases/latest" \
#     | jq -r '.assets[] | select(.name|test("snowflake-.*-setup-amd64.deb")) | .browser_download_url' \
#     | wget -i -
##    sudo gdebi --non-interactive snowflake-*-setup-amd64.deb
#    rm snowflake-*-setup-amd64.deb
#else
#    echo "already installed"
#fi

echo "Installing tigervnc server"
if [[ ! -x "$(command -v vncserver)" ]]; then
    RELEASE="tigervnc-1.10.1.x86_64"
    wget -O ${RELEASE}.tar.gz https://bintray.com/tigervnc/stable/download_file?file_path=${RELEASE}.tar.gz
    tar -xvf ${RELEASE}.tar.gz
    rm ${RELEASE}.tar.gz
    sudo cp -R ${RELEASE}/usr/ /
    rm -rf ${RELEASE}/
else
    echo "already installed"
fi

# apt installs

echo "Installing aria2"
sudo yum install -y aria2

#echo "Installing asciinema"
#sudo yum install -y asciinema

#echo "Installing autojump"
#sudo yum install -y autojump

echo "Installing baobab"
sudo yum install -y baobab

echo "Installing byobu"
sudo yum install -y byobu

echo "Installing cifs"
sudo yum install -y cifs-utils

echo "Installing cockpit"
sudo yum install -y cockpit
sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --add-service=cockpit
sudo firewall-cmd --add-service=cockpit --permanent
[[ -e /etc/motd.d/cockpit ]] && sudo rm /etc/motd.d/cockpit

echo "Installing coreutils (e.g. realpath)"
sudo yum install -y coreutils

#echo "Installing cuneiform"
#sudo yum install -y cuneiform

#echo "Installing exfat-fuse"
#sudo yum install -y exfat-fuse

#echo "Installing feh"
#sudo yum install -y feh

#echo "Installing ffmpeg"
#sudo yum install -y ffmpeg ffmpeg-doc

echo "Installing firefox"
sudo yum install -y firefox

echo "Installing Noto font"
sudo yum install -y google-noto-*

echo "Installing gedit (with plugins)"
sudo yum install -y gedit gedit-plugins

#echo "Installing glogg"
#sudo yum install -y glogg

echo "Installing gparted"
sudo yum install -y gparted

#echo "Installing gufw (and ufw)"
#sudo yum install -y gufw

echo "Installing htop"
sudo yum install -y htop

#echo "Installing httpie"
#sudo yum install -y httpie

echo "Installing ifconfig"
sudo yum install -y net-tools

#echo "Installing jid"
#sudo yum install -y jid

echo "Installing locate, updatedb (and findutils)"
sudo yum install -y findutils
sudo yum install -y mlocate

#echo "Installing lnav"
#sudo yum install -y lnav

echo "Installing masscan"
sudo yum install -y masscan

echo "Installing midnight commander"
sudo yum install -y mc

echo "Installing mosh"
sudo yum install -y mosh

echo "Installing mtr"
sudo yum install -y mtr

echo "Installing multitail"
sudo yum install -y multitail

echo "Installing nano"
sudo yum install -y nano

echo "Installing ncdu"
sudo yum install -y ncdu

#echo "Installing nfs-server"
#sudo yum install -y nfs-kernel-server

echo "Installing nmap"
sudo yum install -y nmap

echo "Installing nmtui"
sudo yum install -y network-manager

echo "Installing ntfs-3g"
sudo yum install -y ntfs-3g ntfsprogs

echo "Installing pandoc"
sudo yum install -y pandoc

#echo "Installing peco"
#sudo yum install -y peco

#echo "Installing pglob, pkill"
#sudo yum install -y procps

#echo "Installing prettyping"
#sudo yum install -y prettyping

#echo "Installing pv"
#sudo yum install -y pv

#echo "Installing ranger"
#sudo yum install -y ranger

echo "Installing redhat-lsb-core"
sudo yum install -y redhat-lsb-core

echo "Installing samba"
sudo yum install -y samba

echo "Installing screen"
sudo yum install -y screen

#echo "Installing shellcheck"
#sudo yum install -y shellcheck

echo "Installing socat"
sudo yum install -y socat

echo "Installing sox"
sudo yum install -y sox

echo "Installing sshd (openssh-server)"
sudo yum install -y openssh-server

echo "Installing sshfs"
sudo yum install -y fuse-sshfs

echo "Installing sshpass"
sudo yum install -y sshpass

echo "Installing tesseract"
sudo yum install -y tesseract

echo "Installing tmux"
sudo yum install -y tmux

echo "Installing traceroute"
sudo yum install -y traceroute

echo "Installing tree"
sudo yum install -y tree

#echo "Installing uidmap"
#sudo yum install -y uidmap

#echo "Installing update-java-alternatives"
#sudo yum install -y java-common

#echo "Installing vlc"
#sudo yum install -y vlc

#echo "Installing wordlists"
#sudo yum install -y wamerican wamerican-huge wbritish wbritish-huge

echo "Installing xclip"
sudo yum install -y xclip

echo "Installing xclock"
sudo yum install -y xorg-x11-apps

echo "Installing youtube-dl"
sudo yum install -y youtube-dl

#echo "Installing yagf"
#sudo yum install -y yagf

#echo "Installing zcat, zgrep (wrapper)"
#sudo yum install -y zutils

#echo "Installing zmap"
#sudo yum install -y zmap
