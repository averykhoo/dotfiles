# get username and password
if [[ "$#" -eq 0 ]]; then
  read -rp  'Username: ' NEW_USER
  read -rsp 'Password: ' NEW_USER_PASSWORD
elif [[ "$#" -eq 1 ]]; then
  NEW_USER=$1
  echo "Username: ${NEW_USER}"
  read -rsp 'Password: ' NEW_USER_PASSWORD
elif [[ "$#" -eq 2 ]]; then
  NEW_USER=$1
  NEW_USER_PASSWORD=$2
  echo "Username: ${NEW_USER}"
  echo "Password: $(printf '*%.0s' $(seq 1 ${#NEW_USER_PASSWORD}))"
else
  echo "Usage: create_user.sh <username> [<password>]"
  exit 1
fi

# create user
sudo useradd "${NEW_USER}"

# set user password
#sudo passwd "${NEW_USER}"  # interactive
echo "${NEW_USER}:${NEW_USER_PASSWORD}" | sudo chpasswd

# set up bash (instead of sh)
sudo chsh -s "$(which bash)" "${NEW_USER}"

# add to sudoers file
cat "/etc/group" | grep sudo      >/dev/null && sudo usermod -aG sudo      "${NEW_USER}"  # for Ubuntu
cat "/etc/group" | grep wheel     >/dev/null && sudo usermod -aG wheel     "${NEW_USER}"  # for RHEL
cat "/etc/group" | grep ssh-users >/dev/null && sudo usermod -aG ssh-users "${NEW_USER}"  # for RHEL (allow ssh)

# enable password-less sudo
echo "${NEW_USER}  ALL=(ALL) NOPASSWD:ALL" | sudo tee --append /etc/sudoers

# disable password expiry or inactivity deactivation
sudo chage -E -1 -I -1 -m 0 -M -1 "${NEW_USER}"

# disable password complexity requirements
sudo nano /etc/security/pwquality.conf

# create home dir
sudo mkdir /home/"${NEW_USER}"
sudo chown "${NEW_USER}":"${NEW_USER}" "/home/${NEW_USER}"

# allow crontab usage
echo "${NEW_USER}" | sudo tee -a /etc/cron.allow >/dev/null

# create a .profile to tell bash to source .bashrc
sudo tee "/home/${NEW_USER}/.profile" >/dev/null <<EOF
if [ -s ~/.bashrc ]; then
  source ~/.bashrc;
fi
EOF
sudo chown "${NEW_USER}":"${NEW_USER}" "/home/${NEW_USER}/.profile"
