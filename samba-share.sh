#!/usr/bin/env bash

SHARE_PATH="/share"

# backup smb.conf file
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup--$(date +"%Y-%m-%d--%H-%M-%S").bak

# create folder
sudo mkdir --parents ${SHARE_PATH}

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
    guest ok = yes
    security = share

EOF