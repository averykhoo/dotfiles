#!/usr/bin/env bash
# create symlinks from `~` to desired items in `~/dotfiles`

# dotfiles directory and backup directory
DOTFILES_DIR=~/dotfiles
BACKUP_DIR=${DOTFILES_DIR}/backup--$(date +"%Y-%m-%d--%H-%M-%S")
if ! [[ -d ${DOTFILES_DIR} ]]; then
    echo "cloning dotfiles repo from github..."
    git clone --depth 1 https://github.com/averykhoo/dotfiles.git ${DOTFILES_DIR}
fi

# list of files/folders to symlink in homedir
FILENAMES=".bashrc .bash_aliases .curlrc .inputrc .lessfilter .wgetrc .nano .nanorc"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
cd ~
for file in ${FILENAMES}
do
    if [[ ! -e "${DOTFILES_DIR}/${file}" ]]; then
        echo "${DOTFILES_DIR}/${file} does not exist"

    elif ! cmp --silent "${file}" "${DOTFILES_DIR}/${file}"; then
        if [[ -e "${file}" ]]; then
            mkdir -p ${BACKUP_DIR}
            echo "backing up existing ${file}"
            mv "${file}" "${BACKUP_DIR}/${file}"
        fi
        ln -s "${DOTFILES_DIR}/${file}" "${file}"

    else
        echo "${file} is equivalent to the current version"

    fi
done

# special case for rhel 7 because nano is super old
if [[ -x "$(command -v yum)" ]]; then
    if [[ ! $(uname -r) = *el8* ]]; then
        echo "using legacy settings for nano"
        rm ".nanorc"
        ln -s "${DOTFILES_DIR}/.nanorc-legacy" ".nanorc"
        rm ".nano"
        ln -s "${DOTFILES_DIR}/.nano-legacy" ".nano"
    fi
fi

# cleanup
unset FILENAMES
unset DOTFILES_DIR

source ~/.bashrc
