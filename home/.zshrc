#Binds
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

#Pluggins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Fzf
source <(fzf --zsh)

#Starship Prompt
eval "$(starship init zsh)"

export PATH="$PATH:$HOME/flutter/bin"

export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export CHROME_EXECUTABLE=/usr/bin/brave
export ANDROID_SDK_HOME=$HOME
export ANDROID_AVD_HOME=$HOME/.android/avd

