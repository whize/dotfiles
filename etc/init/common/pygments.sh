#!/bin/bash

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/vital.sh

if has "pygmentize"; then
    log_pass "pygmentize: already installed"
    exit
fi

if ! has "pip"; then
    log_fail "error: require: pip"
    exit 1
fi

if ! has "pygmentize"; then
    if sudo pip install Pygments; then
        log_pass "pygmentize: installed successfully"
    else
        log_fail "error: pygmentize: failed to install"
    fi

    log_echo "install pygments-style-solarized ..."
    #pip install pygments-style-solarized
fi

