#!/usr/bin/env bash

# https://linuxconfig.org/install-samba-on-redhat-8
# https://websiteforstudents.com/create-public-samba-share-ubuntu-17-04-17-10/


SHARE_PATH="/share"
BACKUP_TIMESTAMP=$(date +"%Y-%m-%d--%H-%M-%S")

# test config
sudo testparm -s
if [[ $? != 0 ]]; then
    echo "ERROR: testparm thinks the existing (unchanged) config is invalid" >> /dev/stderr
    echo "no changes made to /etc/samba/smb.conf"
    exit 1
fi

# backup smb.conf file
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup--${BACKUP_TIMESTAMP}.bak

# create folder
sudo mkdir --parents ${SHARE_PATH}
sudo chown user:user ${SHARE_PATH}
sudo chmod 777 ${SHARE_PATH}


# add lines to smb.conf describing share
sudo tee -a /etc/samba/smb.conf << EOF

[share]
    comment = Shared Folder
    path = ${SHARE_PATH}
    browsable = yes
    read only = no
    public = yes
    writable = yes
    create mask = 0666
    directory mask = 0777
    security = share
    guest ok = yes
#    guest only = yes
#    force user = nobody

EOF

# test config
sudo testparm -s
if [[ $? != 0 ]]; then
    echo "ERROR: testparm thinks the new config is invalid" >> /dev/stderr
    sudo rm /etc/samba/smb.conf
    sudo cp /etc/samba/smb.conf.backup--${BACKUP_TIMESTAMP}.bak /etc/samba/smb.conf
    echo "reverted /etc/samba/smb.conf"
    exit 1
fi

# restart smb daemon for rhel
sudo systemctl restart smb

# restart smb daemon for ubuntu
sudo systemctl restart smbd

# open firewall for rhel
[[ -x "$(command -v firewall-cmd)" ]] && sudo firewall-cmd --add-service=samba
[[ -x "$(command -v firewall-cmd)" ]] && sudo firewall-cmd --add-service=samba --permanent
[[ -x "$(command -v firewall-cmd)" ]] && sudo firewall-cmd --reload
