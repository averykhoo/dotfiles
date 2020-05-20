#!/usr/bin/env bash

ISO_FILE_BASENAME="rhel-server-8.2-x86_64-dvd"
ISO_SHA1_CHECKSUM=0eb9441dfd2be041ca1075842c5335a731e60c6ea2bfb1e947224

MOUNT_PATH="/mnt/${ISO_FILE_BASENAME}"
ISO_FILE_NAME="${ISO_FILE_BASENAME}.iso"
REPO_FILE_NAME="${ISO_FILE_BASENAME}.repo"

# we need sudo permissions
sudo echo "setting up repo using RHEL dvd"

# create mount point
echo ""
echo "step 1/7: create mount point at [${MOUNT_PATH}]"
sudo mkdir --parents "${MOUNT_PATH}"
if [[ $? != 0 ]]; then
    echo "ERROR: unable to create mount point"
    exit
fi

# does DVD exist?
echo "step 2/7: mount RHEL installation media"
blkid /dev/sr0
if [[ $? == 0 ]]; then
    echo "physical dvd found"
    sudo mount /dev/sr0 "${MOUNT_PATH}"
    if [[ $? != 0 ]]; then
        echo "ERROR: dvd mount failed"
        exit
    fi

else
    echo "physical dvd not inserted, verifying iso file"
    echo "${ISO_SHA1_CHECKSUM} ${ISO_FILE_NAME}" | sha1sum --check -
    if [[ $? != 0 ]]; then
        echo "ERROR: iso checksum verification failed"
        exit
    fi

    echo "mounting iso file"
    sudo mount -o loop "${ISO_FILE_NAME}" "${MOUNT_PATH}"
    if [[ $? != 0 ]]; then
        echo "ERROR: iso mount failed"
        exit
    fi
fi

# copy data
echo "step 3/7: copy data"
sudo cp -R "${MOUNT_PATH}" /home
if [[ $? != 0 ]]; then
    echo "ERROR: copy failed"
    exit
fi

# unmount
echo "step 4/7: unmount RHEL installation media"
sudo umount "${MOUNT_PATH}"
if [[ $? != 0 ]]; then
    echo "ERROR: unmount failed"
    exit
fi

# setup repo
echo "step 5/7: copy repo file"
sudo cp "${REPO_FILE_NAME}" "/etc/yum.repos.d/${REPO_FILE_NAME}"
if [[ $? != 0 ]]; then
    echo "ERROR: repo file copy failed"
    exit
fi

echo "step 6/7: chmod repo file"
sudo chmod 644 "/etc/yum.repos.d/${REPO_FILE_NAME}"
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
