#   dotfiles
dotfiles


#   quickstart
##  TL;DR
*   `git clone --depth 1 https://github.com/averykhoo/dotfiles.git ~/dotfiles`
    *   or `git -c http.sslVerify=false clone --depth 1 https://github.com/averykhoo/dotfiles.git ~/dotfiles`
*   `~/dotfiles/setup.sh`
*   `~/dotfiles/install-ubuntu.sh` (Ubuntu 20.04) *or* `~/dotfiles/install-rhel.sh` (RHEL 8.2)
*   `~/dotfiles/install-jdk-11.0.7.sh` (optional)
*   restart terminal


#   notes
##  to NOT run aliases
*   prepend command with `\`, eg: `\which which`

##  Xubuntu / Ubuntu Desktop first steps
*   `sudo apt install -y openssh-server`
*   `sudo apt install -y git`
*   do NOT update pip without taking a VM snapshot first, it might become broken and unfixable

##  RHEL first steps
*   `sudo subscription-manager register`
*   `sudo subscription-manager attach`
*   `sudo yum install -y git`
*   to set up local repo from the [RHEL 8.2 DVD](https://developers.redhat.com/download-manager/file/rhel-8.2-x86_64-dvd.iso)
    *   you will need at least 9GB of space for this, and another temporary 9GB for the iso
    *   copy in the iso as `rhel-8.2-x86_64-dvd.iso`, and run the `rhel-dvd-repo.sh` from that directory
    *   alternatively if you don't have an extra 9GB temp space, insert the DVD and run `rhel-dvd-repo.sh`, but this will likely be much slower
    *   any other version of RHEL -> update the sha256 and .repo file accordingly
        *   actual download path contains the sha256, e.g.:
            *   `https://access.cdn.redhat.com/content/origin/files/sha256/19/19d653ce2f04f202e79773a0cbeda82070e7527557e814ebbce658773fbe8191/rhel-server-7.9-x86_64-dvd.iso`
            *   `https://access.cdn.redhat.com/content/origin/files/sha256/7f/7fdfed9c7cced4e526a362e64ed06bcdc6ce0394a98625a40e7d05db29bf7b86/rhel-8.2-x86_64-dvd.iso`
            *   `https://access.cdn.redhat.com/content/origin/files/sha256/b7/b7de3a1f7e6ab1e4bf8c6ab70f934eb2e092cff8ab563fe255404b5777b1137e/rhel-8.3-beta-1-x86_64-dvd.iso`
*   `sudo yum remove -y insights-client`
*   (to remove) `sudo subscription-manager remove --all`

##  XFCE
*   (RHEL) `sudo yum group install -y xfce`
*   (Ubuntu) `sudo apt install -y xfce4 xfce4-goodies`

##  update
*   fzf
    *   `git -C ~/.fzf/ pull`
*   tldr
    *   `tldr --update`
*   dotfiles
    *   `cd ~/dotfiles`
    *   `git pull`


#   bash references

##  Create new user (aka `adduser` the hard way)
```shell
# assign to variable so this whole thing can run as a script
NEW_USER=new_username
sudo echo "Creating new user $new_username"

## TLDR version
#sudo useradd --create-home --shell $(which bash) --groups sudo  $NEW_USER  # Ubuntu
#sudo useradd --create-home --shell $(which bash) --groups wheel $NEW_USER  # RHEL

# create user
sudo useradd $NEW_USER

# change password
sudo passwd $NEW_USER  # interactive

# set up bash (instead of sh)
sudo chsh -s $(which bash) $NEW_USER

# add to sudoers file
sudo usermod -aG sudo  $NEW_USER  # for Ubuntu
sudo usermod -aG wheel $NEW_USER  # for RHEL

# enable password-less sudo
sudo echo "$NEW_USER  ALL=(ALL) NOPASSWD:ALL" | tee --append /etc/sudoers

# create home dir
sudo mkdir /home/$NEW_USER
sudo chown $NEW_USER:$NEW_USER /home/$NEW_USER

# create a .profile to tell bash to source .bashrc 
sudo tee /home/$NEW_USER/.profile << EOF
if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi
EOF
sudo chown $NEW_USER:$NEW_USER /home/$NEW_USER/.profile

# test that everything is okay
sudo su $NEW_USER

## something went wrong, remove user
#sudo userdel $NEW_USER -r
```

