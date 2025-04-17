# Initialize sheldon - config is at ~/.config/sheldon/config.toml
[ -f ~/.config/sheldon/plugins.toml ] && eval "$(sheldon source)"

# FZF
FZF_CTRL_R_OPTS='--sort' # --exact'
FZF_DEFAULT_COMMAND='fd --type f'
FZF_DEFAULT_OPTS='
--extended
--inline-info
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'
source <(fzf --zsh)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh