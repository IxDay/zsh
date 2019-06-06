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
alias scpi='/usr/bin/scp -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null'
alias rsync='rsync --exclude ".vscode" --exclude ".venv" --exclude ".direnv" --exclude ".git" --delete'
alias dg='dirs -v | grep'

alias dockerr='docker run --rm -ti'
alias dockerip='docker inspect -f "{{.NetworkSettings.IPAddress}}"'
alias dockerrm='docker rm $(docker ps -qa)'
alias dockerrmi='docker rmi $(docker images | awk '\''$1 ~ /\<none\>/ {print $3}'\'')'
alias dockerrmv='docker volume rm $(docker volume ls -qf dangling=true)'
alias dockerps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}"'
alias cd='HOME=${PROJECT:-$HOME} cd'
alias tmux='/usr/bin/tmux  -f $HOME/.config/tmux/tmux.conf'
alias gok='ps aux | grep "[/]tmp/go" | tr -s " " | cut -d" " -f2 | xargs kill'
