# brambu .zshrc

autoload -Uz promptinit
promptinit

typeset -U path
path=(~/bin /opt/local/bin $path)

if [ -d ~/.zsh ] ; then
  [ -f ~/.zsh/local ]  && source ~/.zsh/local ||touch ~/.zsh/local 
else
  mkdir -p ~/.zsh ; touch ~/.zsh/local
fi
if [ ! -d ~/.zsh/fsh ] ; then
    mkdir -p ~/.zsh
    (cd ~/.zsh; git clone https://github.com/zdharma/fast-syntax-highlighting fsh)
fi
if [ -d ~/.zsh/fsh ] ; then
    source ~/.zsh/fsh/F-Sy-H.plugin.zsh
    fast-theme -q free
fi

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

if [[ "$(uname)" == "Darwin" ]]; then
  alias ls='ls -G'
else;
  alias ls='ls --color'
fi

alias ll='ls -l'
alias grep='grep --color'

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

COMPLETION_WAITING_DOTS=true

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi
if [[ "$DISABLE_CORRECTION" == "true" ]]; then
  return
else
  setopt correct_all
  alias man='nocorrect man'
  alias mv='nocorrect mv'
  alias mysql='nocorrect mysql'
  alias mkdir='nocorrect mkdir'
  alias gist='nocorrect gist'
  alias heroku='nocorrect heroku'
  alias ebuild='nocorrect ebuild'
  alias hpodder='nocorrect hpodder'
  alias sudo='nocorrect sudo'
fi

# Changing/making/removing directory
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

autoload -U colors && colors

local lastcmd="%(?,%{${reset_color}%}%{${fg[green]}%}:%)%{${reset_color}%},%{${reset_color}%}%{${fg[yellow]}%}%? %{${fg[red]}%}:(%{${reset_color}%})%{${reset_color}%}"
RPROMPT="%{${reset_color}%}%{${fg[blue]}%}[%{${fg_bold[blue]}%}$(tty)%{${fg[blue]}%}]%{${reset_color}%}"

PROMPT="%{${fg_no_bold[blue]}%}[%{${fg_bold[blue]}%}%D{%H:%M:%S}%{${fg_no_bold[blue]}%}]%{${reset_color}%} \
%{${fg_bold[green]}%}%n%{${fg[blue]}%}@%{${fg_no_bold[green]}%}%m%{${reset_color}%} \
%{${fg_bold[white]}%}%~%{${reset_color}%} \
%{${fg[blue]}%}[%{${fg_no_bold[magenta]}%}%j%{${fg[blue]}%}]%{${reset_color}%} %{${fg[blue]}%}(${lastcmd}%{${fg[blue]}%})%{${reset_color}%} 
%{${fg_bold[white]}%}%#%{${reset_color}%} "

