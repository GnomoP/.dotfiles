#!/bin/bash

## Enable color support for some commands
if [[ -x /usr/bin/dircolors ]]; then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME"/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  alias ls='ls --color=always'
  alias dir='dir --color=always'
  alias vdir='vdir --color=always'

  alias grep='grep --color=always'
  alias fgrep='fgrep --color=always'
  alias egrep='egrep --color=always'
fi

## Directory listing
alias la='ls -A'
alias ll='ls -l'

## Quick and dirty one-liners
alias freeram='free && sync && echo 3 > /proc/sys/vm/drop_caches && free'
alias dirfiles='l | grep -v ^d | grep -v ^t | wc -l'

## Nicknames and shortnames
alias wvim='wvim-term'
alias dpush='dotfiles-push'
alias vscode='code'

## Commonly edited config files
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias inputrc='vim ~/.inputrc'
alias srcinit='vim ~/.srcinit'
alias aliases='vim ~/.bash_aliases'
alias gitignore='vim ./.gitignore'

## Refresh shell
alias refresh="REFRESH_SHELL='true' exec \$SHELL"

## Commonly used commands in only one or two characters
alias e='echo'
alias g='git'
alias gc='git clone'
alias gl='git ls-tree --full-tree'
alias gp='git pull'
alias l='ls -lAh'
alias L='less -F'
alias p='dotfiles-push -w'
alias pf='printf'
alias q='exit'
alias r='refresh'
alias v='vim'
alias wv='wvim'
# vim: syntax=sh
# vim: set ts=2 sw=2 tw=80 et :
