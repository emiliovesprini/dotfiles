#!/bin/bash

# If not running interactively, stop:
#
[[ $- == *i* ]] || return
# test -z "$TMUX" && exec tmux

###############

## Aliases and functions
#
# TODO: move where all broadly POSIX compliant shells can reach it.

alias batsrs='BATS_RUN_SKIPPED=true bats'
# alias clear="printf ''" # to get rid of a bad habit.
alias pwgen='pwgen --no-capitalize --numerals --secure --num-passwords=1'
alias sheck=shellcheck posixcheck='shellcheck --shell=sh'
alias xo=xdg-open

lsopts=''
command ls --version >/dev/null && lsopts="${lsopts} --color=auto --sort=v"
alias ls="ls ${lsopts}"

man() {
	manopt=''
	command man --version >/dev/null && manopt="${manopt} --no-hyphenation --no-justification"
	MANOPT="$manopt" MANWIDTH="$(80orless)" command man "$@"
}

vimrc() {
	vim -u NONE -- "${HOME}/.vimrc" # edits vimrc without loading it.
	vim -c 'q' # does a ''dry run'' to catch errors.
}

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
# TODO:
# this is cargo culted from old defaults.
# Is it necessary?
#
test -z "${debian_chroot:-}" &&
test -r '/etc/debian_chroot' &&
debian_chroot=$(cat /etc/debian_chroot)

# PS1='#\n' # Minimal comment
PS1=':; ' # Minimal null
# PS1='# ${debian_chroot:+($debian_chroot)}\u@\h \w \$\n' # Plain comment
# PS1='# ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\] \$\n' # Color comment
# PS1=': ${debian_chroot:+($debian_chroot)}\u@\h \w \$ ; ' # Plain null
# PS1=': ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ; ' # Color null
# PS1=': ${debian_chroot:+($debian_chroot)}\u@\h \w ; '
