# vim:ft=zplug ts=4 expandtab

has_plugin() {
    (( $+functions[zplug] )) || return 1
    zplug check "${1:?too few arguments}"
    return $status
}

# Local loading
zplug "zplug/zplug"

zplug "~/.modules", \
    from:local, \
    defer:1, \
    use:"*.sh"

zplug "~/.zsh", \
    from:local, \
    defer:2, \
    use:"<->_*.zsh"
    # use:"<->_*.zsh", \
    # ignore:'40*'

zplug "b4b4r07/zsh-gomi", \
    as:command, \
    use:bin/gomi

zplug "mrowa44/emojify", \
    as:command

zplug "stedolan/jq", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf", \
    frozen:1

zplug "monochromegane/the_platinum_searcher", \
    as:command, \
    from:gh-r, \
    rename-to:"pt", \
    frozen:1

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug "motemen/ghq", \
    as:command, \
    from:gh-r, \
    rename-to:ghq

zplug "b4b4r07/ls.zsh", \
    as:command, \
    use:bin/ls

zplug "b4b4r07/emoji-cli", \
    if:'(( $+commands[jq] ))', \
    on:"junegunn/fzf-bin"

zplug "b4b4r07/enhancd", \
    use:init.sh

zplug "glidenote/hub-zsh-completion"

zplug "b4b4r07/zsh-vimode-visual", \
    use:"*.sh"

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-syntax-highlighting", \
    defer:3

zplug "b4b4r07/peco-tmux.sh", \
    as:command, \
    use:'*.sh', \
    rename-to:'peco-tmux'

zplug "philovivero/distribution", \
    as:command, \
    use:distribution, \
    if:'(( $+commands[perl] ))'

# zplug "mitmproxy/mitmproxy", \
#     as:command, \
#     hook-build:"sudo python ./setup.py install"

zplug "tcnksm/ghr", \
    as:command, \
    from:gh-r

zplug "reorx/httpstat", \
    as:command, \
    use:'httpstat.py', \
    if:'(( $+commands[python] ))', \
    rename-to:'httpstat'

zplug "jhawthorn/fzy", \
    as:command, \
    hook-build:"make && sudo make install"

zplug "Code-Hex/battery", as:command, from:gh-r

#zplug "paulirish/git-open", as:command
zplug "b4b4r07/git-open", as:command, at:patch-1

zplug "b4b4r07/open-link.sh", as:command, use:'*.bash', rename-to:'ol'

zplug "mattn/jvgrep", as:command, from:gh-r
