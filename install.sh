#!/usr/bash

# Backup
pushd ~ > /dev/null
cp .bashrc ".bashrc_backup_$(date +%Y%m%d)"
cp .vimrc ".vimrc_backup_$(date +%Y%m%d)"
cp .screenrc ".screenrc_backup_$(date +%Y%m%d)"
popd > /dev/null

# Install
cp .bashrc ~
cp .screenrc ~
cp .vimrc ~
