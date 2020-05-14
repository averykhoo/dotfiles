#!/usr/bin/env bash

# copy file installs

echo "Installing '$' ignorer"
sudo cp ./install/dollar_sign ~/.local/bin/'$'
sudo chmod +x ~/.local/bin/'$'

echo "Installing exa"
sudo cp ./install/exa-linux-x86_64-0.9.0 ~/.local/bin/exa
sudo chmod +x ~/.local/bin/exa

echo "Installing xsv"
sudo cp ./install/xsv-0.13.0-x86_64-unknown-linux-musl ~/.local/bin/xsv
sudo chmod +x ~/.local/bin/xsv

# git installs

echo "Installing git & git-lfs"
sudo apt install -y git git-lfs

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# .deb installs

echo "Installing gdebi-core, wget, curl"
sudo apt install -y gdebi-core
sudo apt install -y wget
sudo apt install -y curl

echo "Installing bat"
curl "https://api.github.com/repos/sharkdp/bat/releases/latest" \
 | jq -r '.assets[] | select(.name|test("bat-musl_.*_amd64.deb")) | .browser_download_url' \
 | wget -i -
sudo gdebi bat-musl_*_amd64.deb
rm bat-musl_*_amd64.deb

echo "Installing delta"
curl "https://api.github.com/repos/dandavison/delta/releases/latest" \
 | jq -r '.assets[] | select(.name|test("git-delta-musl_.*_amd64.deb")) | .browser_download_url' \
 | wget -i -
sudo gdebi git-delta-musl_*_amd64.deb
rm git-delta-musl_*_amd64.deb

echo "Installing fd"
curl "https://api.github.com/repos/sharkdp/fd/releases/latest" \
 | jq -r '.assets[] | select(.name|test("fd-musl_.*_amd64.deb")) | .browser_download_url' \
 | wget -i -
sudo gdebi fd-musl_*_amd64.deb
rm fd-musl_*_amd64.deb

echo "Installing hexyl"
curl "https://api.github.com/repos/sharkdp/hexyl/releases/latest" \
 | jq -r '.assets[] | select(.name|test("hexyl-musl_.*_amd64.deb")) | .browser_download_url' \
 | wget -i -
sudo gdebi hexyl-musl_*_amd64.deb
rm hexyl-musl_*_amd64.deb

echo "Installing hyperfine"
curl "https://api.github.com/repos/sharkdp/hyperfine/releases/latest" \
 | jq -r '.assets[] | select(.name|test("hyperfine_.*_amd64.deb")) | .browser_download_url' \
 | wget -i -
sudo gdebi hyperfine_*_amd64.deb
rm hyperfine_*_amd64.deb

echo "Installing ripgrep"
curl "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" \
 | jq -r '.assets[] | select(.name|test("ripgrep_.*_amd64.deb")) | .browser_download_url' \
 | wget -i -
sudo gdebi ripgrep_*_amd64.deb
rm ripgrep_*_amd64.deb

echo "Installing google chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# pip installs

echo "Installing pip3"
sudo apt install -y python3-pip

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

echo "Installing glances"
# glances web server needs bottle
pip3 install --user glances

echo "Installing powerline"
pip3 install --user powerline-status
# install font
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
mkdir -p ~/.local/share/fonts/
mv PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
# config
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# apt installs

echo "Installing aria2"
sudo apt install -y aria2

echo "Installing asciinema"
sudo apt install -y asciinema

echo "Installing baobab"
sudo apt install -y baobab

echo "Installing browsh?"
#sudo apt install -y browsh?

#echo "Installing byobu"
#sudo apt install -y byobu

echo "Installing chrome"
#sudo apt install -y chrome

echo "Installing cifs"
sudo apt install -y cifs-utils

#echo "Installing emacs"
#sudo apt install -y emacs

echo "Installing exfat-fuse"
sudo apt install -y exfat-fuse

echo "Installing feh (CLI image viewer)"
#sudo apt install -y feh (CLI image viewer)

echo "Installing ffmpeg"
sudo apt install -y ffmpeg ffmpeg-doc

echo "Installing firefox"
sudo apt install -y firefox

echo "Installing Noto font"
sudo apt install -y fonts-noto

