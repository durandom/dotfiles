#  Load profiler to debug startup
# http://jb-blog.readthedocs.io/en/latest/posts/0032-debugging-zsh-startup-time.html
# uncomment the following line to enable profiling
# zmodload zsh/zprof
# at the uncomment the zprof line
# the run:
#    time  zsh -i -c exit


# enable verbose logging
# set -x

# OS specific settings

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

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# binds Ctrl-T, Alt-C, Ctrl-R
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# show the profiler output
# zprof