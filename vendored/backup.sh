#!/usr/bin/env bash

# todo: consider a flag for making the backup read-only

if [[ $# -eq 1 ]]; then
    cp -pvi "$1" "${1}.copied--$(date +'%Y-%m-%d--%H-%M-%S').bak"
else
    echo "Info:     $0 clones a target file to a backup copy"
    echo "Usage:    $0 <file to be backed up with .bak extension>"
    echo "Example: '$0 important-file.txt' would create a backup called important-file.txt.copied--2022-02-22--20:22:02.bak"
fi