echo "Installing gedit + fonts-noto-color-emoji"
#sudo apt install -y gedit + fonts-noto-color-emoji

echo "Installing gnome"
#sudo apt install -y gnome

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

echo "Installing jq"
sudo apt install -y jq

echo "Installing micro"
curl https://getmic.ro | bash
mv micro ~/.local/bin/

echo "Installing midnight Commander?"
#sudo apt install -y midnight Commander?

echo "Installing mosh"
sudo apt install -y mosh

echo "Installing mtr"
sudo apt install -y mtr-tiny

echo "Installing nano"
sudo apt install -y nano

echo "Installing ncdu"
sudo apt install -y ncdu

echo "Installing nfs-server-*"
#sudo apt install -y nfs-server-*

echo "Installing nmap & zenmap / zmap & zdns / masscan"
#sudo apt install -y nmap & zenmap / zmap & zdns / masscan

echo "Installing nmtui"
sudo apt install -y network-manager

echo "Installing ntfs-3g"
sudo apt install -y ntfs-3g

echo "Installing oracle-java8 & java-altrenatives"
#sudo apt install -y oracle-java8 & java-altrenatives

echo "Installing pandoc"
#sudo apt install -y pandoc

echo "Installing p7zip"
sudo apt install -y p7zip p7zip-full p7zip-rar

echo "Installing peco"
sudo apt install -y peco

echo "Installing powershell"
#sudo apt install -y powershell

echo "Installing prettyping"
sudo apt install -y prettyping

echo "Installing ranger"
sudo apt install -y ranger

echo "Installing realpath"
sudo apt install -y coreutils

echo "Installing samba"
sudo apt install -y samba

echo "Installing snlwflake (ssh client)"
#sudo apt install -y snlwflake (ssh client)

echo "Installing socat"
#sudo apt install -y socat

echo "Installing sox (for JJ's speech)"
#sudo apt install -y sox (for JJ's speech)

echo "Installing sshd (openssh-server)"
sudo apt install -y openssh-server

echo "Installing sshfs (sshfs-fuse)"
#sudo apt install -y sshfs (sshfs-fuse)

echo "Installing sshpass"
#sudo apt install -y sshpass

echo "Installing terminalizer"
#sudo apt install -y terminalizer

echo "Installing tesseract (ocr)"
#sudo apt install -y tesseract (ocr)

echo "Installing tldr"
sudo apt install -y tldr
tldr tar

#echo "Installing tmux"
#sudo apt install -y tmux

echo "Installing traceroute"
sudo apt install -y traceroute

echo "Installing tree"
sudo apt install -y tree

echo "Installing uidmap (for rootless docker)"
#sudo apt install -y uidmap (for rootless docker)

echo "Installing unzip"
#sudo apt install -y unzip

#echo "Installing vim"
#sudo apt install -y vim

echo "Installing vlc"
sudo apt install -y vlc

echo "Installing vncserver"
#sudo apt install -y vncserver

echo "Installing wordlists"
sudo apt install -y wamerican wamerican-huge wbritish wbritish-huge

echo "Installing xclock"
sudo apt install -y x11-apps

echo "Installing xfce"
#sudo apt install -y xfce

echo "Installing zcat, zgrep"
sudo apt install -y gzip bzip2 lzip xz-utils
sudo apt install -y zutils

echo "Installing zstd"
sudo apt install -y zstd

echo "Installing shellcheck"
sudo apt install -y shellcheck

echo "Installing locate, updatedb (and findutils)"
sudo apt install -y locate

echo "Installing pv"
#sudo apt install -y pv

echo "Installing unar lsar unp"
#sudo apt install -y unar lsar unp

echo "Installing pglob pkill"
#sudo apt install -y pglob pkill

echo "Installing pigz"
#sudo apt install -y pigz

echo "Installing xclip"
#sudo apt install -y xclip

echo "Installing multitail"
#sudo apt install -y multitail

echo "Installing httpie"
#sudo apt install -y httpie

echo "Installing youtube-dl"
#sudo apt install -y youtube-dl

echo "Installing lnav"
#sudo apt install -y lnav

echo "Installing autojump"
#sudo apt install -y autojump

