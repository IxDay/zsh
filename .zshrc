alias ls="ls --color"
alias la="ls -lAh"
alias ll="ls -lh"
alias sudo="sudo -E"
alias _="sudo"
alias svim="sudo -E nvim"
alias vim="nvim"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias jq="jq -C"
alias sshi="ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"
alias scpi="scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"
alias drun="docker run --rm -ti"

function sync() {
    [ -e .sync.lock ] && echo "sync is already running!" && return 1
    (
        inotifywait -rqme close_write,create . | while read
        do
            rsync -avz --delete --exclude=.v --exclude=.git $(pwd) "$1" &> /dev/null
        done
    ) & echo $! > .sync.lock
}

HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=5000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
zstyle :compinstall filename '/home/max/.config/zsh/.zshrc'

fpath=(${ZDOTDIR} $fpath)
autoload -Uz compaudit compinit promptinit up-line-or-beginning-search down-line-or-beginning-search

compinit -i -d "${ZDOTDIR}/.zcompdump"
source "${ZDOTDIR}/lib.sh"

setopt COMPLETE_ALIASES

# history search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^u' backward-kill-line
bindkey '^d' beginning-of-line
bindkey '^e' end-of-line

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%F{green} [% VIM]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

source "${ZDOTDIR}/prompt.sh"
