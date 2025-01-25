#  Load profiler to debug startup
# http://jb-blog.readthedocs.io/en/latest/posts/0032-debugging-zsh-startup-time.html
#    time  zsh -i -c exit
# zmodload zsh/zprof

# enable verbose logging
# set -x

# OS specific settings
# check if we have homebrew of linuxbrew
if [ -d /opt/homebrew ]; then
  export HOME_BREW=/opt/homebrew
fi
if [ -d /home/linuxbrew/.linuxbrew ]; then
  export HOME_BREW=/home/linuxbrew/.linuxbrew
fi

# PATH
#
# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

# Homebrew
if [[ -f $HOME_BREW/bin/brew ]]; then
  eval "$($HOME_BREW/bin/brew shellenv)"
fi

# Initialize sheldon - config is at ~/.config/sheldon/config.toml
[ -f ~/.config/sheldon/plugins.toml ] && eval "$(sheldon source)"
