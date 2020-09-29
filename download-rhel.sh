#!/usr/bin/env bash

# we (probably) don't need sudo permissions
echo "downloading all the things"

# java
echo "Downloading JDK 11.0.7"
# https://www.oracle.com/webfolder/s/digest/11-0-7-checksum.html
CHECKSUM=0eb9441dfd2be041ca1075842c5335a731e60c6ea2bfb1e947224136098c2670
if [[ ! -f jdk-11.0.7_linux-x64_bin.rpm ]]; then
    echo "Acquiring java from Adobe's legally questionable but very helpful mirror"
    # https://www.adobe.com/support/coldfusion/downloads.html
    wget http://download.macromedia.com/pub/coldfusion/java/java11/1107/jdk-11.0.7_linux-x64_bin.rpm
else
    echo "jdk installer found"
fi
if echo "$CHECKSUM jdk-11.0.7_linux-x64_bin.rpm" | sha256sum --check -; then
    echo "Downloaded and verified sha256 hash, finally actually installing java"
else
    echo "ERROR: java checksum failed!"
fi
unset CHECKSUM


# download everything else

echo "Downloading browsh"
if ls browsh_*_linux_amd64.rpm 1> /dev/null 2>&1; then
    echo "found installer"
else
    curl "https://api.github.com/repos/browsh-org/browsh/releases/latest" \
     | jq -r '.assets[] | select(.name|test("browsh_.*_linux_amd64.rpm")) | .browser_download_url' \
     | wget -i -
fi

echo "Downloading chrome"
if ls google-chrome-stable_current_x86_64.rpm 1> /dev/null 2>&1; then
    echo "found installer"
else
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
fi

echo "Downloading klogg"
if ls klogg-*-Linux.rpm 1> /dev/null 2>&1; then
    echo "found installer"
else
    curl "https://api.github.com/repos/variar/klogg/releases/latest" \
     | jq -r '.assets[] | select(.name|test("klogg-.*-Linux.rpm")) | .browser_download_url' \
     | wget -i -
fi

# todo: does this work?
echo "Downloading micro"
curl https://getmic.ro | bash

echo "Downloading tigervnc server"
RELEASE="tigervnc-1.10.1.x86_64"
if [[ ! -f ${RELEASE}.tar.gz ]]; then
    wget -O ${RELEASE}.tar.gz https://bintray.com/tigervnc/stable/download_file?file_path=${RELEASE}.tar.gz
fi
