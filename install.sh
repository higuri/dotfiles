#!/bin/bash

# Backup
if [ $# -eq 0 ] || [ $1 != "-f" ]; then
    pushd ~ > /dev/null
    if [ -f .zshrc ]; then
        mv .zshrc ".zshrc~$(date +%Y%m%d)"
    fi
    if [ -f .vimrc ]; then
        mv .vimrc ".vimrc~$(date +%Y%m%d)"
    fi
    if [ -f .tmux.conf ]; then
        mv .tmux.conf ".tmux.conf~$(date +%Y%m%d)"
    fi
    popd > /dev/null
fi

# Install (Create symlinks).
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf 
ln -sf ~/dotfiles/.vimrc ~/.vimrc 

# Load
source ./load.sh
