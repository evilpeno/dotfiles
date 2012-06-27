#!/bin/zsh
# Author: Nick Brooks <evilpeno@gmail.com>
# shamelessly stole snippets from Seth House
# 
# Integrated the git status from
# https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/zshrc.sh

# Setup some colors that I like

fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_white=%{$'\e[1;37m'%}
#Attributes
at_normal=%{$'\e[0m'%}
 
PROMPT='
${fg_dgray}%n@%m${fg_white}[${fg_cyan}%~${fg_white}] $(git_super_status)
[${fg_dgray}%T${fg_white}]:${at_normal}'

# {{{ set us up some options
autoload edit-command-line 
autoload -U compinit
compinit
 
setopt \
        auto_cd \
        auto_pushd \
        chase_links \
        noclobber \
        complete_aliases \
        extended_glob \
        hist_ignore_all_dups \
        hist_ignore_space \
        share_history \
        no_flow_control \
        list_types \
        mark_dirs \
        path_dirs \
        prompt_percent \
        prompt_subst \
        rm_star_wait \
	append_history
 
# }}}
# {{{ environment stuffs

path+=( $HOME/bin /sbin /usr/sbin /usr/local/sbin ); path=( ${(u)path} );

HISTFILE=~/.zsh_history
HISTFILESIZE=65536
HISTSIZE=4096
SAVEHIST=4096

REPORTTIME=60 # Report time statistics for progs that take more than a minute to run
WATCH=notme # Report any login/logout of other users
WATCHFMT='%n %a %l from %m at %T.'

# utf-8 setup
LANG=en_US.UTF-8
LC_ALL=$LANG
LC_COLLATE=C

EDITOR=vim
export EDITOR
alias editor=$EDITOR

# Set grep to ignore SCM directories
if ! $(grep --exclude-dir 2> /dev/null); then
GREP_OPTIONS="--color --exclude-dir=.svn --exclude=\*.pyc --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=.git --exclude=tags"
else
GREP_OPTIONS="--color --exclude=\*.svn\* --exclude=\*.pyc --exclude=\*.hg\* --exclude=\*.bzr\* --exclude=\*.git\* --exclude=tags"
fi
export GREP_OPTIONS

# }}}
case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac


# {{{  completions

compinit -C

zstyle ':completion:*' list-colors "$LS_COLORS"

zstyle -e ':completion:*:(ssh|scp|sshfs|ping|telnet|nc|rsync):*' hosts '
    reply=( ${=${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**} )'

# }}}

#Aliases

alias vi='vim'
alias ls='ls -F --color'
alias l='ls -lFh'
alias la='ls -lAFh'
alias ll='ls -lh'
alias df='df -h'
alias cp='cp -pi'

# Quickly ssh through a bastian host without having to hard-code in ~/.ssh/config
alias pssh='ssh -o "ProxyCommand ssh $PSSH_HOST nc -w1 %h %p"'


# OSX Specific
if [[ $(uname) == "Darwin" ]]; then
alias ls='ls -FG'
    alias lynx='lynx -cfg=$HOME/.lynx.cfg'
    alias top='top -ocpu'
fi

# {{{ joinpdf()
# Merges, or joins multiple PDF files into "joined.pdf"

joinpdf () {
    gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=joined.pdf "$@"
}

# }}

# Output total memory currently in use by you {{{1

memtotaller() {
    /bin/ps -u $(whoami) -o pid,rss,command | awk '{sum+=$2} END {print "Total " sum / 1024 " MB"}'
}

# }}}
# EOF
