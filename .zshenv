export VISUAL="nvim"
export EDITOR="$VISUAL"

# Move as many as possible inside CONFIG_HOME
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
export TEXINPUTS=".:$XDG_CONFIG_HOME/latex:$TEXINPUTS"
export ANDROID_SDK_HOME="$XDG_DATA_HOME/android"
export ANDROID_HOME="$ANDROID_SDK_HOME"
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/gimp"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export RANDFILE="$XDG_DATA_HOME/rnd"

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
