#!/bin/sh -e

test -n "$TMUX" &&
test -f "${HOME}/.bashrc" &&
source "${HOME}/.bashrc"
