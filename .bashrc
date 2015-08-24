# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias vi=vim
alias grep='egrep -i --color=auto'

export HISTSIZE=10000
export HISTFILESIZE=10000
