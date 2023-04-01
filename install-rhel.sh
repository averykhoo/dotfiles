#!/usr/bin/env bash

# we need sudo permissions

sudo echo "installing all the things"

# is yum available?
if [[ ! -x "$(command -v yum)" ]]; then
  echo "ERROR: yum not found, wrong os?" >>/dev/stderr
  exit 1
fi

# try to install these if we have internet access
if nc -zw1 dl.fedoraproject.org 443; then
  # add EPEL for RHEL 7
  if [[ $(uname -r) == *el7* ]]; then
    sudo echo "adding EPEL 7 repo"
    if [[ $(rpm -qa) != *epel-release* ]]; then
      sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
      sudo yum update
    else
      echo 'already added'
    fi
  fi

  # add extended repo for more packages
  if [[ $(uname -r) == *el8* ]]; then
    sudo echo "adding EPEL 8 repo"
    if [[ $(rpm -qa) != *epel-release* ]]; then
      sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
      ARCH=$(/bin/arch)
      sudo subscription-manager repos --enable "codeready-builder-for-rhel-8-${ARCH}-rpms"
      unset ARCH
      # sudo dnf config-manager --set-enabled PowerTools
      sudo yum update
    else
      echo 'already added'
    fi
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

#echo "Installing snap"
#sudo yum install -y snapd
#sudo systemctl enable --now snapd

echo "Installing wget"
sudo yum install -y wget

# vendored installs

[[ -d /usr/local/share/fonts ]] || sudo mkdir --parents /usr/local/share/fonts
[[ -d ~/.local/bin/ ]] || mkdir --parents ~/.local/bin/
[[ -d ~/.local/share/man/man1/ ]] || mkdir --parents ~/.local/share/man/man1/
[[ -d ~/.local/share/bash-completion/ ]] || mkdir --parents ~/.local/share/bash-completion/

# helper function to "install" executables to ~/.local/bin/
# optionally also renames the executable if a filename is provided
# approximately equivalent to `install -m 755 "${src_path}" "${dst_path}"`
# usage:
# > install-local-bin [path/to/exe]
# > install-local-bin [path/to/exe] [new_filename]
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
cp ~/.dotfiles/vendored/bat-*-x86_64-unknown-linux-musl/autocomplete/bat.bash ~/.local/share/bash-completion/bat.bash

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
cp ~/.dotfiles/vendored/dog-*-x86_64-unknown-linux-musl/completions/dog.bash ~/.local/share/bash-completion/dog.bash

echo "Installing duf"
install-local-bin ~/.dotfiles/vendored/duf_*_linux_x86_64/duf

echo "Installing exa"
install-local-bin ~/.dotfiles/vendored/exa-linux-x86_64-*/bin/exa
cp ~/.dotfiles/vendored/exa-linux-x86_64-*/man/exa.1 ~/.local/share/man/man1/exa.1
cp ~/.dotfiles/vendored/exa-linux-x86_64-*/man/exa_colors.5 ~/.local/share/man/man1/exa_colors.5
cp ~/.dotfiles/vendored/exa-linux-x86_64-*/completions/exa.bash ~/.local/share/bash-completion/exa.bash

echo "Installing fd"
install-local-bin ~/.dotfiles/vendored/fd-*-x86_64-unknown-linux-musl/fd
cp ~/.dotfiles/vendored/fd-*-x86_64-unknown-linux-musl/fd.1 ~/.local/share/man/man1/fd.1
cp ~/.dotfiles/vendored/exa-linux-x86_64-*/autocomplete/fd.bash ~/.local/share/bash-completion/fd.bash

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
  #sudo yum install -y htop
  if [[ $(uname -r) == *el7* ]]; then
    yum install -y ~/.dotfiles/vendored/htop/htop-2.2.0-3.el7.x86_64.rpm
  else
    yum install -y ~/.dotfiles/vendored/htop/htop-2.2.0-6.el8.x86_64.rpm
  fi
fi

#echo "Installing httpie"
#install-local-bin ~/.dotfiles/vendored/httpie-*/http

echo "Installing hyperfine"
install-local-bin ~/.dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/hyperfine
cp ~/.dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/hyperfine.1 ~/.local/share/man/man1/hyperfine.1
cp ~/.dotfiles/vendored/hyperfine-*-x86_64-unknown-linux-musl/autocomplete/hyperfine.bash-completion ~/.local/share/bash-completion/hyperfine.bash-completion

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

#if [[ ! -x "$(command -v osqueryi)" ]]; then
#    echo "Installing osquery"
#    yum install -y ~/.dotfiles/vendored/osquery/osquery-4.9.0-1.linux.x86_64.rpm
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
cp ~/.dotfiles/vendored/ripgrep-*-x86_64-unknown-linux-musl/complete/rg.bash ~/.local/share/bash-completion/rg.bash

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
  #sudo yum group install xfce
fi
sudo chmod a+x ~/.vnc/xstartup
sudo chmod a+r ~/.vnc/xstartup

#echo "Installing xsv"
#install-local-bin ~/.dotfiles/vendored/xsv-*-x86_64-unknown-linux-musl/xsv

# pip installs

echo "Installing pip3"
sudo yum install -y python3-pip

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
#    sudo cp ~/.dotfiles/vendored/vncserver /usr/bin/
#    sudo chmod a+x /usr/bin/vncserver
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

echo "Installing bash-completion"
sudo yum install -y bash-completion

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

echo "Installing moreutils"
sudo yum install -y moreutils

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
