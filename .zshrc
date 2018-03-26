# .zshrc

# LANG
export LANG=ja_JP.UTF-8
# EDITOR
export EDITOR=vim
# PROMPT
export PROMPT='[%F{green}%~%f]
$ '

# Enable tab completion
autoload -Uz compinit
compinit
autoload colors
colors

# History config.
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# setopt ...
setopt auto_pushd
setopt pushd_ignore_dups
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt interactive_comments

# Define aliases and functions
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias ....='cd .. && cd .. && cd ..'
alias psa='ps -a'
alias b='cd -'
alias e='vim'
alias r='vim -R'
alias gt='cd ~/tmp'
alias o='open'
alias a='date "+%Y/%m/%d %H:%M:%S" >> ~/log.txt && vim "+ normal Go" "+ startinsert" ~/log.txt'
alias t='vim "+ normal Go" "+ startinsert" ~/todo.txt'
alias te='open -a TextEdit'
alias -g L='| less'
alias -g G='| grep'

function g { grep "$@" `find . -type f -name "*.*"`; }
if [[ $OSTYPE == darwin* ]]; then
    function lsa { command ls -ltrAFG "$@"; }
    # abbreviated version of dircolors-solarized.
    # not so good...
    #export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
else
    function lsa { command ls -ltrAF --color=auto "$@"; }
    if [ ! -d ~/dircolors-solarized ]; then
        git clone https://github.com/seebi/dircolors-solarized
    fi
    eval `dircolors ~/dircolors-solarized/dircolors.256dark`
fi

# TODO
#bindkey '"\C-n": history-search-forward'
#bindkey '"\C-p": history-search-backward'

# emacs-like keybind
bindkey -e

# cheet sheet...
# screen:
#   vertical split: <c-j> + S
#   horizontal split: <c-j> + |
#   -> create new screen: <c-j> + <c-n>
# vim:set ft=zsh :
