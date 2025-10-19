# .bashrc

export PATH="$HOME/.config/emacs/bin:$PATH"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# infinite bash history
export HISTFILESIZE=
export HISTSIZE=

# time codes in bash `history`
#HISTTIMEFORMAT="%F %T "

alias ls='ls --group-directories-first --color=auto'
alias grep="grep --color=auto"
PS1='($?) \u@\h \W > '
#PS1='\e[1;37m($?) \e[1;32m\u@\h \e[1;37m\W > \e[m'

printf "%s\n\n" "$(fortune)"
