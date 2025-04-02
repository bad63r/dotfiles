#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# [ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

alias l='ls'
alias ll='ls -la'
alias fastfetch='fastfetch --color blue'

#export PATH="/home/bad63r/.local/bin:/usr/lib/qt6/bin:$PATH"
export QT_FORCE_STDERR_LOGGING=1
export QT_LOGGING_RULES="org.kde.plasma.kicker=true"

