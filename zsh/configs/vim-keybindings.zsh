return 0

# Vim-like keybind as default
bindkey -v
# Vim-like escaping jj keybind
bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keybind to viins mode
bindkey -M viins '^F'  forward-char
bindkey -M viins '^B'  backward-char
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^K'  kill-line
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^Y'  yank
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^D'  delete-char
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins "\ef" forward-word
bindkey -M viins "\eb" backward-word
bindkey -M viins "\ed" kill-word
bindkey -M viins "\e^?" backward-kill-word
bindkey -M viins "^X^T" fzf-file-widget

bindkey -M vicmd '^A'  beginning-of-line
bindkey -M vicmd '^E'  end-of-line
bindkey -M vicmd '^K'  kill-line
bindkey -M vicmd '^P'  up-line-or-history
bindkey -M vicmd '^N'  down-line-or-history
bindkey -M vicmd '^Y'  yank
bindkey -M vicmd '^W'  backward-kill-word
bindkey -M vicmd '^U'  backward-kill-line
bindkey -M vicmd '/'   vi-history-search-forward
bindkey -M vicmd '?'   vi-history-search-backward
bindkey -M vicmd "\ef" forward-word
bindkey -M vicmd "\eb" backward-word
bindkey -M vicmd "\ed" kill-word
bindkey -M vicmd "\e^?" backward-kill-word

bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G'  end-of-line

if is-at-least 5.0.8; then
    autoload -Uz surround
    zle -N delete-surround surround
    zle -N change-surround surround
    zle -N add-surround surround
    bindkey -a cs change-surround
    bindkey -a ds delete-surround
    bindkey -a ys add-surround
    bindkey -a S add-surround
fi

# bind P and N for EMACS mode
has 'history-substring-search-up' &&
    bindkey -M emacs '^P' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
has 'history-substring-search-up' &&
    bindkey -M vicmd 'k' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey -M vicmd 'j' history-substring-search-down

# bind P and N keys
has 'history-substring-search-up' &&
    bindkey '^P' history-substring-search-up
has 'history-substring-search-down' &&
    bindkey '^N' history-substring-search-down

# Insert a last word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey -M viins '^]' insert-last-word

# Surround a forward word by single quote
quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-single
bindkey -M viins '^Q' quote-previous-word-in-single

# Surround a forward word by double quote
quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N quote-previous-word-in-double
bindkey -M viins '^Xq' quote-previous-word-in-double

bindkey -M viins "$terminfo[kcbt]" reverse-menu-complete

#bindkey -s 'vv' "!vi\n"
#bindkey -s ':q' "^A^Kexit\n"

#
# functions
#
_delete-char-or-list-expand() {
    if [ -z "$RBUFFER" ]; then
        zle list-expand
    else
        zle delete-char
    fi
}
zle -N _delete-char-or-list-expand
bindkey '^D' _delete-char-or-list-expand
