#   dotfiles
dotfiles

#   quickstart
##  TL;DR
*   `git clone --depth 1 https://github.com/averykhoo/dotfiles.git ~/dotfiles`
*   `~/dotfiles/setup.sh`
*   (optionally restart your terminal now to get a colored prompt for the next few minutes)
*   `~/dotfiles/install-ubuntu.sh` (Ubuntu 20.04) or `~/dotfiles/install-rhel.sh` (RHEL 8.2)
*   restart terminal

##  RHEL first steps
*   `sudo subscription-manager register`
*   `sudo subscription-manager attach`
*   `sudo yum install -y git`

#   todo
*   is x forwarding enabled
*   maybe symlink the xstartup instead of copying it?
*   make separate install scripts for ubuntu desktop, ubuntu server, rhel server
*   `if [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then echo 'open'; else echo 'not open'; fi`
*   mlocate works in ubuntu?
*   cockpit works in ubuntu?
*   ntfsprogs works in ubuntu?
*   tesseract scripts and language files
*   firefox / chrome extensions
*   vendor in the tldr cache

```bash
# Jupyter password
jupyter notebook --generate-config
jupyter notebook password
```

```bash
# Increase watch limit for pycharm
# https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
# Add the following line to either /etc/sysctl.conf file or a new *.conf file under /etc/sysctl.d/ directory:
touch /etc/sysctl.d/idea.conf
echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.d/idea.conf
# Then run this command to apply the change:
sudo sysctl -p --system
```

```bash
# fix timezone
sudo unlink /etc/localtime 
sudo ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
#sudo date -s "14/08/2019 11:22:33"
#date -u
#date +"%Y-%m-%d %H:%M:%S %z"
#sudo hwclock --systohc --localtime 
```

#   more things you might want to install
*   anaconda3
    *   conda and pip packages
    *   add to path?
    *   jupyter password setup
*   elasticsearch
*   emacs
*   etcd
*   xfce (`sudo apt install xfce4 xfce4-goodies`)
*   pycharm
    *   pycharm plugins
*   terminalizer (like asciinema, but built on npm)
*   vim
*   [wormhole](https://github.com/warner/magic-wormhole)
*   xfce
*   zenmap


#   notes
*   `git update-index --chmod=+x install.sh`
*   [cockpit](https://cockpit-project.org/) will be on port 9090
*   nanorc
    *   from [scopatz/nanorc](https://github.com/scopatz/nanorc)
    *   slightly modified (added all existing `*.nanorc` files, some were missing in provided nanorc)
    *   might need to rename `normal` to `white` in all `.nano/*.nanorc` for older versions of nano
    *   also `set afterends` only works on fairly new versions of nano
