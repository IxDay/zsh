# https://stackoverflow.com/questions/21038903/path-variable-in-zshenv-or-zshrc/34244862
# https://bbs.archlinux.org/viewtopic.php?id=180845
# https://bugs.archlinux.org/task/35966
export VISUAL="nvim"
export EDITOR="$VISUAL"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Move as many as possible inside CONFIG_HOME
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export TEXINPUTS=".:$XDG_CONFIG_HOME/latex:$TEXINPUTS"
export ANDROID_SDK_HOME="/opt/android-sdk"
export ANDROID_HOME="$ANDROID_SDK_HOME"
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/gimp"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RANDFILE="$XDG_DATA_HOME/rnd"
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export HELM_HOME="$XDG_CONFIG_HOME/helm"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export PATH="${XDG_DATA_HOME}/../bin:$PATH:$GOBIN"

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
