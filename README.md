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
     
##  XFCE
*   `sudo yum group install -y xfce`
*   `sudo apt install -y xfce4 xfce4-goodies`

#   todo
*   is x forwarding enabled
*   maybe symlink the xstartup instead of copying it?
*   tesseract scripts and language files
*   firefox / chrome extensions
*   ```alias hose kill -9 '`ps -augxww | grep \!* | awk \'{print $2}\'`'```
*   `DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"` to get the dir path of a bash script
* 

#   other code references

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

```bash
# Jupyter password
jupyter notebook --generate-config
jupyter notebook password
```

```bash
# change the date
sudo date -s "14/08/2019 11:22:33"
date -u
date +"%Y-%m-%d %H:%M:%S %z"
sudo hwclock --systohc --localtime 
```

```bash
# set default java on RHEL
sudo alternatives --config java
sudo alternatives --config javac
```

```bash
# install XFCE on RHEL
sudo yum group install -y xfce
```

```bash
# ignore ssl errors in git
git config --global http.sslVerify false
```

#   more things you might want to install
*   anaconda3
    *   conda and pip packages
    *   add to path?
    *   jupyter password setup
*   elasticsearch
    *   elasticsearch-plugin install x-pack
*   emacs / vim
*   etcd
*   [XFCE desktop](#xfce)
*   pycharm
    *   pycharm plugins
*   zenmap
*   [VS Code](https://code.visualstudio.com/docs/setup/linux) `snap install code`
*   smbclient
*   partitionmanager
*   catdoc xlhtml ppthtml


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
*   tldr tries very hard to stay updated, if you're offline then disable this
    *   in bashrc, uncomment line 159: `export TLDR_EXPIRY=9999`
*   exa requires glibc 2.18, in rhel 7, don't use this
