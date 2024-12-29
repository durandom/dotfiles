# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#@IgnoreInspection BashAddShebang
#
# Load profiler to debug startup
# http://jb-blog.readthedocs.io/en/latest/posts/0032-debugging-zsh-startup-time.html
#    time  zsh -i -c exit
#zmodload zsh/zprof

# install via homebrew
if [ -d /opt/homebrew/opt/zplug ]; then
  export ZPLUG_HOME=/opt/homebrew/opt/zplug
fi
if [ -d /home/linuxbrew/.linuxbrew/opt/zplug ]; then
  export ZPLUG_HOME=/home/linuxbrew/.linuxbrew/opt/zplug
fi

if [[ -f $ZPLUG_HOME/init.zsh ]]; then
  export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
  source $ZPLUG_HOME/init.zsh

  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
        echo; zplug install
      fi
      echo
  fi
  zplug load
fi

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

#ensure_tmux_is_running

zstyle ':completion:*' menu select
# somehow this is needed, otherwise g would not autocomplete
source ~/.zsh/completion/_g

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# more completions
# if [ $commands[oc] ]; then
#   source <(oc completion zsh)
# fi
# source <(oc completion zsh)

# Local config
export FZF_CTRL_R_OPTS='--sort' # --exact'
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# binds Ctrl-T, Alt-C, Ctrl-R
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /home/hild/.travis/travis.sh ] && source /home/hild/.travis/travis.sh

# show profiling output
#zprof
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
