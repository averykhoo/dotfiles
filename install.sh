#!/usr/bin/env bash

# git installs

echo "Installing git & git-lfs"
sudo apt install -y git git-lfs

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# bundled installs

echo "Installing bat"
sudo dpkg -i ./install/bat-musl_0.15.1_amd64.deb

echo "Installing delta"
sudo dpkg -i ./install/git-delta-musl_0.1.1_amd64.deb

echo "Installing exa"
sudo cp ./install/exa-linux-x86_64 ~/.local/bin/exa
sudo chmod +x ~/.local/bin/exa

echo "Installing '$' ignorer"
sudo cp './install/$' ~/.local/bin/'$'
sudo chmod +x ~/.local/bin/'$'

echo "Installing fd"
sudo dpkg -i ./install/fd-musl_8.0.0_amd64.deb

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

echo "Installing glances"
# glances web server needs bottle
pip3 install --user glances

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

echo "Installing curl"
sudo apt install -y curl

#echo "Installing emacs"
#sudo apt install -y emacs

echo "Installing exfat-fuse"
sudo apt install -y exfat-fuse

echo "Installing feh (CLI image viewer)"
#sudo apt install -y feh (CLI image viewer)

echo "Installing ffmpeg"
#sudo apt install -y ffmpeg

echo "Installing firefox"
sudo apt install -y firefox

echo "Installing Noto font"
#sudo apt install -y fonts-noto

echo "Installing gedit + fonts-noto-color-emoji"
#sudo apt install -y gedit + fonts-noto-color-emoji

echo "Installing gnome"
#sudo apt install -y gnome

echo "Installing gparted"
#sudo apt install -y gparted

echo "Installing gufw?"
#sudo apt install -y gufw?

echo "Installing hexyl? (Sharkdp) (hex viewer)"
#sudo apt install -y hexyl? (Sharkdp) (hex viewer)

echo "Installing htop"
sudo apt install -y htop

echo "Installing httpie"
sudo apt install -y httpie

echo "Installing ifconfig (net-tools)"
#sudo apt install -y ifconfig (net-tools)

echo "Installing jq"
#sudo apt install -y jq

echo "Installing micro?"
#sudo apt install -y micro?

echo "Installing midnight Commander?"
#sudo apt install -y midnight Commander?

echo "Installing mosh?"
#sudo apt install -y mosh?

echo "Installing mtr (better traceroute)"
#sudo apt install -y mtr (better traceroute)

echo "Installing nano"
#sudo apt install -y nano

echo "Installing ncdu"
#sudo apt install -y ncdu

echo "Installing nfs-server-*"
#sudo apt install -y nfs-server-*

echo "Installing nmap & zenmap / zmap & zdns / masscan"
#sudo apt install -y nmap & zenmap / zmap & zdns / masscan

echo "Installing nmtui"
#sudo apt install -y nmtui

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

echo "Installing powerline"
#sudo apt install -y powerline

echo "Installing powershell"
#sudo apt install -y powershell

echo "Installing prettyping"
#sudo apt install -y prettyping

echo "Installing pydf"
#sudo apt install -y pydf

echo "Installing ranger"
#sudo apt install -y ranger

echo "Installing realpath? Alias pwd?"
#sudo apt install -y realpath? Alias pwd?

echo "Installing ripgrep"
#sudo apt install -y ripgrep

echo "Installing samba"
#sudo apt install -y samba

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
sudo apt install tldr
tldr tar

#echo "Installing tmux"
#sudo apt install -y tmux

echo "Installing tree (prefer exa tree?)"
#sudo apt install -y tree (prefer exa tree?)

echo "Installing ufw"
#sudo apt install -y ufw

echo "Installing uidmap (for rootless docker)"
#sudo apt install -y uidmap (for rootless docker)

echo "Installing unzip"
#sudo apt install -y unzip

echo "Installing vim"
#sudo apt install -y vim

echo "Installing vlc"
#sudo apt install -y vlc

echo "Installing vncserver"
#sudo apt install -y vncserver

echo "Installing wordlist"
#sudo apt install -y wordlist

echo "Installing xclock"
#sudo apt install -y xclock

echo "Installing xfce"
#sudo apt install -y xfce

echo "Installing xsv?"
#sudo apt install -y xsv?

echo "Installing zcat"
#sudo apt install -y zcat

echo "Installing zgrep"
#sudo apt install -y zgrep

echo "Installing zstd"
#sudo apt install -y zstd


echo "Installing shellcheck"
#sudo apt install -y shellcheck

echo "Installing locate, updatedb?"
#sudo apt install -y locate, updatedb?

echo "Installing hyperfine (sharkdp)"
#sudo apt install -y hyperfine (sharkdp)

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

