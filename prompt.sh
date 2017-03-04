# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

_venv () {
    [[ -n ${VIRTUAL_ENV} ]] || return
    echo "| %F{red}${VIRTUAL_ENV:t} %F{blue}"
}

_zsh_git () {
    local ref
    local st
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    [[ -n $(git status --porcelain 2> /dev/null) ]] && st="*" || st=""
    echo "%F{cyan} ${ref#refs/heads/}${st} %F{blue}|"
}

_name () {
    echo "%F{cyan}%n%F{yellow}@%F{cyan}%m%F{blue}"
}

_path () {
    echo "%F{yellow}%d%F{blue}"
}

_date () {
    echo "%F{green}%D{"%I:%M"}%F{blue}"
}
PROMPT=\
$'%F{blue}┌──[ $(_name) ]──[ $(_path) ]\n'\
$'%F{blue}└──[$(_zsh_git) $(_date) $(_venv)]───╼ %F{white}'
