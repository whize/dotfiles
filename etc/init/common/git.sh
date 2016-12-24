#!/bin/bash

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

. "$DOTPATH"/etc/lib/vital.sh

if ! has "git"; then
    # Install git
    case "$(get_os)" in
        osx)
            if has "brew"; then
                log_echo "Install git with Homebrew"
                brew install git
            elif "port"; then
                log_echo "Install git with MacPorts"
                sudo port install git
            else
                log_fail "error: require: Homebrew or MacPorts"
                exit 1
            fi
            ;;

        linux)
            if has "yum"; then
                log_echo "Install git with Yellowdog Updater Modified"
                sudo yum -y install git
            elif "port"; then
                log_echo "Install git with Advanced Packaging Tool"
                sudo apt-get -y install git
            else
                log_fail "error: require: YUM or APT"
                exit 1
            fi
            ;;

        *)
            log_fail "error: tihs script is only supported osx and linux"
            exit 1
            ;;
    esac
fi

log_pass "git: installed successfully"

