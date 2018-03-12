#!/bin/bash

# Backup & Remove.
pushd ~ > /dev/null
if [ -f .bashrc ]; then
    mv .bashrc ".bashrc~$(date +%Y%m%d)"
fi
if [ -f .vimrc ]; then
    mv .vimrc ".vimrc~$(date +%Y%m%d)"
fi
if [ -f .screenrc ]; then
    mv .screenrc ".screenrc~$(date +%Y%m%d)"
fi
popd > /dev/null

# Install (Create symlinks).
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.screenrc ~/.screenrc 
ln -sf ~/dotfiles/.vimrc ~/.vimrc 

# Install vim plugins (call vundle:PluginInstall).
vim +PluginInstall +qall
