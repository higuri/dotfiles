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

# git related commands:
export GIT_WORKTREE_NAME=git-worktrees
# add new git-worktree with new branch
function gitaw {
    GIT_ROOT_DIR=`git rev-parse --show-toplevel`
    echo "git worktree add -b $1 ${GIT_ROOT_DIR}/${GIT_WORKTREE_NAME}/$1"
    git worktree add -b "$1" "${GIT_ROOT_DIR}/${GIT_WORKTREE_NAME}/$1"
}
# list git-worktrees
function gitlw {
    echo "git worktree list"
    git worktree list
}
# change directory to the specified git-worktreee
function gitcw {
    GIT_ROOT_DIR=`git rev-parse --show-toplevel`
    echo "cd ${GIT_ROOT_DIR}/${GIT_WORKTREE_NAME}/$1"
    cd "${GIT_ROOT_DIR}/${GIT_WORKTREE_NAME}/$1"
    echo "git branch"
    git branch
}
# remove git-worktree and branch if fully merged
function gitrw {
    if [[ $(git branch --merged | grep "$1") ]]; then
        echo "git worktree remove $1"
        git worktree remove "$1"
        echo "git branch -d $1"
        git branch -d "$1"
    else
        echo "$1 is not fully merged."
    fi
}
# `gitaw` and `gitcw`
function gitacw {
    gitaw "$1" && gitcw "$1"
}

# emacs-like keybind (<: ^a / >: ^e)
 bindkey -e
# vi-like keybind
#bindkey -v
# history completion with Ctrl-P/N
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# zplug
# install: curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "mollifier/cd-gitroot"
# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
#  printf "Install? [y/N]: "
#  if read -q; then
    echo; zplug install
#  fi
fi
# then, source plugins and add commands to $PATH
zplug load

# zplugin configuration
# - cd-gitroot
alias gr='cd-gitroot'
# - zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"

# include device specific config (not under source control)
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# launch tmux
#if [[ -z "$TMUX" ]]; then
#    tmux
#fi
