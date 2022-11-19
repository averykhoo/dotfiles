#!/usr/bin/env bash

# we need sudo permissions

sudo echo "installing all the things"

# is apt available?
if [[ ! -x "$(command -v apt)" ]]; then
  echo "ERROR: apt not found, wrong os?" >>/dev/stderr
  exit 1
fi

# update apt
echo "updating apt"
sudo apt update

# cleanup MOTD
[[ ! -d /etc/update-motd.d.bak/ ]] &&                  sudo mkdir /etc/update-motd.d.bak/
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

function install-local-bin() {
  local src_path
  local dst_name
  local dst_path

  # if called with zero arguments, print help
  if [[ $# -eq 0 ]]; then
    echo 'ERROR: no argument given to "install-local-bin" function'
    return 1
  fi

  # if called with more than 2 arguments, print help
  if [[ $# -gt 2 ]]; then
    echo 'ERROR: too many arguments given to "install-local-bin" function'
    return 1
  fi

  # handle missing input executable
  src_path="$1"
  if [[ ! -f "${src_path}" ]]; then
    echo "ERROR: source executable missing: ${src_path}"
    return 1
  fi

  # if provided, the second argument is the destination filename
  # make sure it does not contain any slashes
  if [[ $# -eq 2 ]]; then
    dst_name="$2"
    if [[ "${dst_name}" == *"/"* ]]; then
      echo "ERROR: destination filename cannot contain slashes: ${dst_name}"
      return 1
    fi
  else
    dst_name="$(basename "${src_path}")"
  fi

  # the directory will always be ~/.local/bin
  dst_path=~/.local/bin/"${dst_name}"

  # remove destination executable if it exists
  if [[ -f "${dst_path}" ]]; then
    echo "INFO: removing existing target executable: ${dst_path}"
    rm -f "${dst_path}"
  fi

  # install the executable if it is not already a command
  if [[ ! -x "$(command -v "${dst_path}")" ]]; then
    echo "INFO: installing executable: ${src_path} -> ${dst_path}"
    #install -m 755 "${src_path}" "${dst_path}"
    cp "${src_path}" "${dst_path}"
    chmod +x "${dst_path}"
  fi
}

echo "Installing '$' ignorer"
install-local-bin ~/.dotfiles/vendored/__dollar_sign__ '$'

echo "Installing '=' math convenience function"
install-local-bin ~/.dotfiles/vendored/__equals__ '='

echo "Installing backup.sh"
install-local-bin ~/.dotfiles/vendored/backup.sh bak

echo "Installing bat"
install-local-bin ~/.dotfiles/vendored/bat-*-x86_64-unknown-linux-musl/bat
cp ~/.dotfiles/vendored/bat-*-x86_64-unknown-linux-musl/bat.1 ~/.local/share/man/man1/bat.1

echo "Installing bat-extras"
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/bat-modules
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/batdiff
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/batgrep
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/batman
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/batpipe
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/batwatch
install-local-bin ~/.dotfiles/vendored/bat-extras-*/bin/prettybat
cp ~/.dotfiles/vendored/bat-extras-*/man/batdiff.1 ~/.local/share/man/man1/batdiff.1
cp ~/.dotfiles/vendored/bat-extras-*/man/batgrep.1 ~/.local/share/man/man1/batgrep.1
cp ~/.dotfiles/vendored/bat-extras-*/man/batman.1 ~/.local/share/man/man1/batman.1
cp ~/.dotfiles/vendored/bat-extras-*/man/batpipe.1 ~/.local/share/man/man1/batpipe.1
cp ~/.dotfiles/vendored/bat-extras-*/man/batwatch.1 ~/.local/share/man/man1/batwatch.1
cp ~/.dotfiles/vendored/bat-extras-*/man/prettybat.1 ~/.local/share/man/man1/prettybat.1

echo "Installing delta"
install-local-bin ~/.dotfiles/vendored/delta-*-x86_64-unknown-linux-musl/delta

echo "Installing dog"
install-local-bin ~/.dotfiles/vendored/dog-*-x86_64-unknown-linux-musl/bin/dog
cp ~/.dotfiles/vendored/dog-*-x86_64-unknown-linux-musl/man/dog.1 ~/.local/share/man/man1/dog.1

echo "Installing duf"
install-local-bin ~/.dotfiles/vendored/duf_*_linux_x86_64/duf

echo "Installing exa"
install-local-bin ~/.dotfiles/vendored/exa-linux-x86_64-*/bin/exa
cp ~/.dotfiles/vendored/exa-linux-x86_64-*/man/exa.1 ~/.local/share/man/man1/exa.1

echo "Installing fd"
install-local-bin ~/.dotfiles/vendored/fd-*-x86_64-unknown-linux-musl/fd
cp ~/.dotfiles/vendored/fd-*-x86_64-unknown-linux-musl/fd.1 ~/.local/share/man/man1/fd.1

if [[ ! -d ~/.fzf ]]; then
  echo "Installing fzf"
  # git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  tar -xf ~/.dotfiles/vendored/fzf-*.tar -C ~
  [[ -x "$(command -v git)" ]] && git -C ~/.fzf/ pull
  ~/.fzf/install --all
fi

#echo "Installing helm"
#install-local-bin ~/.dotfiles/vendored/helm-*-linux-amd64/helm

echo "Installing hexyl"
install-local-bin ~/.dotfiles/vendored/hexyl-*-x86_64-unknown-linux-musl/hexyl

if [[ ! -x "$(command -v htop)" ]]; then
  echo "Installing htop"
  #sudo apt install -y htop
  sudo gdebi --non-interactive ~/.dotfiles/vendored/htop/htop_3.0.2-1_amd64.deb
fi

#echo "Installing httpie"
#install-local-bin ~/.dotfiles/vendored/httpie-*/http

echo "Installing hyperfine"
install-local-bin ~/.dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/hyperfine
cp ~/.dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/hyperfine.1 ~/.local/share/man/man1/hyperfine.1

if [[ ! -f /etc/sysctl.d/jetbrains_watch_limit.conf ]]; then
  echo "Increase inotify watch limit for pycharm"
  sudo cp ~/.dotfiles/vendored/jetbrains_watch_limit.conf /etc/sysctl.d/jetbrains_watch_limit.conf
  sudo sysctl -p --system
fi

rm -f /usr/local/share/fonts/iosevka-*.ttf
echo "Installing Iosevka font"
sudo cp ~/.dotfiles/vendored/iosevka-*/iosevka-*.ttf /usr/local/share/fonts

echo "Installing jq"
install-local-bin ~/.dotfiles/vendored/jq_*/jq-linux64 jq

#echo "Installing k9s"
#install-local-bin ~/.dotfiles/vendored/k9s_Linux_x86_64_*/k9s

#echo "Installing kubectl"
#install-local-bin ~/.dotfiles/vendored/kubectl-dl.k8s.io-release-*-bin-linux-amd64/kubectl

echo "Installing kubecolor"
install-local-bin ~/.dotfiles/vendored/kubecolor_*_Linux_x86_64/kubecolor

echo "Installing micro"
install-local-bin ~/.dotfiles/vendored/micro-*-linux64-static/micro
cp ~/.dotfiles/vendored/micro-*-linux64-static/micro.1 ~/.local/share/man/man1/micro.1

#if [[ ! -x "$(command -v osquery)" ]]; then
#    echo "Installing osquery"
#    sudo gdebi --non-interactive ~/.dotfiles/vendored/osquery/osquery_4.9.0-1.linux_amd64.deb
#fi

#echo "Installing pandoc"
#install-local-bin ~/.dotfiles/vendored/pandoc-*-linux-amd64/bin/pandoc

echo "Installing pipes.sh"
install-local-bin ~/.dotfiles/vendored/pipes.sh-master-*/pipes.sh
cp ~/.dotfiles/vendored/pipes.sh-master-*/pipes.sh.6 ~/.local/share/man/man1/pipes.sh.6

if [[ ! -f ~/.local/share/fonts/PowerlineSymbols.otf ]]; then
  echo "Installing powerline font"
  mkdir --parents ~/.local/share/fonts/
  cp ~/.dotfiles/vendored/powerline-raw-develop-font-*/PowerlineSymbols.otf ~/.local/share/fonts/
  fc-cache -vf ~/.local/share/fonts/
fi

if [[ ! -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]]; then
  echo "Installing powerline fontconfig"
  mkdir --parents ~/.config/fontconfig/conf.d/
  cp ~/.dotfiles/vendored/powerline-raw-develop-font-*/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
else
  echo "already installed"
fi

echo "Installing ripgrep"
install-local-bin ~/.dotfiles/vendored/ripgrep-*-x86_64-unknown-linux-musl/rg
cp ~/.dotfiles/vendored/ripgrep-*-x86_64-unknown-linux-musl/doc/rg.1 ~/.local/share/man/man1/rg.1

rm -f ~/.local/bin/safe-rm
sudo rm -f /usr/bin/safe-rm
if [[ ! -x "$(command -v safe-rm)" ]]; then
  echo "Installing safe-rm"
  # cp ~/.dotfiles/vendored/safe-rm-*/safe-rm ~/.local/bin/safe-rm
  # cp ~/.dotfiles/vendored/safe-rm-*/safe-rm.conf ~/.config/safe-rm
  # sudo chmod a+x ~/.local/bin/safe-rm
  sudo cp ~/.dotfiles/vendored/safe-rm-*/safe-rm /usr/bin/safe-rm
  sudo cp ~/.dotfiles/vendored/safe-rm-*/safe-rm.conf /usr/local/etc/safe-rm.conf
  sudo chmod 755 /usr/bin/safe-rm
  sudo chmod 644 /usr/local/etc/safe-rm.conf
fi

echo "Installing sd"
install-local-bin ~/.dotfiles/vendored/sd-*-x86_64-unknown-linux-musl/sd

echo "Installing shellcheck"
install-local-bin ~/.dotfiles/vendored/shellcheck-*.linux.x86_64/shellcheck

echo "Installing shfmt"
install-local-bin ~/.dotfiles/vendored/shfmt_*_linux_amd64/shfmt

rm -f ~/.local/bin/tldr
echo "Installing tldr"
install-local-bin ~/.dotfiles/vendored/pepa65-tldr-bash-client-*/tldr
install-local-bin ~/.dotfiles/vendored/pepa65-tldr-bash-client-*/tldr-lint
[[ ! -d ~/.local/share/tldr ]] && tar -xf ~/.dotfiles/vendored/pepa65-tldr-bash-client-*/tldr.tar -C ~/.local/share/

echo "Configuring xstartup"
[[ -d ~/.vnc ]] || mkdir ~/.vnc
[[ -f ~/.vnc/xstartup ]] && mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
if [[ -x "$(command -v gnome-session)" ]]; then
  cp ~/.dotfiles/vendored/xstartup_gnome ~/.vnc/xstartup
elif [[ -x "$(command -v startxfce4)" ]]; then
  cp ~/.dotfiles/vendored/xstartup_xfce ~/.vnc/xstartup
else
  echo "no GUI found, copying XFCE-based xstartup"
  cp ~/.dotfiles/vendored/xstartup_xfce ~/.vnc/xstartup
  #echo "DO YOU WANT TO INSTALL XFCE?"
  #sudo apt install xfce4 xfce4-goodies
fi
sudo chmod a+x ~/.vnc/xstartup
sudo chmod a+r ~/.vnc/xstartup

#echo "Installing xsv"
#install-local-bin ~/.dotfiles/vendored/xsv-*-x86_64-unknown-linux-musl/xsv

# pip installs

echo "Installing pip3"
sudo apt install -y python3-pip

if [[ ! -x "$(command -v ad)" ]]; then
  echo "Installing ad"
  pip3 install --user advance-touch
fi

#if [[ ! -x "$(command -v csvgrep)" ]]; then
#    echo "Installing csvkit"
#    pip3 install --user csvkit
#fi

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
#    if ls browsh_*_linux_amd64.deb 1> /dev/null 2>&1; then
#        echo "found installer"
#    else
#        curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
#         | jq_v1.6 -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.deb")) | .browser_download_url' \
#         | wget -i -
#    fi
#    sudo gdebi --non-interactive browsh_*_linux_amd64.deb
#    rm browsh_*_linux_amd64.deb
#else
#    echo "already installed"
#fi

#echo "Installing chrome"
#if [[ ! -x "$(command -v google-chrome)" ]]; then
#    if ls google-chrome-stable_current_amd64.deb 1> /dev/null 2>&1; then
#        echo "found installer"
#    else
#        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#    fi
#    sudo gdebi --non-interactive google-chrome-stable_current_amd64.deb
#    rm google-chrome-stable_current_amd64.deb
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
#    sudo cp ~/.dotfiles/vendored/vncserver /usr/bin/
#    sudo chmod a+x /usr/bin/vncserver
#fi

# apt installs

echo "Installing aria2"
sudo apt install -y aria2

echo "Installing atop"
sudo apt install -y atop

echo "Installing asciinema"
sudo apt install -y asciinema

echo "Installing autojump"
sudo apt install -y autojump

#echo "Installing byobu"
#sudo apt install -y byobu

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

echo "Installing dos2unix"
sudo apt install -y dos2unix

echo "Installing exfat-fuse"
sudo apt install -y exfat-fuse

echo "Installing ffmpeg"
sudo apt install -y ffmpeg ffmpeg-doc

#echo "Installing firefox"
#sudo apt install -y firefox

#echo "Installing Noto font"
#sudo apt install -y fonts-noto

#echo "Installing gparted"
#sudo apt install -y gparted

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

echo "Installing less"
sudo apt install -y less

echo "Installing locate, updatedb (and findutils)"
sudo apt install -y mlocate

echo "Installing lnav"
sudo apt install -y lnav

echo "Installing lsof"
sudo apt install -y lsof

echo "Installing mosh"
sudo apt install -y mosh
[[ -x "$(command -v ufw)" ]] && [[ $(sudo ufw app list) == *mosh* ]] && sudo ufw allow mosh

echo "Installing mtr"
sudo apt install -y mtr-tiny

echo "Installing nano"
sudo apt install -y nano

echo "Installing ncdu"
sudo apt install -y ncdu

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

echo "Installing pexec"
sudo apt install -y pexec

echo "Installing pglob, pkill"
sudo apt install -y procps

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

echo "Installing socat"
sudo apt install -y socat

echo "Installing sox"
sudo apt install -y sox

echo "Installing sshd (openssh-server)"
sudo apt install -y openssh-server
[[ -x "$(command -v ufw)" ]] && [[ $(sudo ufw app list) == *OpenSSH* ]] && sudo ufw allow OpenSSH

echo "Installing sshfs"
sudo apt install -y sshfs

echo "Installing sshpass"
sudo apt install -y sshpass

#echo "Installing tmux"
#sudo apt install -y tmux

echo "Installing traceroute"
sudo apt install -y traceroute

echo "Installing tree"
sudo apt install -y tree

#echo "Installing update-java-alternatives"
#sudo apt install -y java-common

#echo "Installing wordlists"
#sudo apt install -y wamerican wamerican-huge wbritish wbritish-huge

#echo "Installing xclip"
#sudo apt install -y xclip

#echo "Installing xclock"
#sudo apt install -y x11-apps

echo "Installing zcat, zgrep (wrapper)"
sudo apt install -y zutils
