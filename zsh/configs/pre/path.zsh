# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# Homebrew
# check if linuxbrew is available
if [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
if [ -d /opt/homebrew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
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
# check if pyenv is available
if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
fi
# eval "$(pyenv virtualenv-init -)"

# NVM
export NVM_DIR="$HOME/.nvm"

# KREW
PATH="${PATH}:${HOME}/.krew/bin"

export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

export -U PATH
