setopt appendhistory autocd extendedglob nomatch prompt_subst kshglob
unsetopt beep notify

autoload -Uz compaudit up-line-or-beginning-search down-line-or-beginning-search compinit

compinit -i -d "${ZDOTDIR}/.zcompdump"

# menu selection
zstyle ':completion:*' menu select

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

if [ $commands[/usr/bin/kubectl] ]; then
  source <(/usr/bin/kubectl completion zsh)
fi

export KEYTIMEOUT=1

# Add support for https://direnv.net/
eval "$(direnv hook zsh)"
eval "$(dircolors ${ZDOTDIR}/dircolors.sh)"

source "${ZDOTDIR}/prompt.sh"
source "${ZDOTDIR}/aliases.sh"
source "${ZDOTDIR}/functions.sh"
