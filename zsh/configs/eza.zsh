if ! (( $+commands[eza] )); then
  print "eza-plugin: eza not found on path. Please install eza before using this plugin." >&2
  return 1
fi

alias ls='eza --group-directories-first --icons --color-scale=all --color-scale-mode=gradient'

# Show in tree view
alias lt='ls --tree --level=2'

# Short, all files
alias l='ls --all'
# Short, only directories
alias ld='l --only-dirs'

# Long, file size prefixes, git status
alias ll='ls --long --binary --group --smart-group --links --git'
# Long, all files, . & ..
alias la='ll --all --all'

# Long, sort changed
alias lC='la --sort=changed'
# Long, sort modified
alias lM='la --sort=modified'
# Long, sort size
alias lS='la --sort=size'
# Long, sort extension
alias lX='la --sort=extension'