##  enable password-less sudo for your current account
```shell
echo "$(whoami)  ALL=(ALL) NOPASSWD:ALL" | sudo tee --append /etc/sudoers
```
If you messed up the command and can no longer sudo:
```shell
pkexec nano /etc/sudoers
```

##  set up `docker`, `docker-compose`, `minikube`, `kubectl`, `helm` (tested on ubuntu 20)
```shell
# docker, docker-compose
apt remove docker docker-engine docker.io containerd runc
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
echo   "deb [trusted=yes arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo tee /etc/apt/apt.conf.d/80ssl-exceptions << EOF
// Do not verify peer certificate
Acquire::https::Verify-Peer "false";
// Do not verify that certificate name matches server name
Acquire::https::Verify-Host "false";

EOF
apt update --allow-unauthenticated --allow-insecure-repositories
apt install -y docker-ce docker-compose
sudo usermod -aG docker user && newgrp docker
#sudo curl -k https://artifactory.domain.internal/infra/certificates/ca.domain.crt -o /usr/local/share/ca-certificates/ca.domain.crt
#sudo update-ca-certificates
#sudo systemctl restart docker
docker run hello-world

#  minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
minikube start --insecure-registry 0.0.0.0/0

#  kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

# helm
#snap install helm --classic  # fails due to MITM cert
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```

### usage
```shell
# without editing a helm chart:
helm install hzc --set service.type=LoadBalancer,hazelcast.yaml.hazelcast.network.memcache-protocol.enabled=true hazelcast/hazelcast
watch kubectl get all

# make it available via 0.0.0.0:5701 and 0.0.0.0:8080
# terminal #1
minikube tunnel

# terminal #2
kubectl get all
export HZC=$(kubectl get services --namespace default -l "app.kubernetes.io/name=hazelcast" -o jsonpath="{.items[0].spec.clusterIP}")
echo $HZC
socat TCP4-LISTEN:5701,fork TCP4:${HZC:?}:5701
# you may want to test using the python script

# terminal #3
kubectl get all
export HZCMAN=$(kubectl get services --namespace default -l "app.kubernetes.io/name=hazelcast-mancenter" -o jsonpath="{.items[0].spec.clusterIP}")
echo $HZCMAN
socat TCP4-LISTEN:8080,fork TCP4:${HZCMAN:?}:8080
# you may want to test by visiting in the browser

# stop
Ctrl-C the socat instances
pkill -f socat
Ctrl-C the minikube tunnel
helm uninstall hzc
minikube stop

# erase everything
docker system prune --volumes
```


##  set up python
```shell
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
conda install -y -c conda-forge jupyter_contrib_nbextensions
conda install -y -c conda-forge jupyter_nbextensions_configurator

# start notebook
jupyter notebook --ip=0.0.0.0 --no-browser --allow-root

# uninstall
conda install -y anaconda-clean
anaconda-clean -y
rm -rf ~/anaconda3

# reset bashrc
git fetch origin
git reset --hard origin/master
git clean -fdx
```

##  change the date
```shell
# change the date
sudo date -s "14/08/2019 11:22:33"
date -u
date +"%Y-%m-%d %H:%M:%S %z"
sudo hwclock --systohc --localtime 
```

##  java-alternatives (shouldn't be needed)
```shell
# set default java on RHEL
sudo alternatives --config java
sudo alternatives --config javac
```

##  git no ssl
```shell
# ignore ssl errors in git
git config --global http.sslVerify false
export GIT_SSL_NO_VERIFY=true
```

##  find parent for bash script
Minimal one-liner: `DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"`
```shell
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

#   todo
*   list sources
    *   scopatz/nanorc
    *   pepa65/tldr
    *   ...
*   is x forwarding enabled
*   set iosevka as terminal font
*   set terminal opacity to 90%
*   maybe symlink the xstartup instead of copying it?
*   firefox / chrome extensions
*   check nano version instead of just hardcoding rhel
*   create `offline-install-*.sh` that's called from the main `install-*.sh`

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

