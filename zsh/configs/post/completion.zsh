#unsetopt menu_complete   # do not autoselect the first completion entry
#unsetopt flowcontrol
#setopt auto_menu         # show completion menu on succesive tab press
#setopt complete_in_word
#setopt always_to_end
#
#zmodload -i zsh/complist
#
### case-insensitive (all),partial-word and then substring completion
##if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
##  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
##  unset CASE_SENSITIVE
##else
##  if [ "x$HYPHEN_INSENSITIVE" = "xtrue" ]; then
#    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
##    unset HYPHEN_INSENSITIVE
##  else
##    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
##  fi
##fi
#
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*:*:*:*:*' menu select
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
#if [ "$OSTYPE[0,7]" = "solaris" ]
#then
#  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm"
#else
#  zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
#fi
#
## disable named-directories autocompletion
#zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
#
## Use caching so that commands like apt and dpkg complete are useable
#zstyle ':completion::complete:*' use-cache 1
#zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
#
#
## ... unless we really want to.
#zstyle '*' single-ignored show
#
##if [[ $COMPLETION_WAITING_DOTS = true ]]; then
#  expand-or-complete-with-dots() {
#    # toggle line-wrapping off and back on again
#    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
#    print -Pn "%{%F{red}......%f%}"
#    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam
#
#    zle expand-or-complete
#    zle redisplay
#  }
#  zle -N expand-or-complete-with-dots
#  bindkey "^I" expand-or-complete-with-dots
##fi

# Important
zstyle ':completion:*:default' menu select=2

# Completing Groping
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'
zstyle ':completion:*' group-name ''

# Completing misc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# default: --
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# Menu select
zmodload -i zsh/complist
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
#bindkey -M menuselect '^k' accept-and-infer-next-history

autoload -Uz cdr
autoload -Uz history-search-end
autoload -Uz modify-current-argument
autoload -Uz smart-insert-last-word
autoload -Uz terminfo
autoload -Uz vcs_info
autoload -Uz zcalc
autoload -Uz zmv
autoload -Uz run-help-git
autoload -Uz run-help-svk
autoload -Uz run-help-svn

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

# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
autoload -Uz compinit && compinit -u


# aws
#source /usr/bin/aws_zsh_completer.sh
