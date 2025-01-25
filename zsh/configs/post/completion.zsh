# from https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/completion.zsh
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# turn of - breaks multiline powerlevel9k
if false; then
  expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
    print -Pn "%{%F{red}......%f%}"
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

# from https://github.com/b4b4r07/dotfiles/blob/93c479ace77ba123a4ed6b42a4787350b90c1553/.zsh/70_misc.zsh
# Important
zstyle ':completion:*:default' menu select=2

# Completing Grouping
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' group-order original corrections

# Completing misc
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions /opt/homebrew/share/zsh/site-functions $fpath)


# init completion
autoload -Uz compinit && compinit -u

source <(fzf --zsh)

if [ $commands[jira] ]; then
  source <(jira completion zsh)
fi

# aws
#source /usr/bin/aws_zsh_completer.sh

# source <(kubectl completion zsh)
# if oc is available, load its completion
if [ $commands[oc] ]; then
  source <(oc completion zsh)
fi
if [ $commands[kam] ]; then
  source <(kam completion zsh)
fi

# nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
# This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# aichat
# _aichat_zsh() {
#     if [[ -n "$BUFFER" ]]; then
#         local _old=$BUFFER
#         BUFFER+="⌛"
#         zle -I && zle redisplay
#         BUFFER=$(aichat -e "$_old")
#         zle end-of-line
#     fi
# }
# zle -N _aichat_zsh
# # bind to ctrl k
# bindkey '^k' _aichat_zsh
# # bindkey '\ee' _aichat_zsh
