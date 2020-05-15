#!/usr/bin/env bash

# vendored installs

[[ -d /usr/local/share/fonts ]] || sudo mkdir -p /usr/local/share/fonts
[[ -d ~/.local/bin/ ]] || mkdir -p ~/.local/bin/

echo "Installing Iosevka"
sudo cp ./install/iosevka-3.0.0-rc.8/iosevka-*.ttf /usr/local/share/fonts

echo "Installing '$' ignorer"
sudo cp ./install/dollar_sign ~/.local/bin/'$'
sudo chmod +x ~/.local/bin/'$'

echo "Installing bat-extras"
sudo cp ./install/bat-extras-20200501/batdiff ~/.local/bin/batdiff
sudo cp ./install/bat-extras-20200501/batgrep ~/.local/bin/batgrep
sudo cp ./install/bat-extras-20200501/batman ~/.local/bin/batman
sudo cp ./install/bat-extras-20200501/batwatch ~/.local/bin/batwatch
sudo cp ./install/bat-extras-20200501/prettybat ~/.local/bin/prettybat
sudo chmod +x ~/.local/bin/batdiff
sudo chmod +x ~/.local/bin/batgrep
sudo chmod +x ~/.local/bin/batman
sudo chmod +x ~/.local/bin/batwatch
sudo chmod +x ~/.local/bin/prettybat

echo "Installing exa"
sudo cp ./install/exa-linux-x86_64-0.9.0 ~/.local/bin/exa
sudo chmod +x ~/.local/bin/exa

echo "Configuring xstartup"
[[ -d ~/.vnc ]] || mkdir ~/.vnc
[[ -f ~/.vnc/xstartup ]] && mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
cp ./install/xstartup ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup
sudo chmod +r ~/.vnc/xstartup

echo "Installing xsv"
sudo cp ./install/xsv-0.13.0-x86_64-unknown-linux-musl ~/.local/bin/xsv
sudo chmod +x ~/.local/bin/xsv

# pre-reqs

echo "Installing curl"
sudo apt install -y curl

echo "Installing gdebi-core"
sudo apt install -y gdebi-core

echo "Installing git & git-lfs"
sudo apt install -y git git-lfs

echo "Installing jq"
sudo apt install -y jq

echo "Installing pip3"
sudo apt install -y python3-pip

echo "Installing software-properties-common"
sudo apt install -y software-properties-common

echo "Installing wget"
sudo apt install -y wget

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

echo "Installing glances (and bottle)"
pip3 install --user bottle
pip3 install --user glances

echo "Installing powerline"
pip3 install --user powerline-status

# download and install

echo "Installing browsh"
if [[ ! -x "$(command -v browsh)" ]]; then
    curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
     | jq -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive browsh_*_linux_amd64.deb
    rm browsh_*_linux_amd64.deb
else
    echo "already installed"
fi

echo "Installing bat"
if [[ ! -x "$(command -v bat)" ]]; then
    curl "https://api.github.com/repos/sharkdp/bat/releases/latest" \
     | jq -r '.assets[] | select(.name|test("bat-musl_.*_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive bat-musl_*_amd64.deb
    rm bat-musl_*_amd64.deb
else
    echo "already installed"
fi

echo "Installing chrome"
if [[ ! -x "$(command -v google-chrome)" ]]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo gdebi --non-interactive google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
else
    echo "already installed"
fi

echo "Installing delta"
if [[ ! -x "$(command -v delta)" ]]; then
    curl "https://api.github.com/repos/dandavison/delta/releases/latest" \
     | jq -r '.assets[] | select(.name|test("git-delta-musl_.*_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive git-delta-musl_*_amd64.deb
    rm git-delta-musl_*_amd64.deb
else
    echo "already installed"
fi

echo "Installing fd"
if [[ ! -x "$(command -v fd)" ]]; then
    curl "https://api.github.com/repos/sharkdp/fd/releases/latest" \
     | jq -r '.assets[] | select(.name|test("fd-musl_.*_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive fd-musl_*_amd64.deb
    rm fd-musl_*_amd64.deb
else
    echo "already installed"
fi

