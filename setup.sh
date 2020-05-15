#!/usr/bin/env bash
# create symlinks from `~` to desired items in `~/dotfiles`

# dotfiles directory
DOTFILES_DIR=~/dotfiles
if [[ -d ${DOTFILES_DIR} ]]; then
    # old dotfiles backup directory
    backup_dir=${DOTFILES_DIR}/backup--$(date +"%Y-%m-%d--%H-%M-%S")
    mkdir -p ${backup_dir}
else
    git clone --depth 1 https://github.com/averykhoo/dotfiles.git ${DOTFILES_DIR}
fi

# list of files/folders to symlink in homedir
FILENAMES=".bashrc .curlrc .wgetrc .nano .nanorc"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in ${FILENAMES}
do
    if [[ ! -f "${DOTFILES_DIR}/${file}" ]] && [[ ! -d "${DOTFILES_DIR}/${file}" ]]; then
        echo "${DOTFILES_DIR}/${file} does not exist"

    elif cmp --silent "~/${file}" "${DOTFILES_DIR}/${file}"; then
        mv "~/${file}" "${backup_dir}/${file}"
        ln -s "${DOTFILES_DIR}/${file}" "~/${file}"

    fi
done

unset FILENAMES

unset DOTFILES_DIR