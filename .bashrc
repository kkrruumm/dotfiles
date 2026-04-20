# .bashrc

# export PATH="$HOME/.config/emacs/bin:$PATH"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# infinite bash history
export HISTFILESIZE=
export HISTSIZE=

# time codes in bash `history`
#HISTTIMEFORMAT="%F %T "

alias ls='ls --group-directories-first --color=auto'
alias grep="grep --color=auto"

alias v="vim"
alias m="man"
alias c="cat"
alias e="emacsclient -t"
alias g="gcc"
alias b="btop"

PS1='($?) \h $([ "$PWD" != "$HOME" ] && printf "%s" "../")\W > '

printf "%s\n\n" "$(fortune)"
