#!/usr/bin/env bash

ISO_FILE_BASENAME="rhel-8.2-x86_64-dvd"
ISO_SHA256_CHECKSUM=7fdfed9c7cced4e526a362e64ed06bcdc6ce0394a98625a40e7d05db29bf7b86

# remove spaces
ISO_FILE_SAFENAME=${ISO_FILE_BASENAME// /-}
ISO_MOUNT_PATH="/mnt/${ISO_FILE_SAFENAME}"

# we need sudo permissions
sudo echo "setting up repo using RHEL dvd"

# create mount point
echo ""
echo "step 1/7: create mount point at [${ISO_MOUNT_PATH}]"
sudo mkdir --parents "${ISO_MOUNT_PATH}"
if [[ $? != 0 ]]; then
    echo "ERROR: unable to create mount point"
    exit
fi

# does DVD exist?
echo "step 2/7: mount RHEL installation media"
if [[ -f "${ISO_FILE_SAFENAME}.iso" ]]; then
    echo "found iso file, verifying checksum"
    echo "${ISO_SHA256_CHECKSUM} ${ISO_FILE_SAFENAME}.iso" | sha256sum --check -
    if [[ $? != 0 ]]; then
        echo "WARNING: iso checksum verification failed"
        ISO_SHA256_CHECKSUM=0
    fi

    echo "mounting iso file"
    sudo mount -o loop "${ISO_FILE_SAFENAME}.iso" "${ISO_MOUNT_PATH}"
    if [[ $? != 0 ]] && [[ ${ISO_SHA256_CHECKSUM} != 0 ]]; then
        echo "WARNING: iso mount failed"
        ISO_SHA256_CHECKSUM=0
    fi
else
    ISO_SHA256_CHECKSUM=0
fi

blkid /dev/sr0
if [[ $? == 0 ]] && [[ ${ISO_SHA256_CHECKSUM} == 0 ]]; then
    echo "physical dvd found"
    sudo mount /dev/sr0 "${ISO_MOUNT_PATH}"
    if [[ $? != 0 ]]; then
        echo "ERROR: dvd mount failed"
        exit
    fi

elif [[ ${ISO_SHA256_CHECKSUM} == 0 ]]; then
    echo "ERROR: unable to mount ISO or DVD"
    exit
fi

# copy data
echo "step 3/7: copy data"
sudo cp -R "${ISO_MOUNT_PATH}" /home
if [[ $? != 0 ]]; then
    echo "ERROR: copy failed"
    exit
fi

# unmount
echo "step 4/7: unmount RHEL installation media"
sudo umount "${ISO_MOUNT_PATH}"
if [[ $? != 0 ]]; then
    echo "ERROR: unmount failed"
    exit
fi

# setup repo (updated repofile from https://access.redhat.com/solutions/3776721)
echo "step 5/7: copy repo file"
sudo tee /etc/yum.repos.d/${ISO_FILE_SAFENAME}.repo << EOF
[dvd-BaseOS]
name=DVD for RHEL8 - BaseOS
baseurl=file:///home/${ISO_FILE_SAFENAME}/BaseOS
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[dvd-AppStream]
name=DVD for RHEL8 - AppStream
baseurl=file:///home/${ISO_FILE_SAFENAME}/AppStream
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

EOF

echo "step 6/7: chmod repo file"
sudo chmod 644 "/etc/yum.repos.d/${ISO_FILE_SAFENAME}.repo"
if [[ $? != 0 ]]; then
    echo "ERROR: repo file chmod failed"
    exit
fi

# update yum
echo "step 7/7: reset yum"
sudo yum clean all
if [[ $? != 0 ]]; then
    echo "ERROR: yum clean failed"
    exit
fi
sudo subscription-manager clean
if [[ $? != 0 ]]; then
    echo "ERROR: subscription-manager clean failed"
    exit
fi
sudo yum update
if [[ $? != 0 ]]; then
    echo "ERROR: yum update failed"
    exit
fi

# done!
echo "DONE!"