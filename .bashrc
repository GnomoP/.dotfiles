#!/bin/bash

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=5000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# Comment for an uncolored prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	  color_prompt=yes
  else
	  color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# Alias definitions.
if [ -f "/root/.bash_aliases" ]; then
  source "/root/.bash_aliases"
fi

# Programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# Additional path for scripts
export PATH="$PATH:/root/bin:./"

# Merge ~/.Xresources
[[ -f "/root/.Xresources" ]] && xrdb -merge '/root/.Xresources'

# Utility functions and some aliases

# Print processes within this terminal
pterm () {
  if [[ -z "$@" ]]; then
    ps axu | grep -E "[0-9]+ pts/$(fgconsole)"
  else
    for i in "$@"; do
      ps axu | grep -E "[0-9]+ pts/$i"
    done
  fi
}

# Shortcut to GnomoP (USB stick)
if [[ -d "/media/root/GnomoP" ]]; then
  ln -sf "/media/root/GnomoP" "/root/usb"
else
  if [[ -s "/root/usb" ]]; then
    rm -f "/root/usb"
  fi
fi

# Some environmental variables
export EDITOR='/usr/bin/vim'
export VISUAL='/usr/bin/code'

# Bindings
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Aliased vim for wvim
if [[ ! -z "$WVIM" ]] && [[ -f "$WVIM" ]]; then
  alias vim="vim -c 'colorscheme onedark'"
fi

# Custom scripts (leave in for last)
/root/scripts/src/_init
# vim: syntax=sh
# vim: set ts=2 sw=2 tw=80 et :
