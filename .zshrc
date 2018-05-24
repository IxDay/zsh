alias ls='ls --color'
alias la='ls -lAh'
alias ll='ls -lh'
alias sudo='sudo -E'
alias _='sudo -E'
alias svim='sudo -E nvim'
alias vim='nvim'
alias grep='grep --color=always --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias less='less -R'
alias jq='jq -C'
alias server='python3 -m http.server'
alias sshi='ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null'
alias sshp='ssh -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no'
alias scpi='scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null'

alias dockerr='docker run --rm -ti'
alias dockerip='docker inspect -f "{{.NetworkSettings.IPAddress}}"'
alias dockerrm='docker rm $(docker ps -qa)'
alias dockerrmi='docker rmi $(docker images | awk '\''$1 ~ /\<none\>/ {print $3}'\'')'
alias dockerrmv='docker volume rm $(docker volume ls -qf dangling=true)'
alias dockerps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}"'
alias cd='HOME=${PROJECT:-$HOME} cd'

[ -f "/var/lib/proxydriver/environment.sh" ] && . "/var/lib/proxydriver/environment.sh"
export PATH="$(dirname "$XDG_DATA_HOME")/bin:$PATH"


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
            rsync -avz --delete \
			-e "ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null" \
			--exclude=.v --exclude=.git --exclude=.direnv --exclude=.envrc \
				$(pwd) "$1" &> /dev/null
        done
    ) & echo $! > .sync.lock
}

setopt appendhistory autocd extendedglob nomatch prompt_subst kshglob
unsetopt beep notify

autoload -Uz compaudit compinit up-line-or-beginning-search down-line-or-beginning-search

compinit -i -d "${ZDOTDIR}/.zcompdump"

# menu selection
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# https://wiki.archlinux.org/index.php/zsh#History_search
#
export HISTFILE=~/.config/zsh/.histfile
export HISTSIZE=10000
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

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

bindkey -e # emacs mode

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^u' backward-kill-line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Add support for https://direnv.net/
eval "$(direnv hook zsh)"

export KEYTIMEOUT=1
source "${ZDOTDIR}/prompt.sh"

