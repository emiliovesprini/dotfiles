#!/bin/bash

# If not running interactively,
# stop here:
#
case $- in
        *i*) ;;
        *) return;;
esac

# Aliases, functions and variables
# are in ~/.profile
# so that they're shared with other shells.
# This may be a bad idea,
# maybe the right non-bash-specific place to put them is somewhere else.
test -f "$HOME/.profile" && source "$HOME/.profile"

## Completion scripts

test -f "$HOME/lib/exercism_completion.bash" && source "$HOME/lib/exercism_completion.bash"

## History

export HISTFILE="$XDG_DATA_HOME/bash/history" # for XDG BDS compliance.

export HISTFILESIZE=2000
export HISTSIZE=1000
#
# TODO: how are these different?

## Prompt

# Set variable identifying the chroot you work in
# (used in the prompt below):
#
# TODO: this is cargo culted from old defaults. Is it necessary?
#
test -z "${debian_chroot:-}" &&
test -r '/etc/debian_chroot' &&
debian_chroot=$(cat /etc/debian_chroot)

# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' # Plain
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ' # Color
