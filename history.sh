#!/usr/bin/env bash

ifconfig
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb --insecure
sudo dpkg -i ripgrep_0.10.0_amd64.deb
rg
ll
rm ripgrep_0.10.0_amd64.deb
ll
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
git config http.sslVerify false
git -c http.sslVerify=false  clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
export GIT_SSL_NO_VERIFY=true
~/.fzf/install
nano ~/.fzf/install
~/.fzf/install
fzf
nano /usr/lib/ubuntu-release-upgrader/release-upgrade-motd
nano /usr/lib/ubuntu-release-upgrader/check-new-release
htop
sudo apt install mtr
sudo apt install --allow-unauthenticated mtr
mtr 8.8.8.8
sudo apt install --allow-unauthenticated pydf
ll
chmod +x Anaconda3-2018.12-Linux-x86_64.sh
ll
fzf
./Anaconda3-2018.12-Linux-x86_64.sh
conda list
pydu
pydf
conda list
pip list
conda config --set ssl_verify false
sudo apt install --allow-unauthenticated firefox
ll
cd .config/
ll
cd ..
ll /etc | grep pip
cd .config/
mkdir pip
cd pp
cd pip
ll
pwd
nano pip.conf
pip list
xclock
sudo apt install x11-apps
xclock
$LC_ALL
export LC_ALL=C
xclock
ll
unset LC_ALL
xclock
firefox
jupyter notebook --generate-config
jupyter notebook password
jupyter notebook --ip=0.0.0.0
conda install -c conda-forge jupyter_contrib_nbextensions
jupyter notebook --ip=0.0.0.0
conda install ftfy
conda install unidecode
conda install -c conda-forge tabulate
conda install tqdm -y
pip install langid
pip install pynndescent
pip install pybloomfiltermmap3
gcc
sudo apt install gcc
systemctl status firewall
pip install pybloomfiltermmap3
sudo apt install ncdu
ll
du
ncdu
ll
rm Anaconda3-2018.12-Linux-x86_64.sh
ll
sudo apt install baobab
sudo apt install treeview
conda install -c conda-forge cld2-cffi
sudo apt install gparted
sudo gparted
pydf
lvm
lvm2
lvdisplay
sudo lvdisplay
ll
nano .bashrc
tldr
sudo apt install tldr
tldr man
sudo apt remove tldr
pip install tldr
tldr man
tldr tar
tldf tar
tldr tar
git config http.sslVerify false --global
git config --global http.sslVerify false
pip remove tldr
pip uninstall tldr
sudo apt install tldr
tldf tar
tldr tar
ll
rm -rf .tldr/
ll
tldr tar
tldr tldr
tldr rg
sudo apt-get install kvpm
sudo apt install partitionmanager
system-config-lvm
sudo lvmdiskscan
apt install system-config-lvm
sudo apt install system-config-lvm
pip install pybloomfiltermmap3
conda install -c conda-forge patool
conda install paramiko
conda install chest
conda install -c conda-forge tika
python
conda remove tika
pip install tika-app
ll
java -version
sudo apt install openjdk-11-jre-headless
conda install -c conda-forge yapf
conda install autopep8
conda install -c plotly plotly
java -version
java -jar tika-app-1.20.jar
python
mkdir ipynb
mv pynndescent\ test.ipynb ipynb/
jupyter notebook --ip=0.0.0.0
jupyter labextension install jupyterlab-chart-editor
conda install ipywidgets
jupyter notebook --ip=0.0.0.0
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch
ll
wget - https://artifacts.elastic.co/GPG-KEY-elasticsearch
wget - https://artifacts.elastic.co/GPG-KEY-elasticsearch --no-check-certificate
sudo apt-key add GPG-KEY-elasticsearch
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update
ll /etc/apt/apt.conf.d/
cd /etc/apt/apt.conf.d/
nano 80ssl-exceptions
sudo nano 80ssl-exceptions
sudo apt-get update
sudo apt-get install elasticsearch
systemctl daemon-reload
systemctl status elasticsearch.service
systemctl enable elasticsearch.service
systemctl status elasticsearch.service
ll /etc/init.d/
ll /etc/init.d/elasticsearch
less /etc/init.d/elasticsearch
sudo less /etc/init.d/elasticsearch
sudo chmod +r /etc/init.d/elasticsearch
ll /etc/init.d/elasticsearch
ll /etc/init.d
sudo chmod +x /etc/init.d/elasticsearch
systemctl status elasticsearch.service
systemctl enable elasticsearch.service
sudo update-rc.d elasticsearch defaults 95 10
sudo add-apt-repository ppa:webupd8team/java
java -version
sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository --help
sudo apt-get --allow-unauthenticated add-apt-repository ppa:webupd8team/java
sudo add-apt-repository ppa:webupd8team/java --allow-unauthenticated
which add-apt-repository
which add-apt-repository  | nano
which add-apt-repository  | sudo nano
which add-apt-repository
sudo nano /usr/bin/add-apt-repository
sudo add-apt-repository ppa:linuxuprising/java
echo "http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
less /etc/apt/sources.list.d/webupd8team-java.list
rm /etc/apt/sources.list.d/webupd8team-java.list
sudo rm /etc/apt/sources.list.d/webupd8team-java.list
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
sudo apt-get update
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
sudo apt-get update
sudo apt install oracle-java8-installer
sudo reboot
update-alternatived
sudo apt install update-alternatives
sudo dpkg --configure -a
sudo apt install oracle-java8-set-default
java -version
java -jar tika-app-1.20.jar
systemctl enable elasticsearch
sudo reboot
ll /etc/default/elasticsearch
ll /etc/elasticsearch/
sudo ll /etc/elasticsearch/
sudo ls -lh /etc/elasticsearch/
sudo nano /etc/elasticsearch/elasticsearch.yml
curl -X PUT "localhost:9200/test_index" -H 'Content-Type: application/json' -d'
{
    "settings" : {
        "index" : {
            "number_of_shards" : 1,
            "number_of_replicas" : 1
        }
    }
}
'
sudo nano /etc/elasticsearch/elasticsearch.yml
systemctl restart elasticsearch.service
bin/elasticsearch-plugin install x-pack
/bin/elasticsearch-plugin install x-pack
elasticsearch-plugin install x-pack
cd /usr/share/elasticsearch
sudo bin/elasticsearch-plugin install x-pack
curl -XGET 'localhost:9200/?pretty'
sudo bin/x-pack/setup-passwords auto
bin/elasticsearch-setup-passwords
sudo bin/elasticsearch-setup-passwords
sudo bin/elasticsearch-setup-passwords interactive
GET /
curl -X GET "localhost:9200/"
conda install elasticsearch-dsl
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub
wget - https://dl-ssl.google.com/linux/linux_signing_key.pub
wget - https://dl-ssl.google.com/linux/linux_signing_key.pub --no-check-certificate
ll
sudo apt-key add linux_signing_key.pub
rm linux_signing_key.pub
rm GPG-KEY-elasticsearch
ll
sudo echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install google-chrome-stable
google-chrome
google-chrome --ignore-certificate-errors
jupyter notebook --ip=0.0.0.0
google-chrome --ignore-certificate-errors
sudo reboot
pydu
pydf
sudo shutdown -h now
ll
sudo nano .bashrc
date
time
history
history
sudo nano .bashrc
google-chrome --ignore-certificate-errors
sudo nano /etc/elasticsearch/elasticsearch.yml
systemctl restart elasticsearch.service
sudo systemctl restart elasticsearch.service
sudo nano /etc/elasticsearch/elasticsearch.yml
sudo systemctl restart elasticsearch.service
conda install -c conda-forge python-annoy
conda install -c pytorch faiss-cpu
conda install -c conda-forge fasttext
conda install -c conda-forge pybind11
python
conda list | grep fast
import fastText
python
conda remove fasttext
pip install fasttext
gcc
sudo apt install g++
pip install fasttext
python
conda install gensim
pip install wmd
conda list | grep ortools
pip install ortools
conda install spacyi
conda install spacy
python -m spacy download en
python
ll
cd ana
cd anaconda3/
ll
find | grep requests
cd lib/python3.7/site-packages/requests
ll
rg CERTIFICATE_VERIFY_FAILED
cd ..
ll
rg CERTIFICATE_VERIFY_FAILED
cd nltk
rg CERTIFICATE_VERIFY_FAILED
rg CERTIFICATE
rg CERTIFICATE -i
cd ../requests
rg CERTIFICATE -i
python -m spacy download en
nano adapters.py
rg "def get("
rg "def get"
rg "def get\("
rg "verify=True"
nano adapters.py
rg "verify=True"
nano sessions.py
python -m spacy download en
cd ..
cd urllib3
rg verify
rg verify=True
rg "verify=True"
rg verify
rg cert_reqs
nano util/ssl_.py
python -m spacy download en
nano util/ssl_.py
cd ..
cd OpenSSL/
rg do_handshake
cd SSL
nano SSL.py
python -m spacy download en
nano SSL.py
python -m spacy download en
rg "certificate verify failed"
rg "certificate verify failed"-i
rg "certificate verify failed" -i
rg "certificate verify" -i
rg "certificate veri" -i
rg "certificat" -i
rg "certificate" -i
cd ..
cd urllib3
rg "import ssl"
iotop
sudo apt install iotop
iotop
python
cd lib/python3.7/site-packages/requests
cd /home/user/anaconda3/lib/python3.7/site-packages/spacy
ll
python -m spacy download en
nano cli/download.py
less about.py
cat about.py
nano ~/.config/pip/pip.conf
python -m spacy download en
nano ~/.config/pip/pip.conf
python -m spacy download en
cat ~/.config/pip/pip.conf
ll
cat about.py
nano about.py
python -m spacy download en
nano about.py
cd ..
cd requests
nano sessions.py
python -m spacy download en
nano sessions.py
python -m spacy download en
cd ../OpenSSL/
nano _util.py
cd ..
cd cryptography
ll
cd hazmat/
ll
cd bindings/
ll
cd ..
rg SSL
cd ..
rg SSL
rg CERTIFICATE
rg certificate
rg "certificate verify"
rg "verify"
cd ../OpenSSL/
cd ../requests
rg get(
rg get\(
rg "get\("
nano sessions.py
python
nano ~/.config/pip/pip.conf
python -m spacy download en
sudo iotop
pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.0.0/en_core_web_sm-2.0.0.tar.gz
nano ~/.config/pip/pip.conf
pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.0.0/en_core_web_sm-2.0.0.tar.gz
cd /home/user/anaconda3/lib/python3.7/site-packages/
ll | grep pip
cd pip
ll
rg trusted
python -m spacy download en
rg insecure
rg install
rg "install\("
pydf
sudo shutdown -h now
nmtui
sudo apt install network-manager
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
ps aux | grep -i apt
systemctl disable apt-daily.timer
sudo systemctl disable apt-daily.timer
systemctl stop apt-daily.timer
sudo systemctl stop apt-daily.timer
systemctl mask apt-daily.service
sudo systemctl mask apt-daily.service
sudo systemctl daemon-reload
systemctl stop apt-daily.service
sudo systemctl stop apt-daily.service
ps aux | grep -i apt
sudo apt install network-manager
sudo apt remove network-manager
sudo apt autoremove
sudo apt upgrade
sudo apt-get install network-manager
nmtui
systemctl status network-manager.service
systemctl start network-manager.service
nmtui
cat /etc/netplan/50-cloud-init.yaml
nmcli
sudo nano /etc/netplan/50-cloud-init.yaml
sudo reboot
nmcli
netplan generate
sudo netplan generate
sudo netplan apply
nmcli
nmtui
sudo apt install thunar
sudo apt install nautilus
sudo apt install dolphin
sudo apt install konqueror
baobab .
sudo apt install baobab
sudo apt clean
sudo apt autoremove
sudo apt clean
pydf
ncdu
ll
cd ipynb/
ncdu
pydf
cd ..
csv
tsv
sc
sudo apt install sc
csview
tsview
sudo nano .bashrc
conda install csvkit
rg
xsv
sudo apt install jq
csvlook
conda install -c conda-forge chartify
lesspipe
pdftotext
sudo apt install poppler-utils
less Chatbots\ show\ the\ way\ in\ using\ tech\ to\ boost\ healthcare\,\ Singapore\ News\ \&\ Top\ Stories\ -\ The\ Straits\ Times.pdf
sudo apt install poppler-utils
less Chatbots\ show\ the\ way\ in\ using\ tech\ to\ boost\ healthcare\,\ Singapore\ News\ \&\ Top\ Stories\ -\ The\ Straits\ Times.pdf
rm Chatbots\ show\ the\ way\ in\ using\ tech\ to\ boost\ healthcare\,\ Singapore\ News\ \&\ Top\ Stories\ -\ The\ Straits\ Times.pdf
unzip
sudo apt install unzip
7za
sudo apt install p7zip-full
catdoc
antiword
sudo apt install catdoc
xlhtml
ppthtml
html2text
sudo apt install html2text
sudo apt install xlhtml ppthtml
identify
fastjar
less tika-app-1.20.jar
less matplotlib_named_colors.png
sudo apt install imagemagick-6.q16
less matplotlib_named_colors.png
ll
less matplotlib_named_colors.png
conda install -c conda-forge jieba
pip install snownlp
python
curl https://raw.githubusercontent.com/commonsense/conceptnet-numberbatch/master/text_to_uri.py
wget https://raw.githubusercontent.com/commonsense/conceptnet-numberbatch/master/text_to_uri.py
wget https://raw.githubusercontent.com/commonsense/conceptnet-numberbatch/master/text_to_uri.py --no-check-certificate
ll
mv text_to_uri.py ipynb/
ll ipynb/
feh matplotlib_named_colors.png
display matplotlib_named_colors.png
sudo apt install feh
feh matplotlib_named_colors.png
gedit
sudo apt install gedit
conda install faiss-cpu
conda install -c pytorch faiss-cpu
conda list
conda upgrade
wget https://raw.githubusercontent.com/pipeseroni/pipes.sh/master/pipes.sh --no-check-certificate
ll
chmod +x pipes.sh
./pipes.sh
ll
mv matplotlib_named_colors.png ipynb/
ll
mv tika-app-1.20.jar ipynb/
ll
mv ipynb/tika-app-1.20.jar .
ll
./pipes.sh
cat /var/lib/ubuntu-release-upgrader/release-upgrade-available
ll /var/lib/ubuntu-release-upgrader/release-upgrade-available
less /var/lib/ubuntu-release-upgrader/release-upgrade-available
rm /var/lib/ubuntu-release-upgrader/release-upgrade-available
sudo rm /var/lib/ubuntu-release-upgrader/release-upgrade-available
ll /var/lib/ubuntu-release-upgrader/release-upgrade-available
xz
conda list | grep chart
conda install msgpack
conda install -c conda-forge pika
sudo apt install tmux
sudo apt install byobu
editor
conda install msgpack
pip install msgpack
byobu
byobu
byobu-select-backend
byobu-config
less /usr/lib/byobu/include/config.py
conda install -c conda-forge newt
byobu-config
python
conda install -c conda-forge brotli
conda list | grep yapf
conda install lz4
pip install compress pylzma
conda install zstd
conda install snappy
conda install -c indygreg zstandard
compress
sudo apt install ncompress
sudo apt install zstd
zstd
man tar
man tar | grep zstd
exa
sudo apt install exa
byobu
history
wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip --no-check-certificate
ll
less exa-linux-x86_64-0.8.0.zip
unzip exa-linux-x86_64-0.8.0.zip
ll
./exa-linux-x86_64
manpath
tldr exa
wget https://raw.githubusercontent.com/ogham/exa/master/contrib/man/exa.1 --no-check-certificate
ll /etc/bash_completion.d/
wget https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.bash --no-check-certificate
ll /etc/bash_completion.d/
ll
mv completions.bash exa_completions_bash
mv exa_completions_bash /etc/bash_completion.d/
sudo mv exa_completions_bash /etc/bash_completion.d/
mv exa.1 /usr/share/man/man1/
sudo mv exa.1 /usr/share/man/man1/
exa
./exa
ll
mv ./exa-linux-x86_64 exa
mv exa /usr/local/bin/
sudo mv exa /usr/local/bin/
exa
man exa
rm exa-linux-x86_64-0.8.0.zip
exa -l
el
le
xl
ex
xa
xal
xl
tldr exa
exa -a
exa -ab
exa -al
exa -alh
exa -alhH
exa -alhb
exa -alh
exa -alhb
exa -alhbg
exa -abghH
exa -abghHl
exa -abghl
exa -abghli
exa -abghls
exa -abghlS
exa -abghl
exa -abghlS
exa -abghl@
exa -abghl
exa -abghl1
exa -abghl
exa -abghl -1
exa -abghlG
exa -abghl
exa -abghlx
exa -abghl
ll -h
lll
sudo nano .bashrc
lll
sudo crontab -l
crontab -l
lll /etc/update-motd.d/
less /etc/update-motd.d/91-release-upgrade
nano /etc/update-motd.d/91-release-upgrade
sudo nano /etc/update-motd.d/91-release-upgrade
lll /etc/update-motd.d/
less /etc/update-motd.d/10-help-text
less /etc/update-motd.d/50-motd-news
less /etc/default/motd-news
less /etc/update-motd.d/80-esm
less /etc/update-motd.d/80-livepatch
sudo nano /etc/update-motd.d/80-livepatch
sudo nano /etc/update-motd.d/91-release-upgrade
lll /etc/update-motd.d/
sudo nano /etc/update-motd.d/90-updates-available
lll /etc/update-motd.d/
sudo nano /etc/update-motd.d/90-updates-available
lll /etc/update-motd.d/
sudo nano /etc/update-motd.d/10-help-text
pydf
sudo nano /etc/update-motd.d/10-help-text
sudo nano /etc/update-motd.d/50-motd-news
xargs
ll
lll
lll -t
lll --help
man exa
lll --tree
lll .mozilla/
lll .mozilla/ --tree
lll .mozilla/ --tree  | less
conda list | grep pyg
ll
nano .lessfilter
ll
less pipes.sh
nano .lessfilter
less pipes.sh
nano .lessfilter
less --version
man lesspipe
ll
chmod +x ./.lessfilter
ll
lll
ll
less pipes.sh
nano .lessfilter
less pipes.sh
nano .lessfilter
echo . > .lessfilter
nano .lessfilter
g
df
fg
less pipes.sh
less pipes.sh -r
less -r pipes.sh
rm .lessfilter
less -r pipes.sh
less pipes.sh
less -r pipes.sh
nano .lessfilter
less -r pipes.sh
chmod +x .lessfilter
less -r pipes.sh
nano pipes.sh
nano --help
nano --help | grep control
nano --help | grep raw
nano --help | grep -
nano --help | grep - | less
nano --help | grep - | less -r
nano --help | grep - --color=always
nano --help | grep - --color=always | less
nano --help | grep - --color=always | less -r
nano --help | grep - --color=always | less -R
sudo nano .bashrc
cd .mozilla/
rg --
rg "--"
rg "\-\-"
rg "\-"
rg Shockwave
rg Shockwave | less
rg Shockwave --color=always | less
rg Shockwave --color=always | less -r
rg --color=always
sudo nano .bashrc
cd ..
sudo nano .bashrc
export EXA_OPTIONS='-abghl'
exa
nano --help | grep - --color=always | less -r
nano --help | grep - | less -r
lz4cat
zstdcat
zstdcat --help
tldr zstdcat
tldr lz4cat
man lz4cat
smbclient
sudo apt install smbclient
sudo apt install cifs-utils
sudo apt install exfat-fuse exfat-utils
sudo apt-get install ntfs-3g
sudo apt install samba
sshfs
sudo apt install sshfs
apt-get install nfs-kernel-server nfs-common  rpcbind ldap-auth-client nscd
sudo apt-get install nfs-kernel-server nfs-common  rpcbind ldap-auth-client nscd
sudo apt install watchdog
conda install pytables
sudo shutdown -h now
ping google.com
ll
less .bashrc
prettyping
ping
ping google.com
sudo apt-get search xclock
apt-get find
apt-get search
apt search xclock
curl google.com
fd
ba
bat
apt search prettyping
htop
nmtui
iotop
top
tldr
tldr --update
trash-cli
pydf
ncdu
baobab
sudo apt install baobab
ranger
sudo apt install ranger
stop
apt search stop
apt search stop | less
ufw
gparted
gedit
sudo apt install gedit
xclock
apt search micro
sutp apt instal xclip
sutp apt install xclip
sudo apt install xclip
curl https://getmic.ro | less
curl https://getmic.ro --no-check-certificate | less
curl https://getmic.ro --insecure | less
curl https://getmic.ro --insecure | bash
curl https://getmic.ro --insecure > install_micro.sh
nano install_micro.sh
ll
chmod +x install_micro.sh
./install_micro.sh
nano install_micro.sh
./install_micro.sh
nano install_micro.sh
./install_micro.sh
micro
./micro
ll
echo $path
echo $PATH
mv micro /usr/local/bin
sudo mv micro /usr/local/bin
micro
zcat
tree
sudo apt install tree
ll
ll --tree
lll
sudo nano .bashrc
ll --tree
ll
ll --tree
tree
time
date
hwclock --set --localtime
ll /etc/localtime
sudo unlink /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
date
date -s "11/06/2019 20:16"
date -s "11/06/2019 20:17"
sudo date -s "11/06/2019 20:17"
sudo hwclock --systohc --localtime
date -u
date
hwclock
hwclock[1~sudo
sudo hwclock
sudo nano .bashrc
la
exa -abgh
exa -abg
exa -ab
exa -a
exa
exa -b
exa -g
exa -a
la
ll
exa -A
exa -a
exa -la
sudo nano .bashrc
rg
xsv
apt search xsv
git
ipconfig
ipconfigifconfig
ifconfig
xclock
ll
chmod +x xsv
ll
sudo mv xsv /usr/local/bin
xsv
systemctl
systemctl status sshd
ifconfig
xsv
xfce
nautilus
sharkdp
sudo dpkg -i bat_0.11.0_amd64.deb
sudo dpkg -i fd_7.3.0_amd64.deb
fd
bat
ll
bat .bashrc
sudo dpkg -i hexyl_0.5.1_amd64.deb
ll
hexyl pipes.sh
ll
hexyl tika-app-1.20.jar
ll
del *.deb
delete
pwd
mkdir .Trash
delete *.deb
ll
ll .Trash
delete install_micro.sh
sshfs
conda
conda install ftfy
conda install gson langid fuzzywuzzy jellyfish chardet tabulate
conda install chardet tabulate
conda install retrying
conda install gson langid fuzzywuzzy jellyfish -c conda-forge
conda install langdetect fuzzywuzzy jellyfish -c conda-forge
pip install zxcvbn
conda install tqdm plotly protobuf
conda install -c conda-forge re2
conda install unidecode
conda install paramiko
conda install pika
conda list | grep paramiko
jupyter contrib nbextensions install --system
sudo jupyter contrib nbextensions install --system
jupyter contrib nbextensions install --user
jupyter nbextensions_configurator enable --user
shutdown -h now
htop
uptime
glances
sudo apt install glances
lspci
prettyping
apt search prettyping
curl https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping --insecure | less
curl https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping --insecure > prettyping
ll
chmod +x prettyping
./prettyping
./prettyping  google
sudo mv prettyping /usr/local/bin
sudo apt install trash-cli
ll
pydf
df
pydf -h
pydf --help
pydf -a
pydf -ah
pydf -l
pydf --help
df
pydf -B
pydf -a
df -a
df
which df
which cat
which find
which ping
cat2
which du
ncdu -h
ncdu
du
du -h
ranger
which byobu
which tmux
which vncserver
vncserver
gedit
sudo apt install gedit
which mosh
sudo apt-get install mosh
chrome
firefox
google-chrome
google-chrome --ignore-certificate-errors
mtr
peco
sudo apt install peco
realpath
realpath pipes.sh
realpath
realpath .
realpath ./
realpath ./ pipes.sh
realpath ./pipes.sh
terminalizer
asciinema
sudo apt install asciinema
sudo apt install fuse-exfat fuse-sshfs ntfs-3g ntfsprogs
apt search ntfsprogs
apt search ntfs
apt search fuse
apt search exfat
apt search sshfs | less
apt search ntfs
gparted
sudo gparted
gufw
sudo apt install gufw
less .bashrc
sudo apt-get install p7zip-full p7zip-rar
apt search p7zip
zstd
dir
dir --color=auto
ll /usr/share/nano
find /usr/share/nano -name '*.nanorc' -printf "include %p\n" | less
find /usr/share/nano -name '*.nanorc' -printf "include %p\n" > ~/.nanorc
ll
ll /usr/share/nano
nano --syntax=sh
nano --syntax=sh pipes.sh
nano --syntax=sh pipes.sh .nanorc
nano --syntax=sh .nanorc
nano --syntax=sh .fzf.bash
nano --syntax=tex pipes.sh
cls
apt searc hcls
apt search cls
apt search cls | less
..
open
open pipes.sh
xdg-open pipes.sh
sudo micro .bashrc
less .bashrc
cat .bashrc
ll
bay pipes.sh .lessfilter
bat pipes.sh .lessfilter
cat
cat pipes.sh
fd -X bat
fd
fd | bat
fd --help
bashrc
fd | cat
find | cat
ll
shutdown -h now
sudo shutdown -h now
sudo snap install pycharm-professional --classic
sudo apt-get install zenmap
mkdir fonts
ll
cp fonts/* /usr/local/share/fonts/
sudo cp fonts/* /usr/local/share/fonts/
ll /usr/local/share/fonts/
ll
apt search git lfs
sudo apt install git-lfs
apt search vlc
sudo apt install vlc
ll
mkdir plugins
python
mv pycharm-professional-2019.1.3.tar.gz plugins/
mv plugins/ pycharm/
ll
./pipes.sh
zsh
byobu
sudo apt install powerline
which powerline
vim
powerline
powerline --help
powerline shell
pip install powerline-status
vim --version
vim --version | grep python
powerline-daemon
powerline-daemon --help
which powerline
pip show powerline-status
ll /home/user/anaconda3/lib/python3.7/site-packages/powerline
. /home/user/anaconda3/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
q
/home/user/anaconda3/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
. /home/user/anaconda3/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
sudo su
bashrc
sudo apt-get install fonts-powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
ll
sudo mv PowerlineSymbols.otf /usr/local/share/fonts/
ll /usr/local/share/fonts/
fc-cache
fc-cache --help
fc-cache -vf
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
ll
ll .config
xset q
bash
terminal
gnome-terminal
sudo apt install gnome-terminal
xterm
sudo apt install xterm
xterm
fontconfig
apt search fontconfig
socat
psutil
sudo apt install socat
xrandr
ll
less 10-powerline-symbols.conf
cat 10-powerline-symbols.conf
lll
ll /etc/fonts/
ll /etc/fonts/conf.
ll /etc/fonts/conf.d
less /etc/fonts/conf.d/10-powerline-symbols.conf
ll /usr/local/share/fonts/
sudo chown root:staff /usr/local/share/fonts/*
sudo chmod 644 /usr/local/share/fonts/*
ll /usr/local/share/fonts/
ls -l /usr/local/share/fonts/
sudo fc-cache -fv
xset q
ll
cd .Trash/
cd /
cd /usr/
dc /
cd /
..
ll
cd home/
cd user/
cd /
cd ~/.Trash/
ll
cd ..
cd .Trash/
..
ll
cd .config/
ll
echo $XDG_CONFIG_DIRS
echo $XDG_CONFIG_HOMe
echo $XDG_CONFIG_HOME
which powerline
powerline --help
powerline --help | less
bashrc
nano /home/user/anaconda3/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
powerline-config
powerline-config --help
powerline-config shell help
powerline-config shell -h
powerline bash -h
. /home/user/anaconda3/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
export PS1=">"
bashrc
jupyter notebook password
jupyter notebook
jupyter notebook --ip=0.0.0.0
shutdown -h now
sudo shutdown -h now
ipconfig
bashrc
reboot
ipconfig
bashrc
reboot
sudo reboot
sudo shutdown -h now
ll
tar -xzf pycharm-2019.1.3.tar.gz
cd pycharm/
tar -xzf pycharm-2019.1.3.tar.gz
ll
tar -xzf pycharm-professional-2019.1.3.tar.gz
lkl
ll
cd pycharm-2019.1.3/
ll
cat Install-Linux-tar.txt
ll
cd ..
ll
..
ll
mv pycharm/pycharm-2019.1.3/ .
ll
ll pycharm
.. pycharm-2019.1.3/
ll pycharm-2019.1.3/
cd pycharm-2019.1.3/bin/
ll
./pycharm.sh
date
date -s "2019-06-13"
sudo date -s "2019-06-13"
sudo date -s "2019-06-13 17:39"
ipconfig
nmtui
ifconfig
systemctl status sshd
systemctl restart sshd
which charm
pwd
ll
./pycharm-2019.1.3/bin/pycharm.sh
htop
ps -ef | grep charm
kill -9 2610 2656 2699
./pycharm.sh
ps -ef | grep charm
./pycharm.sh
ll
./pycharm-2019.1.3/bin/pycharm.sh
sudo ./pycharm-2019.1.3/bin/pycharm.sh
./pycharm-2019.1.3/bin/pycharm.sh
which charm
charm
ll /usr/local/bin
sudo chmod /usr/local/bin/charm +x
sudo chmod +x /usr/local/bin/charm
ll /usr/local/bin
which cjarm
which charm
which charm | cat
cat /usr/local/bin/charm
sudo nano /usr/local/bin/charm
ll
sudo nano /usr/local/bin/charm
sudo su
bashrc
shutdown -h now
sudo shutdown -h now
apt search mosh
htop
mosh --version
xclock
sudo shutdown -h now
sudo apt install xubuntu-desktop
less /etc/apt/sources.list
cat /etc/apt/sources.list
nano /etc/apt/sources.list
sudo nano /etc/apt/sources.list
sudo apt install xubuntu-desktop
sudo apt update
sudo apt install xubuntu-desktop
reboot
sudo reboot
vncserver
sudo apt autoremove
conda install pylint nosexcover nose pyflakes
conda isntall pylint
conda install pylint
bashrc
pwd
ll
sudo mkdir xtraman
chmod 755 xtraman/
sudo chmod 755 xtraman/
cd xtraman/
mv ~/Desktop/ca.xtraman.org.cer .
sudo mv ~/Desktop/ca.xtraman.org.cer .
sudo mv ~/Desktop/infra.crt .
ll
chmod 644 *
ll
sudo update-ca-certificates
cd /usr/local/share/ca-certificates/
ll
cd xtraman/
sudo openssl x509 -inform DER -in ca.xtraman.org.cer -out ca.xtraman.org.crt
ll
nano /etc/ca-certificates.conf
sudo nano /etc/ca-certificates.conf
sudo update-ca-certificates
sudo apt remove powerline
sudo apt autoremove
apt search python-pip
apt search git
apt search git | less
sudo apt-get install python-pip*
apt search socat
pip install psutil
conda search bzr
pip search bzr
sudo apt install powerline
bashrc
apt search powerline
bashrc
sudo apt-get install fonts-powerline -f
sudo apt remove fonts-powerline
sudo apt-get install fonts-powerline
sudo reboot
sudo su
xclock
bashrc
cd tigervnc-1.9.0.x86_64/
ll
chmod -R +x *
ll --tree
ll
cd .
..
ll
cd tigervnc-1.9.0.x86_64/
ll --tree
cd ..
rm -rf tigervnc-1.9.0.x86_64/
ll
tar -xzf tigervnc-1.9.0.x86_64.tar.gz
ll
cd tigervnc-1.9.0.x86_64/
ll
ll --tree
sudo cp -R usr/ /
ll
which vncserver
..
ll
vncserver
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
nano ~/.vnc/xstartup
sudo chmod +x ~/.vnc/xstartup
vncserver -list
vncserver
vncserver -kill :1
sudo apt remove light-locker
vncserver
sudo reboot
htop
sudo apt install ntp
service ntp status
nmtui
htop
baobab
sudo apt install baobab
which vncserver
which gufw
which gparted
sudo apt install gufw
which gedit
which mousepad
which ntfsprogs
sudo apt search ntfsprogs
sudo apt search ntfs
which terminalizer
ranger
mousepad
sudo apt install gedit
apt search noto
sudo apt install fonts-noto
sudo apt install fonts-noto*
sudo apt-add-repository ppa:eosrei/fonts
sudo apt update
sudo apt-add-repository ppa:ys/emojione-picker
sudo apt update
sudo apt install emojione-picker fonts-twemoji-svginot
sudo apt-add-repository ppa:ys/emojione-picker -r
sudo apt install fonts-twemoji-svginot
gedit
sudo apt update
which gucharmap
sudo apt install fonts-noto-color-emoji
shutdown -h now
gedit
sudo apt install fonts-noto*
gedit
gucharmap
history
conda update
conda update --all
shudown -h now
history
shutdown -h now
sudo apt-get install sshpass nmap
nmap
sshpass
tldr sshpass
lspci
lsusb
which vncserver
bat
java -version
which java
javac -version
which javap
echo $JAVA_HOME
echo $JAVA_HOME | cd
ping google
ping google.com
ping 1.1.1.1
ping 8.8.8.8
ping 0.0.0.0
which python
python
conda update --all
which gcc
sox
sudo apt install sox
ffmpeg
sudo apt install ffmpeg
ffmpeg
shutdown -h now
sudo shutdown -h now
python
conda install -c conda-forge python-docx
python
conda install -c conda-forge python-pptx
conda install anaconda
conda update --all
python
python -m spacy download en_core_web_sm
pip install fasttext
shutdown -h now
sudo shutdown -h now
conda install numpy scipy scikit-learn pandas joblib
conda install -c conda-forge xgboost deap update_checker tqdm stopit
pip install auto-sklearn
history | less
conda update --all
sudo shutdown -h now
sudo apt install wordlist
sudo apt install wgerman-medical wesperanto wcanadian-small wcanadian-large wcanadian-insane wcanadian-huge wcanadian wbritish-small wbritish-large wbritish-insane wbritish-huge wamerican-small wamerican-large wamerican-insane wamerican-huge wukrainian wswiss wswedish wspanish wportuguese wpolish wogerman wnorwegian wngerman witalian wgalician-minimos wfrench wfaroese wdutch wdanish wcatalan wbulgarian wbritish wbrazilian wamerican miscfiles
sudo apt install wgerman-medical wesperanto wcanadian-small wcanadian-large wcanadian-insane wcanadian-huge wcanadian wbritish-small wbritish-large wbritish-insane wbritish-huge wamerican-small wamerican-large wamerican-insane wamerican-huge wukrainian wswiss wswedish wspanish wportuguese wpolish wogerman wnorwegian wngerman witalian wgalician-minimos wfrench wfaroese wdutch wdanish wcatalan wbulgarian wbritish wbrazilian wamerican
sudo apt install wgerman-medical wesperanto wcanadian-small wcanadian-large wcanadian-huge wcanadian wbritish-small wbritish-large wbritish-huge wamerican-small wamerican-large wamerican-huge wukrainian wswiss wswedish wspanish wportuguese wpolish wogerman wnorwegian wngerman witalian wgalician-minimos wfrench wfaroese wdutch wdanish wcatalan wbulgarian wbritish wbrazilian wamerican miscfiles
sudo apt install wordlist
sudo apt search wordlist
sudo apt install wcanadian-small wcanadian-large wcanadian-insane wcanadian-huge wcanadian wbritish-small wbritish-large wbritish-insane wbritish-huge wamerican-small wamerican-large wamerican-insane wamerican-huge wbritish wamerican miscfiles
ll /usr/share/dict/
bat /usr/share/dict/words
wc /usr/share/dict/words
wc /usr/share/dict/words -h
ll /usr/share/dict/
ll /usr/share/dict* --tree
apt search cracklib
sudo shutdown -h now
bashrc
history | grep install | less
sudo shutdown -h now
pip list | grep spacy
conda list | grep spacy
which charm
conda install --update spacy
conda install --upgrade spacy
conda remove spacy
conda install -c conda-forge spacy
conda list
apt list
apt list | more
apt list | bat
history | grep apt
history | grep apt | bat
glances
sudo snap install glances
pip install glances
glances
date
glances
glances -w
pip upgrade spacy
pip update spacy
pip install --upgrade spacy
pip list | grep spacy
conda list | grep spacy
sudo apt-get install tesseract-ocr
sudo apt-get search tesseract
sudo apt search tesseract
sudo apt-get install gimageviewer
sudo apt-get install gimagereader
python -m spacy download xx_ent_wiki_sm
python -m spacy download xx_ent_wiki_sm --direct
python -m spacy download en_core_web_lg --direct
pip install xx_ent_wiki_sm-2.2.0.tar.gz
rm xx_ent_wiki_sm-2.2.0.tar.gz
pip install en_core_web_sm-2.2.0.tar.gz
rm en_core_web_sm-2.2.0.tar.gz
pip install pytesseract
python
tesseract -psm 3 asciiGood.gif tmp.txt
tesseract  asciiGood.gif tmp.txt
cat tmp.txt.txt
ll
rm tmp
rm tmp.txt.txt
ll
rm jetbrains\ license\ til\ Oct\ 2019.txt
charm
which charm
ll /usr/local/bin
rm /usr/local/bin/charm
sudo rm /usr/local/bin/charm
which charm
ll
ll ..
sudo ll /root
sudo ls /root
sudo su
which more
bashrc
java -jar tika-app-1.20.jar  -h
java -jar tika-app-1.20.jar  --help
java -jar tika-app-1.20.jar -t asciiGood.gif | more
git clone https://github.com/scopatz/nanorc.git ~/.nano
cat ~/.nano/nanorc >> ~/.nanorc
ll
nano .nanorc
cd .nano
rg normal
nano prolog.nanorc
nano etc-hosts.nanorc
nano prolog.nanorc
nano conky.nanorc
fg
rg normal
cd ..
nano .nanorc
fg
ll
bashrc
jupyter contrib nbextension
jupyter nbextensions_configurator
pip install supersqlite
ll /usr/local/share/fonts/
htop
ll fonts
rm -r fonts
ll
ll pycharm
ll pycharm-
ll pycharm-2019.1.3/
tar -xvzf pycharm-community-2019.2.3.tar.gz
ll
cd pycharm-community-2019.2.3/
ll
cd bin
ll
./pycharm.sh
..
ll
cd PycharmProjects/
ll
..
rm -r PycharmProjects/
rm -rf PycharmProjects/
ll
ll .PyCharm*
rm -rf .PyCharm*
ll
rm -rf pycharm-2019.1.3/
ll
fd pycharm
ll
ll pycharm
pycharm-community-2019.2.3/bin/pycharm.sh
ll
ll PycharmProjects/
rm -rf PycharmProjects/gazette-ner/
ll pycharm
ll PycharmProjects/
which python
which pip
cd PycharmProjects/
ll
rm -rf gazette-ner/
ll
cd ..
ll
cd iosevka\ ss09\ 2.3.1/
..
sudo cp iosevka\ ss09\ 2.3.1/* /usr/local/share/fonts/
ll
pycharm-community-2019.2.3/bin/pycharm.sh
pip install en_core_web_lg-2.2.0.tar.gz
htop
pycharm
charm
which charm
pycharm-community-2019.2.3/bin/pycharm.sh
pip install cld3
sudo shutdown -h now
htop
htop
clear
pip install supersqlite
jupyter notebook --ip=0.0.0.0 --no-browser
df -h
df2 -h
cd /
ll
sudo mkdir share
sudo chown user:user share
sudo chmod 777 share/
ll
cd ~
tldr ln
ls -s /share net_share
ls -s /share ~/net_share
ls -s /share /home/user/net_share
sudo ls -s /share /home/user/net_share
ll
pwd
tldr ln
ls -s /share share
ll /
ls -s /share net_share
cd /share
cp /etc/samba/smb.conf .
htop
nano smb.conf
ll
cd ~
ln -s /share share
ll
rm share
ln -s /share net_share
cd /
ll
cd ~
rm net_share
ln -s /share network_share
ll
rm en_core_web_lg-2.2.0.tar.gz
ll pycharm
rm -rf pycharm
ll
cd /share
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
sudo cp smb.conf /etc/samba/smb.conf
sudo testparm
nano smb.conf
sudo cp smb.conf /etc/samba/smb.conf
sudo testparm
sudo service smbd restart
ifconfig
systemctl status sshd
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
ll
cd Downloads/
ll
tldr wget
wget https://github.com/subhra74/snowflake/releases/download/v1.0.4/snowflake-1.0.4-setup-amd64.bin
cd /usr/local/share/fonts/
ll
sudo ll ios*
ll ios*
sudo rm ios*
ll
cd ~/Down
cd ~/Downloads/
mv ttf iosevka
cd iosevka/
ll
sudo cp iosevka* /usr/local/share/fonts/
ll /usr/local/share/fonts/
sox
socat
rg
peco
tldr
tldr --update
ll /share
gedit
glances
which pip
pip install --upgrade glances
hexyl
ll
cd ~/Downloads/
ll
chmod +x snowflake-1.0.4-setup-amd64.bin
ll
./snowflake-1.0.4-setup-amd64.bin
sudo ./snowflake-1.0.4-setup-amd64.bin
snowflake
jq
nano
nano --version
mtr
..
ll
mv pycharm-community-2019.2.3.tar.gz Downloads/
nv tigervnc-1.9.0.x86_64.tar.gz Downloads/
mv tigervnc-1.9.0.x86_64.tar.gz Downloads/
ll
mb jetbrains\ license\ til\ Jul\ 2020.txt Downloads/
mv jetbrains\ license\ til\ Jul\ 2020.txt Downloads/
ll
htop
ll
cd pycharm-community-2019.2.3/
ll
cd bin
ll
..
which charm
where charm
charm
python
conda update --all
sudo systemctl stop elasticsearch
sudo systemctl disable elasticsearch
htop
sudo apt-get install -y powershell
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo add-apt-repository universe
sudo apt-get install -y powershell
which baobab
which feh
trash-list
tesseract
apt search browsh
wget https://github.com/browsh-org/browsh/releases/download/v1.4.12/browsh_1.4.12_linux_amd64.deb
sudo dpkg -i browsh_1.4.12_linux_amd64.deb
ll
mv *.deb Downloads/
jq
which tmux
nnn
httpie
sudo apt install httpie
apt search pandoc
sudo apt install pandoc
apt search aria2
sudo apt install aria2
sync; echo 1 > /proc/sys/vm/drop_caches
sudo su
htop
sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'
htop
sudo sh -c 'echo 2 >/proc/sys/vm/drop_caches'
htop
sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
htop
sudo shutdown -h now
history | more
history > history.sh
