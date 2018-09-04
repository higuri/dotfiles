#!/bin/bash
# load.sh

# [*sh]
# TODO

# [tmux]
tmux source-file ~/.tmux.conf

# [vim] install vim plugins (call vundle:PluginInstall).
vim +PluginInstall +qall
