#!/usr/bin/env bash

# we need sudo permissions
if [[ ! -x "$(command -v java)" ]] || [[ $(java -version 2>&1) == *"OpenJDK"* ]]; then
    sudo echo "installing java"

    # is yum available?
    if [[ -x "$(command -v yum)" ]]; then
        echo "Installing JDK 11.0.7"

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
            sudo yum install -y jdk-11.0.7_linux-x64_bin.rpm
            sudo rm jdk-11.0.7_linux-x64_bin.rpm
        else
            echo "ERROR: java checksum failed!"
        fi
        unset CHECKSUM
        rm jdk-11.0.7_linux-x64_bin.rpm

    # is apt available?
    elif [[ -x "$(command -v apt)" ]]; then
        echo "Installing JDK 11.0.7"

        echo "Preparing install directory"
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EA8CACC073C3DB2A
        sudo add-apt-repository -y ppa:linuxuprising/java
        sudo apt update
        sudo mkdir --parents /var/cache/oracle-jdk11-installer-local/

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
            sudo cp jdk-11.0.7_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/
            sudo apt install -y oracle-java11-installer-local
            sudo rm /var/cache/oracle-jdk11-installer-local/jdk-*_linux-x64_bin.tar.gz
            sudo apt install -y oracle-java11-set-default-local
        else
            echo "ERROR: java checksum failed!"
        fi
        unset CHECKSUM
        rm jdk-11.0.7_linux-x64_bin.tar.gz

    else
        echo "apt and yum not found, cannot install"
    fi

else
    echo "java already installed"
fi