# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "cannot run as shell script" 1>&2
    return 1
fi

if which rbenv >/dev/null; then eval "$(rbenv init - zsh)"; fi
if which direnv >/dev/null; then eval "$(direnv hook zsh)"; fi
if which pyenv >/dev/null; then
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init -)"
fi
if which colordiff >/dev/null; then alias diff='colordiff -u'; export LESS='-R'; fi
if which hub >/dev/null; then eval "$(hub alias -s)"; fi
