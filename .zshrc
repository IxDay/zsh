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
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

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
source /opt/asdf-vm/asdf.sh

# Add support for https://direnv.net/
eval "$(direnv hook zsh)"
eval "$(dircolors ${ZDOTDIR}/dircolors.sh)"

# Add support for https://github.com/pyenv/pyenv
eval "$(pyenv init -)"

# Add support for scaleway CLI
eval "$(scw autocomplete script shell=zsh)"

# Add support for brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source "${ZDOTDIR}/prompt.sh"
source "${ZDOTDIR}/aliases.sh"
source "${ZDOTDIR}/functions.sh"

source /usr/share/nvm/init-nvm.sh

source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
