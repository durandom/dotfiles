# Initialize completion system BEFORE sheldon loads fzf-tab
# fzf-tab requires compinit to have run first (it copies _main_complete function)

# load our own completion functions
fpath=(~/.zsh/completion ~/.zfunc /usr/local/share/zsh/site-functions /opt/homebrew/share/zsh/site-functions $fpath)

# init completion
autoload -Uz compinit && compinit -u
