# brambu .bashrc

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

if [ -d ~/.bash ] ; then
  [ -f ~/.bash/local ]  && source ~/.bash/local ||touch ~/.bash/local 
else
  mkdir -p ~/.bash ; touch ~/.bash/local
fi

if [ "$(whoami)" == "root" ] ; then
  PS1="\[\e[34;22m\][\[\e[34;1m\]\t\[\e[34;22m\]]\[\e[31;1m\]\u\[\e[34;22m\]@\[\e[31;22m\]\h\[\e[34;22m\]: \[\e[0;1m\]\w \[\e[0m\]
$ "
else
  PS1="\[\e[34;22m\][\[\e[34;1m\]\t\[\e[34;22m\]]\[\e[32;1m\]\u\[\e[34;22m\]@\[\e[32;22m\]\h\[\e[34;22m\]: \[\e[0;1m\]\w \[\e[0m\]
$ "
fi 
export PS1

#history hacks
export HISTTIMEFORMAT='[%F %T %Z] '
unset HISTFILESIZE
HISTSIZE=500000
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND
set -o vi
shopt -s histappend
COLOR_ARG=$([ "$(uname)" == "Darwin" ] && echo "-G" || echo "--color")
alias ls='ls $COLOR_ARG'
alias ll='ls -lF'
alias grep='grep --color'
alias pp='python -mjson.tool'

