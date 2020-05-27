#   dotfiles
dotfiles

#   quickstart
##  TL;DR
*   `git clone --depth 1 https://github.com/averykhoo/dotfiles.git ~/dotfiles`
*   `~/dotfiles/setup.sh`
*   (optionally restart your terminal now to get a colored prompt for the next few seconds)
*   `~/dotfiles/install-ubuntu.sh` (Ubuntu 20.04) or `~/dotfiles/install-rhel.sh` (RHEL 8.2)
*   restart terminal

##  RHEL first steps
*   `sudo subscription-manager register`
*   `sudo subscription-manager attach`
*   `sudo yum install -y git`
*   to set up local repo from the RHEL 8 DVD
    *   you will need at least 8.5GB of space for this, and another temporary 8.5GB for the iso
    *   copy in the iso as `rhel-8.2-x86_64-dvd.iso`, and run the `rhel-dvd-repo.sh` from that directory
    *   alternatively if you don't have an extra 8.5GB temp space, insert the DVD and run `rhel-dvd-repo.sh`, but this will likely be much slower
     
##  XFCE
*   `sudo yum group install -y xfce`
*   `sudo apt install -y xfce4 xfce4-goodies`

#   todo
*   is x forwarding enabled
*   maybe symlink the xstartup instead of copying it?
*   make separate install scripts for ubuntu desktop, ubuntu server, rhel server
*   tesseract scripts and language files
*   firefox / chrome extensions

#   other code references

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
*   lesspipe
    *   https://superuser.com/questions/117841/when-reading-a-file-with-less-or-more-how-can-i-get-the-content-in-colors/337640#337640
    *   https://github.com/suriya/dot-files/blob/master/lessfilter
    *   https://github.com/wofr06/lesspipe
        *   lynx
        *   LibreOffice
        *   pdftotext
        *   mediainfo
        *   exiftool
        *   brotli
        *   lzma
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
*   [wormhole](https://github.com/warner/magic-wormhole)
*   zenmap
*   treeview vs tree?
*   [VS Code](https://code.visualstudio.com/docs/setup/linux) `snap install code`
*   smbclient
*   partitionmanager
*   ntp
*   fonts-twemoji-svginot
*   catdoc xlhtml ppthtml
*   system-config-lvm




#   notes
*   `git update-index --chmod=+x install.sh`
*   [cockpit](https://cockpit-project.org/) will be on port 9090
*   nanorc
    *   from [scopatz/nanorc](https://github.com/scopatz/nanorc)
    *   slightly modified (added all existing `*.nanorc` files, some were missing in provided nanorc)
    *   might need to rename `normal` to `white` in all `.nano/*.nanorc` for older versions of nano
    *   also `set afterends` only works on fairly new versions of nano
