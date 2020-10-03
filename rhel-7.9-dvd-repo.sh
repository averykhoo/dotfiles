#!/usr/bin/env bash

# https://developers.redhat.com/download-manager/file/rhel-server-7.9-x86_64-dvd.iso
ISO_FILE_BASENAME="rhel-server-7.9-x86_64-dvd"
ISO_SHA256_CHECKSUM=19d653ce2f04f202e79773a0cbeda82070e7527557e814ebbce658773fbe8191

# remove spaces
ISO_FILE_SAFENAME=${ISO_FILE_BASENAME// /-}
ISO_MOUNT_PATH="/mnt/${ISO_FILE_SAFENAME}"
ISO_TARGET_PATH="/home/${ISO_FILE_SAFENAME}"

# we need sudo permissions
sudo echo "setting up repo using RHEL installation media (./${ISO_FILE_SAFENAME}.iso or /dev/sr0)"
if [[ $? != 0 ]]; then
    echo "ERROR: need sudo permissions" >> /dev/stderr
    exit 1
fi

# is yum available?
if [[ ! -x "$(command -v yum)" ]]; then
    echo "ERROR: yum not found, wrong os?" >> /dev/stderr
    exit 1
fi

# are we running RHEL 7?
if [[ ! $(uname -r) = *el7* ]]; then
    echo "ERROR: output of uname doesn't look like RHEL 7" >> /dev/stderr
    exit 1
fi

# does repo file exist?
if [[ -f "/etc/yum.repos.d/${ISO_FILE_SAFENAME}.repo" ]]; then
    echo "WARNING: repo file exists, will be overwritten" >> /dev/stderr
fi

# is mount point occupied?
if [[ -d "${ISO_MOUNT_PATH}" ]] && [[ $(ls -A "${ISO_MOUNT_PATH}") ]]; then
    echo "ERROR: mount point (${ISO_MOUNT_PATH}) is already in use" >> /dev/stderr
    exit 1
fi

# is target folder occupied?
if [[ -d "${ISO_TARGET_PATH}" ]] && [[ $(ls -A "${ISO_TARGET_PATH}") ]]; then
    echo "ERROR: target folder (${ISO_TARGET_PATH}) is already in use" >> /dev/stderr
    exit 1
fi

# create mount point
echo "step 1/7: create mount point at [${ISO_MOUNT_PATH}]"
sudo mkdir --parents "${ISO_MOUNT_PATH}"
if [[ $? != 0 ]]; then
    echo "ERROR: unable to create mount point" >> /dev/stderr
    exit 1
fi

# does iso exist at expected path?
echo "step 2/7: mount RHEL installation media"
if [[ ! -f "${ISO_FILE_SAFENAME}.iso" ]]; then
    ISO_SHA256_CHECKSUM=0
fi

# verify checksum (if iso exists)
if [[ ${ISO_SHA256_CHECKSUM} != 0 ]]; then
    echo "found iso file, verifying checksum == ${ISO_SHA256_CHECKSUM}"
    echo "${ISO_SHA256_CHECKSUM} ${ISO_FILE_SAFENAME}.iso" | sha256sum --check -
    if [[ $? != 0 ]]; then
        echo "WARNING: iso checksum verification failed" >> /dev/stderr
        ISO_SHA256_CHECKSUM=0
    fi
fi

# mount iso (if checksum passed)
if [[ ${ISO_SHA256_CHECKSUM} != 0 ]]; then
    echo "mounting iso file"
    sudo mount -o loop "${ISO_FILE_SAFENAME}.iso" "${ISO_MOUNT_PATH}"
    if [[ $? != 0 ]]; then
        echo "WARNING: iso mount failed" >> /dev/stderr
        ISO_SHA256_CHECKSUM=0
    fi
fi

if [[ ${ISO_SHA256_CHECKSUM} == 0 ]]; then
    blkid /dev/sr0
    if [[ $? != 0 ]]; then
        echo "ERROR: unable to find ISO or DVD" >> /dev/stderr
        exit 1
    fi

    echo "physical dvd found"
    sudo mount /dev/sr0 "${ISO_MOUNT_PATH}"
    if [[ $? != 0 ]]; then
        echo "ERROR: dvd mount failed" >> /dev/stderr
        exit 1
    fi
fi

# copy data
echo "step 3/7: copy data"
sudo cp -R "${ISO_MOUNT_PATH}" /home
if [[ $? != 0 ]]; then
    echo "ERROR: copy failed" >> /dev/stderr
    exit 1
fi

# unmount
echo "step 4/7: unmount RHEL installation media"
sudo umount "${ISO_MOUNT_PATH}"
if [[ $? != 0 ]]; then
    echo "ERROR: unmount failed" >> /dev/stderr
    exit 1
fi

# setup repo (updated repofile from https://access.redhat.com/solutions/3776721)
echo "step 5/7: create repo file"
sudo tee /etc/yum.repos.d/${ISO_FILE_SAFENAME}.repo << EOF
[InstallMedia]
name=DVD for RHEL 7.9 Server
mediaid=1600369739.509793
metadata_expire=-1
gpgcheck=1
cost=500
enabled=1
baseurl=file://${ISO_TARGET_PATH}/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

EOF
if [[ $? != 0 ]]; then
    echo "ERROR: repo file creation failed" >> /dev/stderr
    exit 1
fi

echo "step 6/7: chmod repo file"
sudo chmod 644 "/etc/yum.repos.d/${ISO_FILE_SAFENAME}.repo"
if [[ $? != 0 ]]; then
    echo "ERROR: repo file chmod failed" >> /dev/stderr
    exit 1
fi

# update yum
echo "step 7/7: reset yum"
sudo yum clean all
if [[ $? != 0 ]]; then
    echo "ERROR: yum clean failed" >> /dev/stderr
    exit 1
fi

sudo subscription-manager clean
if [[ $? != 0 ]]; then
    echo "WARNING: subscription-manager clean failed" >> /dev/stderr
fi

sudo yum update
if [[ $? != 0 ]]; then
    echo "ERROR: yum update failed" >> /dev/stderr
    exit 1
fi

# done!
echo "DONE!"
