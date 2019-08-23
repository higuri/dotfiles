# .zshrc

# PATH
export PATH=/usr/local/bin:$PATH:$HOME/npm_global/bin/
# LANG
export LANG=ja_JP.UTF-8
# PROMPT (multi-lines)
export PROMPT='[%F{yellow}%~%f]
$ '
# EDITOR
export EDITOR=vim

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
setopt no_beep
setopt no_flow_control
setopt interactive_comments
setopt print_eight_bit

# tmpdir
TMPDIR=$HOME/tmp
if [ ! -d $TMPDIR ]; then
    mkdir $TMPDIR
fi

# Define aliases and functions
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias ....='cd .. && cd .. && cd ..'
alias a='date "+%Y/%m/%d %H:%M:%S" >> ~/log.txt && vim "+ normal Go" "+ startinsert" ~/log.txt'
alias b='cd -'
alias e='vim'
alias r='vim -R'
alias t='vim "+ normal Go" "+ startinsert" ~/todo.txt'
alias gt='cd $TMPDIR'
alias gg='cd $(git rev-parse --show-toplevel 2> /dev/null || hg root 2> /dev/null || echo .)'
alias psa='ps -a'
if [[ $OSTYPE == darwin* ]]; then
    alias o='open'
    alias te='open -a TextEdit'
elif [[ $OSTYPE == linux-gnu ]]; then
    alias o='xdg-open'
fi

function g {
    grep -r "$@" .
}
function ge {
    files=$(grep -r -l "$@" .)
    echo $files
    vim $(echo $files | paste -s -d " " -)
}
function cpt {
    cp $@ $TMPDIR
}
function mvt {
    mv $@ $TMPDIR
}
function gitwt {
    git worktree add -b "$1" "./git-worktrees/$1"
}
if [[ $OSTYPE == darwin* ]]; then
    function lsa { command ls -ltrAFG "$@" }
    # abbreviated version of dircolors-solarized.
    # not so good...
    #export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
else
    function lsa { command ls -ltrAF --color=auto "$@" }
    if [ ! -d ~/dircolors-solarized ]; then
        git clone https://github.com/seebi/dircolors-solarized
    fi
    eval `dircolors ~/dircolors-solarized/dircolors.256dark`
fi
alias l='lsa'

# emacs-like keybind
bindkey -e
# history completion with Ctrl-P/N
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# include device specific config (not under source control)
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# launch tmux
if [[ -z "$TMUX" ]]; then
    tmux
fi
