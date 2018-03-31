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

## Command shortnames
alias vscode='code'

## Config file
alias aliases='vim ~/.bash_aliases'

alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias inputrc='vim ~/.inputrc'

## Refresh shell
alias refresh="exec \$SHELL"

## Common commands in single characters
alias l='ls -lAh'
alias q='exit'
alias r='refresh'
# vim: syntax=sh
# vim: set ts=2 sw=2 tw=80 et :
