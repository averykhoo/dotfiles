#!/usr/bin/env bash

ISO_FILE_BASENAME="rhel-server-8.2-x86_64-dvd"

# we need sudo permissions
sudo echo "setting up repo using RHEL dvd"

# create mount point
echo ""
echo "step 1/8: create mount point at [/mnt/$ISO_FILE_BASENAME]"
sudo mkdir --parents /mnt/${ISO_FILE_BASENAME}
if [[ $? == 0 ]]; then
    echo "ERROR: unable to create mount point"
    exit
fi

# does DVD exist?
echo "step 2/8: get dvd"
blkid /dev/sr0
if [[ $? == 0 ]]; then
    echo "physical dvd found"
    sudo mount /dev/sr0 /mnt/rhel_dvd
    if [[ $? != 0 ]]; then
        echo "ERROR: dvd mount failed"
        exit
    fi
else
    echo "physical dvd not inserted, mounting iso"
    CHECKSUM=0eb9441dfd2be041ca1075842c5335a731e60c6ea2bfb1e947224136098c2670
    if echo "$CHECKSUM ${ISO_FILE_BASENAME}.iso" | sha1sum --check -; then
        echo "test passed"
    fi
fi