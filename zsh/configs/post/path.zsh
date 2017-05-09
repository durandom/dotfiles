# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"

PATH="$HOME/.rbenv/bin:$PATH"
# load rbenv if available
if command -v rbenv >/dev/null; then
  eval "$(rbenv init -)"
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

PATH="$HOME/.git-aliae/bin:$PATH"
PATH="$HOME/opt/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

eval $(minishift oc-env)
if [ $commands[oc] ]; then
  source <(oc completion zsh)
fi

export -U PATH
