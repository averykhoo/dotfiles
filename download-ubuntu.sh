#!/usr/bin/env bash

# we (probably) don't need sudo permissions
echo "downloading all the things"

# java
echo "Downloading JDK 11.0.7"
# https://www.oracle.com/webfolder/s/digest/11-0-7-checksum.html
CHECKSUM=a7334a400fe9a9dbb329e299ca5ebab6ec969b5659a3a72fe0d6f981dbca0224
if [[ ! -f jdk-11.0.7_linux-x64_bin.tar.gz ]]; then
    echo "Acquiring java from Adobe's legally questionable but very helpful mirror"
    # https://www.adobe.com/support/coldfusion/downloads.html
    wget http://download.macromedia.com/pub/coldfusion/java/java11/1107/jdk-11.0.7_linux-x64_bin.tar.gz
else
    echo "jdk installer found"
fi
if echo "$CHECKSUM jdk-11.0.7_linux-x64_bin.tar.gz" | sha256sum --check -; then
    echo "Downloaded and verified sha256 hash, finally actually installing java"
else
    echo "ERROR: java checksum failed!"
fi
unset CHECKSUM


# download everything else

echo "Downloading browsh"
if ls browsh_*_linux_amd64.deb 1> /dev/null 2>&1; then
    echo "found installer"
else
    curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
     | jq -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.deb")) | .browser_download_url' \
     | wget -i -
fi

echo "Downloading chrome"
if ls google-chrome-stable_current_amd64.deb 1> /dev/null 2>&1; then
    echo "found installer"
else
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
fi

echo "Downloading tigervnc server"
RELEASE="tigervnc-1.11.0.x86_64"
if [[ ! -f ${RELEASE}.tar.gz ]]; then
    wget -O ${RELEASE}.tar.gz https://bintray.com/tigervnc/stable/download_file?file_path=${RELEASE}.tar.gz
fi
