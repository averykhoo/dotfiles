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

# validate that the username is not already taken
if [[ -n "$(getent passwd "${NEW_USER}")" ]]; then
  echo "User ${NEW_USER} already exists"
  exit 1
fi

# validate that the username is alphanumeric, and at most 32 chars long
if [[ ! "${NEW_USER}" =~ ^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$ ]]; then
  echo 'Username must start with /[a-z_]/, and should match /[a-z0-9_-]{32}/'
  exit 1
fi

# create user
sudo useradd "${NEW_USER}"

# set user password
#sudo passwd "${NEW_USER}"  # interactive
echo "${NEW_USER}:${NEW_USER_PASSWORD}" | sudo chpasswd

# set up bash (instead of sh)
sudo chsh -s "$(which bash)" "${NEW_USER}"

# add to sudoers file and docker group
# note that `grep wheel /etc/group` is unsafe, it would be better to use `grep -q -E "^wheel:" /etc/group`
# even better, use `getent`
getent group sudo      >/dev/null && sudo usermod -aG sudo      "${NEW_USER}"  # for Ubuntu
getent group wheel     >/dev/null && sudo usermod -aG wheel     "${NEW_USER}"  # for RHEL
getent group ssh-users >/dev/null && sudo usermod -aG ssh-users "${NEW_USER}"  # for RHEL (allow ssh)
getent group docker    >/dev/null && sudo usermod -aG docker    "${NEW_USER}"  # for RHEL (allow ssh)

# enable password-less sudo
echo "${NEW_USER}  ALL=(ALL) NOPASSWD:ALL" | sudo tee --append /etc/sudoers >/dev/null

# disable password expiry or inactivity deactivation
sudo chage -E -1 -I -1 -m 0 -M -1 "${NEW_USER}"

# create home dir
sudo mkdir -p /home/"${NEW_USER}"
sudo chown "${NEW_USER}":"${NEW_USER}" /home/"${NEW_USER}"

# allow crontab usage
echo "${NEW_USER}" | sudo tee -a /etc/cron.allow >/dev/null

# create a .profile to tell bash to source .bashrc
sudo tee "/home/${NEW_USER}/.profile" >/dev/null <<EOF
if [ -s ~/.bashrc ]; then
  source ~/.bashrc;
fi
EOF
sudo chown "${NEW_USER}":"${NEW_USER}" "/home/${NEW_USER}/.profile"
