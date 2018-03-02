# .bashrc

# load defalt(pre-installed) bashrc
if [ -f ~/.bashrc_default ]; then
    source ~/.bashrc_default
fi

#export PAGER=lv
export EDITOR=vim

# Prompt String(Overwrite default)
export PS1='\[\033[01;33m\]\u@debian\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
# ls colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

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
# for linux
# function lsa { command ls -ltrAF --color=auto "$@"; redecho "\t\t--- `pwd` --- "; }
# for mac
function lsa { command ls -ltrAFG "$@"; redecho "\t\t--- `pwd` --- "; }
function grepy { grep "$@" `find . -name "*.py"`; }
function ghg { grep -R --exclude-dir=.hg "$@"; }
function gg { grep -R "$@"; }
function vman { (man "$@" > ~/tmp/_man_$@.tmp) && vim ~/tmp/_man_$@.tmp && rm ~/tmp/_man_$@.tmp; }


# cheet sheet...
# screen:
#   vertical split: <c-j> + S
#   horizontal split: <c-j> + |
#   -> create new screen: <c-j> + <c-n>
