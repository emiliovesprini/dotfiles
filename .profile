#!/bin/sh

## Aliases

alias batsrs='BATS_RUN_SKIPPED=true bats'
alias clear="printf ''" # to get rid of a bad habit.
alias pwgen='pwgen --no-capitalize --numerals --secure --num-passwords=1'
alias sheck=shellcheck posixcheck='shellcheck --shell=sh'
alias xo=xdg-open

lsopts='-1'
command ls --version >/dev/null && lsopts="${lsopts} --color=auto --sort=v"
alias ls="ls ${lsopts}"

## Functions

aptsearch() {
        apt search "$@" | $PAGER
}

vimrc() {
        vim "${HOME}/.vimrc"
        # Do a hacky ''dry run'' to make sure I didn't write any errors into the config:
        vim -c 'q'
}

### Docs

godoc() {
        go doc "$@" | $PAGER
}

info() {
        command info --subnodes "$@" | $PAGER
}

man() {
        manopts=''
        command man --version >/dev/null && manopts="${manopts} --no-hyphenation --no-justification"
        MANWIDTH="$(80orless)" command man ${manopts} "$@"
}

### Recommended by programs

fff() {
        # Like command fff,
        # but runs cd on current directory on quit.
        #
        # From https://github.com/dylanaraps/fff#bash-and-zsh
        # Modified to
        # * be called 'fff', just like command fff
        # * be shellcheck compliant
        # * fail gracefully if command fff isn't in $PATH
        if ! command -v 'fff' >/dev/null; then
                printf "Error: command fff is unavailable.\n" 1>&2
                exit 1
        fi
        command fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:="${HOME}/.cache"}/fff/.fff_d")" || exit
}

## Global variables

export FZF_DEFAULT_OPS='--color=16 --layout=reverse'
# should be the defaults.

### XDG Base Directory specification

# See also:
#
# original spec               https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# Arch wiki article           https://wiki.archlinux.org/index.php/XDG_Base_Directory
# a guide to HOME protection  https://zdsfa.com/insert/blog/a-guide-to-home-protection/

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

#### Enforce adherence

export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"             # ack
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"        # docker
export GOPATH="$XDG_DATA_HOME"/go                     # go
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"    # readline
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"  # mySQL
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"       # pass
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"                 # Tmux

# less
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"

# nodeJS and NPM
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"    # cargo
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"  # rustup

# Xorg's Xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME/xorg/xcompose"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/xorg/xcompose"

### Standard

export EDITOR=vi VISUAL=vi
export LANG=en_US.UTF-8
export PAGER=less

#### $PATH

test -n "$CARGO_HOME" && PATH="${CARGO_HOME}/bin:${PATH}" # Rust binaries
test -n "$GOPATH" && PATH="${GOPATH}/bin:${PATH}" # Go binaries
PATH="${HOME}/.local/bin:${PATH}" # Miscellaneous, Python's pip for example

# Personal executables
PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/bin/$(uname -s):${PATH}" # Kernel specific
PATH="${HOME}/bin/$(uname -s)+$(uname -m):${PATH}" # Kernel+architecture specific
PATH="${HOME}/bin/$(uname -n):${PATH}" # Host specific

export PATH
