#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias HD='cd /mnt/HD'
export PATH=~/.npm-global/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/share/nvm/init-nvm.sh" ] && \. "/usr/share/nvm/init-nvm.sh"


# Added by Antigravity CLI installer
export PATH="/home/carlos/.local/bin:$PATH"
