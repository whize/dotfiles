# Check whether the vital file is loaded
if ! vitalize 2>/dev/null; then
    echo "cannot run as shell script" 1>&2
    return 1
fi

alias p="print -l"

# For mac, aliases
if is_osx; then
    has "qlmanage" && alias ql='qlmanage -p "$@" >&/dev/null'
    alias gvim="open -a MacVim"
fi

if has 'git'; then
    alias gst='git status'
fi

if has 'richpager'; then
    alias cl='richpager'
fi

alias ..='cd ..'
alias ld='ls -ld'
alias lla='ls -lAF'
alias ll='ls -lF'
alias la='ls -AF'

alias cp="${ZSH_VERSION:+nocorrect} cp -i"
alias mv="${ZSH_VERSION:+nocorrect} mv -i"

alias du='du -h'
alias job='jobs -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if has 'colordiff'; then
    alias diff='colordiff -u'
else
    alias diff='diff -u'
fi

alias vi="vim"

alias nvim='vim -N -u NONE -i NONE'

# Global aliases
alias -g G='| grep'
alias -g GG='| multi_grep'
alias -g W='| wc'
alias -g X='| xargs'
alias -g F='| "$(available $INTERACTIVE_FILTER)"'
alias -g S="| sort"
alias -g V="| tovim"
alias -g N=" >/dev/null 2>&1"
alias -g N1=" >/dev/null"
alias -g N2=" 2>/dev/null"
alias -g VI='| xargs -o vim'

# finder
alias f='fzf \
    --bind="ctrl-l:execute(less {})" \
    --bind="ctrl-h:execute(ls -l {} | less)" \
    --bind="ctrl-v:execute(vim {})"'
alias -g F='$(f)'

# list git branch
git_branch() {
    is_git_repo || return
    has "fzf"   || return

    {
        git branch | sed -e '/^\*/d'
        git branch | sed -n -e '/^\*/p'
    } \
        | reverse \
        | fzy \
        | sed -e 's/^\*[ ]*//g'
}

alias -g GB='$(git_branch)'

git_modified_files() {
    is_git_repo || return

    local cmd q k res ok
    while ok=("${ok[@]:-dummy_$RANDOM}"); cmd="$(
        git status --po \
            | awk '$1=="M"{print $2}' \
            | FZF_DEFAULT_OPTS= fzf --ansi --multi --query="$@" \
            --no-sort --prompt="[C-a:add | C-c:checkout | C-d:diff]> " \
            --print-query --expect=ctrl-d,ctrl-a,ctrl-c \
            --bind=ctrl-z:toggle-all \
            )"; do
        q="$(head -1 <<< "$cmd")"
        k="$(head -2 <<< "$cmd" | tail -1)"
        res="$(sed '1,2d;/^$/d' <<< "$cmd")"
        [ -z "$res" ] && continue
        case "$k" in
            ctrl-c)
                if [[ ${(j: :)ok} == ${(j: :)${(@f)res}} ]]; then
                    git checkout -- "${(@f)res}"
                    ok=()
                else
                    ok=("${(@f)res}")
                fi
                ;;
            ctrl-a)
                git add "${(@f)res}"
                ;;
            ctrl-d)
                git diff "${(@f)res}" < /dev/tty > /dev/tty
                ;;
            *)
                echo "${(@f)res}" < /dev/tty > /dev/tty
                break
                ;;
        esac
    done
}

#alias ls='gls --color=auto -F'
alias ls='ls -G'
