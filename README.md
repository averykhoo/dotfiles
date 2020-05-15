#   dotfiles
dotfiles

#   quickstart
*   `git clone --depth 1 https://github.com/averykhoo/dotfiles.git ~/dotfiles`
*   `~/dotfiles/setup.sh`
*   `~/dotfiles/install-ubuntu.sh` (tested on ubuntu 20.04, both desktop and server)

#   todo
*   `sudo subscription-manager register`
*   `sudo subscription-manager attach`
*   is x forwarding enabled
*   maybe symlink the xstartup instead of copying it?
*   does the stuff below need to be a checklist
*   make separate install scripts for ubuntu desktop, ubuntu server, rhel server

#   more things you might want to install
*   [ ] anaconda3
*   [ ] [cockpit](https://cockpit-project.org/)
*   [ ] elasticsearch
*   [ ] emacs
*   [ ] etcd
*   [ ] gnome
*   [ ] pycharm
*   [ ] terminalizer (like asciinema, but built on npm)
*   [ ] vim
*   [ ] [wormhole](https://github.com/warner/magic-wormhole)
*   [ ] xfce
*   [ ] zenmap


#   notes
*   `git update-index --chmod=+x install.sh`
*   nanorc
    *   from [scopatz/nanorc](https://github.com/scopatz/nanorc)
    *   slightly modified (added all existing `*.nanorc` files, some were missing in provided nanorc)
    *   might need to rename `normal` to `white` in all `.nano/*.nanorc` for older versions of nano
    *   also `set afterends` only works on fairly new versions of nano
