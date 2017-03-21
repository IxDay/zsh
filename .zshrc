alias ls="ls --color"
alias la="ls -lAh"
alias ll="ls -lh"
alias sudo="sudo -E"
alias _="sudo -E"
alias svim="sudo -E nvim"
alias vim="nvim"
alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias jq="jq -C"
alias sshi="ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"
alias scpi="scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"
alias dockerr="docker run --rm -ti"
alias dockerip="docker inspect -f '{{.NetworkSettings.IPAddress}}'"

function sync() {
	case "$1" in
		start)
			shift
			;;
		stop)
			[ ! -e .sync.lock ] && echo "there is no sync running here!" \
				&& return 1
			kill $(cat .sync.lock) && rm .sync.lock
			return 0
			;;
		*)
			echo "Usage: $0 {start|stop} [user@remote:dest]"
			return 1
			;;
	esac

	[ -e .sync.lock ] && [ -d "/proc/$(cat .sync.lock)" ] && \
		echo "sync is already running!" && return 1
    (
        inotifywait -rqme close_write,create . | while read
        do
            rsync -avz --delete --exclude=.v --exclude=.git --exclude=.direnv\
				--exclude=.envrc \
				$(pwd) "$1" &> /dev/null
        done
    ) & echo $! > .sync.lock
}

setopt appendhistory autocd extendedglob nomatch prompt_subst
unsetopt beep notify
bindkey -v

autoload -Uz compaudit compinit up-line-or-beginning-search down-line-or-beginning-search

compinit -i -d "${ZDOTDIR}/.zcompdump"

# menu selection
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# https://wiki.archlinux.org/index.php/zsh#History_search
#
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=5000

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# https://wiki.archlinux.org/index.php/zsh#Dirstack
#
# Usage: dirs -v then cd -<NUM>
#
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS

###### end ######


bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^u' backward-kill-line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line


# https://dougblack.io/words/zsh-vi-mode.html
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%F{green} [% VIM]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Add support for https://direnv.net/
eval "$(direnv hook zsh)"

export KEYTIMEOUT=1
source "${ZDOTDIR}/prompt.sh"

