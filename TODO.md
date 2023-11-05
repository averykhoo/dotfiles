# todo

* use `pipx` instead to install stuff in the `install_*.sh`
  * also look into `frogmouth` to render markdown files
* more shortcuts
  * https://github.com/onceupon/Bash-Oneliner
  * prepend / append line into file but take newlines into account
  * how to change or remove password expiry and complexity requirements
  * disable powerline by default, enable with shortcut / alias
  * BUGFIX: nc -> command not found [in here, line 14](install-rhel.sh)
* refactoring
  * split out the vendored stuff
  * create `offline-install-*.sh` that's called from the main `install-*.sh`
* list sources
  * scopatz/nanorc
  * pepa65/tldr
  * ...
* things to check
  * is x forwarding enabled
* gui tweaks
  * set iosevka as terminal font
  * set terminal opacity to 90%
  * ~~firefox / chrome extensions~~
* others
  * maybe symlink the xstartup instead of copying it?
  * create a folder for utility scripts and mount it to local bin
* add lists
  * Windows setup from OneNote (as markdown)
  * PyCharm plugins from OneNote
  * Python packages from OneNote
  * MobaXterm setup steps / ini file
    * bell sound
    * ssh keepalive
    * password manager
    * ssh key?
    * default font
* better aliasing, don't just use alias
  * https://unix.stackexchange.com/questions/125819/bash-function-decorator
  * Intelligently check if output is pipe and default to unaliased
  * https://stackoverflow.com/questions/911168/how-can-i-detect-if-my-shell-script-is-running-through-a-pipe
  * https://askubuntu.com/a/98791

# more to install

* [ratarmount](https://github.com/mxmlnkn/ratarmount)
* `telnet`
* [sshuttle](https://github.com/sshuttle/sshuttle)
* [viddy](https://github.com/sachaos/viddy)
* maybe dust instead of ncdu
* maye duf instead of pydf
* alias time to hyperfine?
* maybe procs aliased to ps
* maybe curlie / ~~httpie (too big)~~ / xh / hurl / httpx
* maybe gtop
* maybe zoxide instead of autojump
* maybe dog aliased to dig
* maybe [miller](https://github.com/johnkerl/miller)
* test [neofetch](https://github.com/dylanaraps/neofetch) with mobaxterm (imgcat too)
* baobab (requires gdm3 and gnome desktop)
* gedit (requires gdm3 and gnome desktop)
* gufw (ubuntu-only, requires gdm3 and gnome desktop)
* vlc (ubuntu-only, requires gdm3 and gnome desktop)
* [python](#set-up-python) packages
* [XFCE desktop](#xfce)
* elasticsearch
  * elasticsearch-plugin install x-pack
* ~~emacs / vim~~
* ~~etcd~~
* pycharm (`tar -xzf pycharm-*.tar.gz`)
  * pycharm plugins
  * create shortcut at `~/.local/bin/charm`
* ~~zenmap~~
* [VS Code](https://code.visualstudio.com/docs/setup/linux)
  `snap install code`
* ~~smbclient~~
* ~~partitionmanager~~
* [lsix](https://github.com/hackerb9/lsix)
  (requires a sixel-compatible terminal)
* [tiv](https://github.com/stefanhaustein/TerminalImageViewer)
  `snap install --edge tiv`
* [hyperscan](https://www.hyperscan.io/downloads/)
  * [python-hyperscan](https://python-hyperscan.readthedocs.io/en/latest/)
* [gron](https://github.com/tomnomnom/gron)
* tesseract scripts (and language files)

# too big to install

* xsv
* helm
* httpie
* k9s
* kubectl
* osquery
* pandoc
* kube-lineage
