# .bashrc
# yhigu

# load defalt(pre-installed) bashrc
if [ -f ~/.bashrc_default ]; then
    source ~/.bashrc_default
fi

#export PAGER=lv
export EDITOR=vim

# Prompt String
# generated by http://bashrcgenerator.com/
export PS1="\[\033[38;5;231m\][\[$(tput sgr0)\]\[\033[38;5;220m\]\w\[$(tput sgr0)\]\[\033[38;5;231m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]"

# Alias
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

bind '"\C-n": history-search-forward'
bind '"\C-p": history-search-backward'

# Function
function yelecho { command echo -e "\033[33m$@\033[m"; }
function grnecho { command echo -e "\033[32m$@\033[m"; }
function redecho { command echo -e "\033[31m$@\033[m"; }

function g { grep "$@" `find . -type f -name "*.*"`; }
function gg { grep -R "$@"; }
function ghg { grep -R --exclude-dir=.hg "$@"; }
function vman { (man "$@" > ~/tmp/_man_$@.tmp) && vim ~/tmp/_man_$@.tmp && rm ~/tmp/_man_$@.tmp; }
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

# cheet sheet...
# screen:
#   vertical split: <c-j> + S
#   horizontal split: <c-j> + |
#   -> create new screen: <c-j> + <c-n>
