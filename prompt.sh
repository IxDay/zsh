# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

_venv () {
    [[ -n ${VIRTUAL_ENV} ]] || return
    echo "| %F{red}${VIRTUAL_ENV:t} %F{blue}"
}

_zsh_git () {
    ZSH_THEME_GIT_PROMPT_PREFIX=""
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    local git=$(git_prompt_info)
    if [ ! -z "$git" ]; then
        echo "%F{cyan} $git %F{blue}|"
    fi
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
"%F{blue}┌──[ $(_name) ]──[ $(_path) ]
%F{blue }└──[$(_zsh_git) $(_date) $(_venv)]───╼ %F{white}"
