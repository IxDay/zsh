_venv () {
    local env=$(virtualenv_prompt_info)
    if [ ! -z "$env" ]; then
        echo "| %F{red}${env:1:-1} %F{blue}"
    fi
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
