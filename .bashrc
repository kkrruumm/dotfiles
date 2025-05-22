export PATH="$HOME/.config/emacs/bin:$PATH"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

printf "%s\n\n" "$(fortune)"
