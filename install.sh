#!/bin/bash

# Backup
if [ $# -eq 0 ] || [ $1 != "-f" ]; then
    pushd ~ > /dev/null
    if [ -f .bashrc ]; then
        mv .bashrc ".bashrc~$(date +%Y%m%d)"
    fi
    if [ -f .vimrc ]; then
        mv .vimrc ".vimrc~$(date +%Y%m%d)"
    fi
    if [ -f .gitconfig ]; then
        mv .gitconfig ".gitconfig~$(date +%Y%m%d)"
    fi
    if [ -f .tmux.conf ]; then
        mv .tmux.conf ".tmux.conf~$(date +%Y%m%d)"
    fi
    if [ -f .ideavimrc ]; then
        mv .ideavimrc ".ideavimrc~$(date +%Y%m%d)"
    fi
    popd > /dev/null
fi

# Install (Create symlinks).
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc

# Load
source ./load.sh
