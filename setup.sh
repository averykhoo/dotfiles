#!/usr/bin/env bash
# create symlinks from `~` to desired items in `~/dotfiles`


# dotfiles directory
dotfiles_dir=~/dotfiles
if [[ -d ${dotfiles_dir} ]]; then
    # old dotfiles backup directory
    backup_dir=${dotfiles_dir}/backup--$(date +"%Y-%m-%d--%H-%M-%S")
    mkdir -p ${backup_dir}
else
    echo "Unable to find dotfiles, exiting."
    return
fi

# list of files/folders to symlink in homedir
filenames=".bashrc .curlrc .wgetrc .nano .nanorc"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in ${filenames}
do
    if [[ ! -f "${dotfiles_dir}/${file}" ]]
    then
        echo "${dotfiles_dir}/${file} does not exist"

    elif cmp --silent "~/${file}" "${dotfiles_dir}/${file}"
    then
        mv "~/${file}" "${backup_dir}/${file}"
        ln -s "${dotfiles_dir}/${file}" "~/${file}"

    fi

done
