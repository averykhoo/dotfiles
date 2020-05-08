#!/usr/bin/env bash
# create symlinks from `~` to desired items in `~/dotfiles`

# old dotfiles backup directory
old_dir=~/dotfile/bak
mkdir -p ${old_dir}

# dotfiles directory
dotfiles_dir=~/dotfiles

# list of files/folders to symlink in homedir
filenames=".bashrc .curlrc .wgetrc .nano .nanorc"

# change to the dotfiles directory
cd ${dotfiles_dir}

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in ${filenames}; do
    mv ~/${file} ${old_dir}/${file}
    ln -s ${dotfiles_dir}/${file} ~/${file}
done
