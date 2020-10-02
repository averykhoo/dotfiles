#   dotfiles
dotfiles

#   quickstart
##  TL;DR
*   `git clone --depth 1 https://github.com/averykhoo/dotfiles.git ~/dotfiles`
*   `~/dotfiles/setup.sh`
*   `~/dotfiles/install-ubuntu.sh` (Ubuntu 20.04) or `~/dotfiles/install-rhel.sh` (RHEL 8.2)
*   restart terminal

##  RHEL first steps
*   `sudo subscription-manager register`
*   `sudo subscription-manager attach`
*   `sudo yum install -y git`
*   to set up local repo from the [RHEL 8.2 DVD](https://developers.redhat.com/download-manager/file/rhel-8.2-x86_64-dvd.iso)
    *   you will need at least 8.5GB of space for this, and another temporary 8.5GB for the iso
    *   copy in the iso as `rhel-8.2-x86_64-dvd.iso`, and run the `rhel-dvd-repo.sh` from that directory
    *   alternatively if you don't have an extra 8.5GB temp space, insert the DVD and run `rhel-dvd-repo.sh`, but this will likely be much slower
    *   any other version of RHEL -> update the sha256 and .repo file accordingly
        *   actual download path contains the sha256, e.g. `https://access.cdn.redhat.com/content/origin/files/sha256/7f/7fdfed9c7cced4e526a362e64ed06bcdc6ce0394a98625a40e7d05db29bf7b86/rhel-8.2-x86_64-dvd.iso`
*   `sudo yum remove -y insights-client`

##  Xubuntu first steps
*   `sudo apt install -y openssh-server git`
* 

##  XFCE
*   (RHEL) `sudo yum group install -y xfce`
*   (Ubuntu) `sudo apt install -y xfce4 xfce4-goodies`

#   todo
*   download-only script, modify install script to check for downloads
*   is x forwarding enabled
*   set iosevka as terminal font
*   set terminal opacity to 90%
*   maybe symlink the xstartup instead of copying it?
*   firefox / chrome extensions
*   ```alias hose kill -9 '`ps -augxww | grep \!* | awk \'{print $2}\'`'```


#   bash references

##  set up python
```bash
# install anaconda python
wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
chmod +x Anaconda3-*-Linux-x86_64.sh
./Anaconda3-*-Linux-x86_64.sh
rm Anaconda3-*-Linux-x86_64.sh

# commit the changed bashrc (otherwise it's impossible to git pull)
git add ~/dotfiles/.bashrc
git commit -m "installed anaconda"

# Jupyter password
jupyter notebook --generate-config
jupyter notebook password

# no ssl
conda config --set ssl_verify false

# OPTIONAL: add conda-forge as a default repo
conda config --add channels conda-forge

# nbextensions
conda install -c conda-forge jupyter_contrib_nbextensions

# start notebook
jupyter notebook --ip=0.0.0.0 --no-browser --allow-root

# uninstall
conda install anaconda-clean
anaconda-clean --yes
rm -rf ~/anaconda3

# reset bashrc
git fetch origin
git reset --hard origin/master
git clean -fdx
```

##  change the date
```bash
# change the date
sudo date -s "14/08/2019 11:22:33"
date -u
date +"%Y-%m-%d %H:%M:%S %z"
sudo hwclock --systohc --localtime 
```

##  java-alternatives (shouldn't be needed)
```bash
# set default java on RHEL
sudo alternatives --config java
sudo alternatives --config javac
```

##  git no ssl
```bash
# ignore ssl errors in git
git config --global http.sslVerify false
export GIT_SSL_NO_VERIFY=true
```

##  find parent for bash script
Minimal one-liner: `DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"`
```bash
# get parent directory abspath for a bash script, resolving symlinks recursively
# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
```

#   more things you might want to install
*   baobab (requires gdm3 and gnome desktop)
*   gedit (requires gdm3 and gnome desktop)
*   gufw (ubuntu-only, requires gdm3 and gnome desktop)
*   vlc (ubuntu-only, requires gdm3 and gnome desktop)
*   [python](#set-up-python) packages
*   [XFCE desktop](#xfce)
*   elasticsearch
    *   elasticsearch-plugin install x-pack
*   emacs / vim
*   etcd
*   pycharm (`tar -xzf pycharm-*.tar.gz`)
    *   pycharm plugins
    *   create shortcut at `~/.local/bin/charm`
*   zenmap
*   [VS Code](https://code.visualstudio.com/docs/setup/linux)
    `snap install code`
*   smbclient
*   partitionmanager
*   [lsix](https://github.com/hackerb9/lsix)
    (requires a sixel-compatible terminal)
*   [tiv](https://github.com/stefanhaustein/TerminalImageViewer)
    `snap install --edge tiv`
*   [hyperscan](https://www.hyperscan.io/downloads/)
    *   [python-hyperscan](https://python-hyperscan.readthedocs.io/en/latest/)
*   [gron](https://github.com/tomnomnom/gron)
*   tesseract scripts (and language files)


#   notes
*   `git update-index --chmod=+x something.sh`
*   [cockpit](https://cockpit-project.org/) will be on port 9090
*   nanorc from [scopatz/nanorc](https://github.com/scopatz/nanorc)
    *   for legacy nano versions, use the legacy nanorc and nano dir
        *   `cd ~`
        *   `rm .nanorc`
        *   `rm .nano`
        *   `ln -s dotfiles/.nanorc-legacy .nanorc`
        *   `ln -s dotfiles/.nano-legacy .nano`
*   tldr tries very hard to stay updated, but i've disabled this, if you're online then *either*
    *   in bashrc, comment line 159: `export TLDR_EXPIRY=9999`
    *   *or* run `tldr --update` to update

