#!/bin/bash
# load.sh

# [tmux]
tmux source-file ~/.tmux.conf

# [vim] install vim plugins (call vundle:PluginInstall).
vim +PluginInstall +qall

# [*sh]
# TODO
echo "Done! You should run 'source [.bashrc or .zshrc]'."

