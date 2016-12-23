# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "cannot run as shell script" 1>&2
    return 1
fi

# b4b4r07/emoji-cli
if is_linux; then
    export EMOJI_CLI_FILTER=peco
fi


# jenegunn/fzf
export FZF_DEFAULT_OPTS='
--extended
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'
