# binds Ctrl-T, Alt-C, Ctrl-R
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -d ~/.zplug ]] || {
  curl -sL get.zplug.sh | zsh
  source ~/.zplug/zplug && zplug update --self
}
source ~/.zplug/init.zsh

# Make sure to use double quotes to prevent shell expansion
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "felixr/docker-zsh-completion", nice:10
zplug "zsh-users/zsh-completions", nice:10
#zplug "plugins/bundler",    from:oh-my-zsh, as:plugin
#zplug 'Tarrasch/zsh-autoenv'
ENHANCD_DISABLE_HYPHEN=1
ENHANCD_DISABLE_DOT=1
ENHANCD_USE_FUZZY_MATCH=0
zplug "b4b4r07/enhancd", use:init.sh
#zplug "durandom/enhancd", at:fix_disable_hyphen, use:init.sh
zplug "supercrabtree/k"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

# Install plugins that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

# use vim as the visual editor
export VISUAL='vim'
export EDITOR=$VISUAL

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

ensure_tmux_is_running

zstyle ':completion:*' menu select

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# added by travis gem
[ -f /home/hild/.travis/travis.sh ] && source /home/hild/.travis/travis.sh
