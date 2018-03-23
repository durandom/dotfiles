#@IgnoreInspection BashAddShebang
# emacs mode
bindkey -e

#bindkey -d


# Ctrl-R
#_peco-select-history() {
#    if true; then
#        BUFFER="$(
#        history \
#            | sort -k1,1nr \
#            | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' \
#            | fzf --query "$LBUFFER"
#        )"
#
#        CURSOR=$#BUFFER
##        zle accept-line
#        #zle clear-screen
#        zle reset-prompt
#    else
#        if is-at-least 4.3.9; then
#            zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
#        else
#            history-incremental-search-backward
#        fi
#    fi
#}
#zle -N _peco-select-history
#bindkey '^r' _peco-select-history

do-enter() {
    if [[ -n $BUFFER ]]; then
        zle accept-line
        return $status
    fi

    : ${ls_done:=false}
    : ${git_ls_done:=false}

    if [[ $PWD != $GIT_OLDPWD ]]; then
        git_ls_done=false
    fi

    echo
    if is_git_repo; then
        if $git_ls_done; then
            if [[ -n $(git status --short) ]]; then
                git status
            fi
        else
            ${=aliases[ls]} && git_ls_done=true
            GIT_OLDPWD=$PWD
        fi
    else
        if [[ $PWD != $OLDPWD ]] && ! $ls_done; then
            ${=aliases[ls]} && ls_done=true
        fi
    fi

    zle reset-prompt
}
zle -N do-enter
bindkey '^m' do-enter

peco-select-gitadd() {
    local selected_file_to_add
    selected_file_to_add="$(
    git status --porcelain \
        | perl -pe 's/^( ?.{1,2} )(.*)$/\033[31m$1\033[m$2/' \
        | fzf --ansi --exit-0 \
        | awk -F ' ' '{print $NF}' \
        | tr "\n" " "
    )"

    if [ -n "$selected_file_to_add" ]; then
        BUFFER="git add $selected_file_to_add"
        CURSOR=$#BUFFER
        zle accept-line
    fi
    zle reset-prompt
}
zle -N peco-select-gitadd
bindkey '^x^a' peco-select-gitadd

exec-oneliner() {
    local oneliner_f
    oneliner_f="${ONELINER_FILE:-$HOME/.command.list}"

    [[ ! -f $oneliner_f || ! -s $oneliner_f ]] && return

    local cmd q k res accept
    while accept=0; cmd="$(
        cat <$oneliner_f \
            | sed -e '/^#/d;/^$/d' \
            | perl -pe 's/^(\[.*?\]) (.*)$/$1\t$2/' \
            | perl -pe 's/(\[.*?\])/\033[31m$1\033[m/' \
            | perl -pe 's/^(: ?)(.*)$/$1\033[30;47;1m$2\033[m/' \
            | perl -pe 's/^(.*)([[:blank:]]#[[:blank:]]?.*)$/$1\033[30;1m$2\033[m/' \
            | perl -pe 's/(!)/\033[31;1m$1\033[m/' \
            | perl -pe 's/(\|| [A-Z]+ [A-Z]+| [A-Z]+ )/\033[35;1m$1\033[m/g' \
            | fzf --ansi --multi --no-sort --tac --query="$q" \
            --print-query --expect=ctrl-v --exit-0
            )"; do
        q="$(head -1 <<< "$cmd")"
        k="$(head -2 <<< "$cmd" | tail -1)"
        res="$(sed '1,2d;/^$/d;s/[[:blank:]]#.*$//' <<< "$cmd")"
        [ -z "$res" ] && continue
        if [ "$k" = "ctrl-v" ]; then
            vim "$oneliner_f" < /dev/tty > /dev/tty
        else
            cmd="$(perl -pe 's/^(\[.*?\])\t(.*)$/$2/' <<<"$res")"
            if [[ $cmd =~ "!$" || $cmd =~ "! *#.*$" ]]; then
                accept=1
                cmd="$(sed -e 's/!.*$//' <<<"$cmd")"
            fi
            break
        fi
    done

    local len
    if [[ -n $cmd ]]; then
        BUFFER="$(tr -d '@' <<<"$cmd" | perl -pe 's/\n/; /' | sed -e 's/; $//')"
        len="${cmd%%@*}"
        CURSOR=${#len}
        if [[ $accept -eq 1 ]]; then
            zle accept-line
        fi
    fi
    #zle reset-prompt
    zle redisplay
}
zle -N exec-oneliner
bindkey '^x^x' exec-oneliner

# handy keybindings
#bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# change to source directory
cds() {
  local dir
  dir=$(ls  ~/src/ | fzf +m) && cd "$HOME/src/$dir"
}
