# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"


eval "$(/opt/homebrew/bin/brew shellenv)"
PATH="$HOME/opt/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
# PATH="/opt/homebrew/opt/node@16/bin:$PATH"
PATH="$HOME/.go/bin:$PATH"
PATH="$HOME/Library/Python/3.11/bin:$PATH"

# Ruby
PATH="$HOME/.rbenv/bin:$PATH"
# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi

# Python
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# NVM
export NVM_DIR="$HOME/.nvm"

# KREW
PATH="${PATH}:${HOME}/.krew/bin"

export -U PATH