echo "Installing fzf"
if [[ ! -d "~/.fzf" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
else
    echo "already installed"
fi

echo "Installing hexyl"
if [[ ! -x "$(command -v hexyl)" ]]; then
    curl "https://api.github.com/repos/sharkdp/hexyl/releases/latest" \
     | jq -r '.assets[] | select(.name|test("hexyl-musl_.*_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive hexyl-musl_*_amd64.deb
    rm hexyl-musl_*_amd64.deb
else
    echo "already installed"
fi

echo "Installing hyperfine"
if [[ ! -x "$(command -v hyperfine)" ]]; then
    curl "https://api.github.com/repos/sharkdp/hyperfine/releases/latest" \
     | jq -r '.assets[] | select(.name|test("hyperfine_.*_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive hyperfine_*_amd64.deb
    rm hyperfine_*_amd64.deb
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
if [[ ! -f "~/.local/share/fonts/PowerlineSymbols.otf" ]]; then
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mkdir -p ~/.local/share/fonts/
    mv PowerlineSymbols.otf ~/.local/share/fonts/
    fc-cache -vf ~/.local/share/fonts/
else
    echo "already installed"
fi

echo "Installing powerline fontconfig"
if [[ ! -x "$(command -v rg)" ]]; then
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.config/fontconfig/conf.d/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
else
    echo "already installed"
fi

echo "Installing ripgrep"
if [[ ! -x "$(command -v rg)" ]]; then
    curl "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" \
     | jq -r '.assets[] | select(.name|test("ripgrep_.*_amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive ripgrep_*_amd64.deb
    rm ripgrep_*_amd64.deb
else
    echo "already installed"
fi

echo "Installing snowflake (renamed to muon)"
if [[ ! -x "$(command -v snowflake)" ]]; then
    curl "https://api.github.com/repos/subhra74/snowflake/releases/latest" \
     | jq -r '.assets[] | select(.name|test("snowflake-.*-setup-amd64.deb")) | .browser_download_url' \
     | wget -i -
    sudo gdebi --non-interactive snowflake-*-setup-amd64.deb
    rm snowflake-*-setup-amd64.deb
else
    echo "already installed"
fi

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

# file compression

echo "Installing bzip2"
sudo apt install -y bzip2

echo "Installing cabextract"
sudo apt install -y cabextract

echo "Installing gzip"
sudo apt install -y gzip

echo "Installing lzip"
sudo apt install -y lzip

echo "Installing p7zip"
sudo apt install -y p7zip p7zip-full p7zip-rar

echo "Installing pigz"
sudo apt install -y pigz

echo "Installing unar, lsar"
sudo apt install -y unar

echo "Installing unrar"
sudo apt install -y unrar

echo "Installing unp"
sudo apt install -y unp

echo "Installing unzip"
sudo apt install -y unzip

echo "Installing xdms"
sudo apt install -y xdms

echo "Installing xz-utils"
sudo apt install -y xz-utils

echo "Installing zstd"
sudo apt install -y zstd

# apt installs

echo "Installing aria2"
sudo apt install -y aria2

echo "Installing asciinema"
sudo apt install -y asciinema

echo "Installing autojump"
sudo apt install -y autojump

echo "Installing baobab"
sudo apt install -y baobab

echo "Installing byobu"
sudo apt install -y byobu

echo "Installing cifs"
sudo apt install -y cifs-utils

echo "Installing cuneiform"
sudo apt install -y cuneiform

echo "Installing exfat-fuse"
sudo apt install -y exfat-fuse

echo "Installing feh"
sudo apt install -y feh

echo "Installing ffmpeg"
sudo apt install -y ffmpeg ffmpeg-doc

echo "Installing firefox"
sudo apt install -y firefox

echo "Installing Noto font"
sudo apt install -y fonts-noto

echo "Installing gedit (with plugins)"
sudo apt install -y gedit gedit-common gedit-plugins

echo "Installing glogg"
sudo apt install -y glogg

echo "Installing gparted"
sudo apt install -y gparted

echo "Installing gufw (and ufw)"
sudo apt install -y gufw

echo "Installing htop"
sudo apt install -y htop

echo "Installing httpie"
sudo apt install -y httpie

echo "Installing ifconfig"
sudo apt install -y net-tools

echo "Installing jid"
sudo apt install -y jid

echo "Installing locate, updatedb (and findutils)"
sudo apt install -y locate

echo "Installing lnav"
sudo apt install -y lnav

echo "Installing masscan"
sudo apt install -y masscan

echo "Installing midnight commander"
sudo apt install -y mc

echo "Installing mosh"
sudo apt install -y mosh

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

echo "Installing ntfs-3g"
sudo apt install -y ntfs-3g

echo "Installing pandoc"
sudo apt install -y pandoc

echo "Installing peco"
sudo apt install -y peco

echo "Installing pglob, pkill"
sudo apt install -y procps

echo "Installing powershell"
sudo snap install powershell

echo "Installing prettyping"
sudo apt install -y prettyping

echo "Installing pv"
sudo apt install -y pv

echo "Installing ranger"
sudo apt install -y ranger

echo "Installing realpath"
sudo apt install -y coreutils

echo "Installing samba"
sudo apt install -y samba

echo "Installing shellcheck"
sudo apt install -y shellcheck

echo "Installing socat"
sudo apt install -y socat

echo "Installing sox"
sudo apt install -y sox

echo "Installing sshd (openssh-server)"
sudo apt install -y openssh-server

echo "Installing sshfs"
sudo apt install -y sshfs

echo "Installing sshpass"
sudo apt install -y sshpass

echo "Installing tesseract"
sudo apt install -y tesseract-ocr

echo "Installing tldr"
sudo apt install -y tldr
tldr tar

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

echo "Installing vlc"
sudo apt install -y vlc

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

# java

echo "Installing the installer for java (yes really)"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EA8CACC073C3DB2A
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo mkdir -p /var/cache/oracle-jdk11-installer-local/

echo "Acquiring java from Adobe's legally questionable but very helpful mirror"
# https://www.oracle.com/webfolder/s/digest/11-0-7-checksum.html
CHECKSUM=a7334a400fe9a9dbb329e299ca5ebab6ec969b5659a3a72fe0d6f981dbca0224
# https://www.adobe.com/support/coldfusion/downloads.html
wget http://download.macromedia.com/pub/coldfusion/java/java11/1107/jdk-11.0.7_linux-x64_bin.tar.gz

if echo "$CHECKSUM jdk-11.0.7_linux-x64_bin.tar.gz" | sha256sum --check -; then
    echo "Installing java"
    sudo cp jdk-11.0.7_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/
    sudo apt install oracle-java11-installer-local
    sudo rm /var/cache/oracle-jdk11-installer-local/jdk-*_linux-x64_bin.tar.gz
else
    echo "ERROR: java checksum failed!"
fi
unset CHECKSUM
rm jdk-11.0.7_linux-x64_bin.tar.gz