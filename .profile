#!/bin/sh

export FZF_DEFAULT_OPS='--color=16 --layout=reverse'
# should be the defaults.

## XDG Base Directory specification

# See also:
#
# original spec               https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# Arch wiki article           https://wiki.archlinux.org/index.php/XDG_Base_Directory
# a guide to HOME protection  https://zdsfa.com/insert/blog/a-guide-to-home-protection/

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# export GOPATH="$XDG_DATA_HOME/go" # go # commented out because it caused problems.

export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"             # ack
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"        # docker
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"    # readline
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"  # mysql
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"       # pass
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"                 # tmux

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

## Standard

export EDITOR=vi VISUAL=vi # defers to $(which vi)
export LANG=en_US.UTF-8
export PAGER=less

### $PATH

PATH="/usr/local/go/bin:${PATH}"                           # Go install
PATH="$(go env GOPATH)/bin:${PATH}"                        # Go binaries (this is bad)
test -n "$CARGO_HOME" && PATH="${CARGO_HOME}/bin:${PATH}"  # Rust binaries

PATH="${HOME}/.local/bin:${PATH}" # Miscellaneous, Python's pip for example

PATH="${HOME}/bin:${PATH}"                          # Personal executables
PATH="${HOME}/bin/$(uname -s):${PATH}"              # Kernel specific
PATH="${HOME}/bin/$(uname -s)+$(uname -m):${PATH}"  # Kernel+architecture specific
PATH="${HOME}/bin/$(uname -n):${PATH}"              # Host specific

export PATH
