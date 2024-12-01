export PATH="$HOME/.config/emacs/bin:$PATH"
export SSH_AUTH_SOCK=/run/user/${UID}/keyring/ssh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

echo -e "$(fortune)\n"
