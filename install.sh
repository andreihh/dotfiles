#!/usr/bin/env bash

# This script will install the dotfiles on the current machine.
#
# It expects the dotfiles to be located in the `~/.dotfiles` directory. It will
# also create a `~/.dotfiles.bak` directory where it will backup existing
# dotfiles before removing them (note, however, that only files and directories
# are backed up; symlinks or other types of files are not backed up).
#
# If the backup of a specific file fails, it will be interactively removed. If
# removal is denied, that specific dotfile will not be installed.
#
# Every dotfile in the home directory is replaced with a symlink to the file in
# the `~/.dotfiles` directory.
#
# If setup for certain files fail at first attempt, you may fix the issues
# manually and then run this script again. Since it only backs up files and
# directories, it will not overwrite previous backups with the created symlinks,
# will relink the old symlinks to the ~/.dotfiles correspondents and attempt to
# install the previously failed files once again.
#
# The `.extras` file is not installed. It should mostly contain local settings,
# like exporting JAVA_HOME from a specified installation directory. You may wish
# to manually copy this file to `~/.extras` and customize it accordingly.
#
# After installing the dotfiles, it will attempt to install required packages by
# various configurations, such as vim plugins.
#
# It will also attempt to compile and install the vim `YouCompleteMe` plugin.

[ $# -gt 0 ] && echo "Usage: $0" && exit 1

dir="$HOME/.dotfiles"
backup_dir="$HOME/.dotfiles.bak"

files=\
".bashrc .bash_profile .bash_logout .bash_aliases .exports bin "\ # basic config
".editorconfig .vimrc .vim .ideavimrc "\ # editors
".gitconfig .gradle" # tools

packages=\
"git build-essential cmake zenity "\ # tools
"python python3 python-dev python3-dev pylint pylint3 "\ # python
"vim vim.gnome-py2 "\ # editors
"openjdk-8-jdk" # JDK

echo "Setting up backup directory '$backup_dir'..." && \
    mkdir -p "$backup_dir" && \
    echo "Backup directory setup completed!" || \
    echo "Backup directory setup failed!"

echo -e "\nSetting execution permission for '$dir/bin' scripts..." && \
    chmod -R 755 "$dir/bin" && \
    echo "Permissions set!" || \
    echo "Failed to set permissions!"

for file in $files; do
    [ ! -e "$dir/$file" ] && \
        echo -e "\nMissing '$file' from '$dir'!" && \
        continue

    echo -e "\nBacking up '$file'..."
    if [ -f "$HOME/$file" ] || [ -d "$HOME/$file" ] && \
        [ ! -L "$HOME/$file" ]; then
            mv -v "$HOME/$file" "$backup_dir/" && \
                echo "Backup successful!" || \
                echo "Backup failed!"
    elif [ -e "$HOME/$file" ]; then
        [ -r "$HOME/$file" ] && \
            echo "'$file' is not a file or directory!" || \
            echo "There is no read permission for '$file'!"
    else
        echo "'$file' can't be backed up because it doesn't exist!"
    fi

    if [ -L "$HOME/$file" ]; then
        echo -e "\nUnlinking old '$file' symlink..." && \
            rm -v "$HOME/$file" && \
            echo "'$file' unlinked!" || \
            echo "Couldn't unlink '$file'!"
    elif [ -e "$HOME/$file" ]; then
        echo -e "\nRemoving old '$file'..." && \
            rm -vrI "$HOME/$file" && \
            echo "'$file' removed!" || \
            echo "Couldn't remove '$file'!"
    fi

    echo -e "\nSetting up symlink for '$file'..."
    if [ ! -e "$HOME/$file" ]; then
        ln -s "$dir/$file" "$HOME/$file" && \
            echo "Symlink setup completed!" || \
            echo "Symlink setup failed!"
    else
        echo "Can't setup symlink because '$file' already exists!"
    fi
done

echo -e "\nInstalling required packages..."

echo -e "\nUpdating package index..." && \
    sudo apt-get update && \
    echo "Package index updated!" || \
    echo "Failed to update package index!"

for package in $packages; do
    echo -e "\nInstalling package '$package'..." && \
        sudo apt-get install $package && \
        echo "Package installed!" || \
        echo "Installation failed!"
done

echo -e "\nInstalling 'YouCompleteMe' vim plugin..." && \
    chmod +x "$dir/.vim/bundle/YouCompleteMe/install.py" && \
    $dir/.vim/bundle/YouCompleteMe/install.py && \
    echo "'YouCompleteMe' installed!" || \
    echo "Failed to install 'YouCompleteMe'!"

echo -e "\nDone!"
