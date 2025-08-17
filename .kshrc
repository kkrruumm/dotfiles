COLUMNS=300

PATH="$HOME/.config/emacs/bin:$PATH"
CDPATH=".:$HOME/Documents"

alias ls='ls --color=auto'
#PS1='($?) \u@\h \W > '
PS1='\e[1;37m($?) \e[1;32m\u@\h \e[1;37m\W > \e[m'
HISTFILE="$HOME/.ksh_history"
HISTSIZE=

printf "%s\n\n" "$(fortune)"
