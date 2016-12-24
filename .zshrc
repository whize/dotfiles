
umask 022
limit coredumpsize 0
bindkey -e

if [[ -f ~/.path ]]; then
    source ~/.path
else
    export DOTPATH="${0:A:t}"
fi

if [[ -z $DOTPATH ]]; then
    echo "$fg[red]cannot start ZSH, \$DOTPATH not set$reset_color" 1>&2
    return 1
fi
echo $DOTPATH
export VITAL_PATH="$DOTPATH/.dotfiles/etc/lib/vital.sh"
if [[ -f $VITAL_PATH ]]; then
    source "$VITAL_PATH"
fi

export ENHANCD_FILTER="fzy:$ENHANCD_FILTER"

# Exit if called from vim
[[ -n $VIMRUNTIME ]] && return

# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "$fg[red]cannot vitalize$reset_color" 1>&2
    return 1
fi

$DOTPATH/bin/tmuxx

if [[ -f ~/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE="$HOME/.zsh/zplug.zsh"
	source ~/src/github.com/zplug/zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        else
            echo
        fi
    fi
    echo
    zplug load --verbose
fi

printf "\n$fg_bold[cyan]This is ZSH $fg_bold[red]${ZSH_VERSION}"
printf "$fg_bold[cyan] - DISPLAY on $fg_bold[red]$DISPLAY$reset_color\n\n"

# vim:fdm=marker fdc=3 ft=zsh ts=4 sw=4 sts=4:
