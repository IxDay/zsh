_blue () {
    echo "%{\e[0;34m%}"
}

_venv () {
    local env=$(virtualenv_prompt_info)
    if [ ! -z "$env" ]; then
        echo "| %{\e[0;31m%}${env:1:-1} $(_blue)"
    fi
}

_zsh_git () {
    ZSH_THEME_GIT_PROMPT_PREFIX=""
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    local git=$(git_prompt_info)
    if [ ! -z "$git" ]; then
        echo "%{\e[0;36m%} $git $(_blue)|"
    fi
}

_name () {
    echo "%{\e[0;36m%}%n%{\e[0;33m%}@%{\e[1;36m%}%m$(_blue)"
}

_path () {
    echo "%{\e[0;33m%}%d$(_blue)"
}

_date () {
    echo "%{\e[0;32m%}%D{"%I:%M"}$(_blue)"
}

PROMPT=\
"$(_blue)┌──[ $(_name) ]──[ $(_path) ]
$( _blue)└──[$(_zsh_git) $(_date) $(_venv)]───╼ %F{white}"
