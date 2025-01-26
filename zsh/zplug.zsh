# #@IgnoreInspection BashAddShebang

# zplug "zplug/zplug", hook-build:'zplug --self-manage'
# #zplug "b4b4r07/emoji-cli", on:"junegunn/fzf-bin", if:'(( $+commands[jq] ))'

# ENHANCD_DISABLE_HYPHEN=1
# ENHANCD_DISABLE_DOT=1
# ENHANCD_USE_FUZZY_MATCH=1
# ENHANCD_FILTER="fzf --height 40%"
# ENHANCD_ENABLE_DOUBLE_DOT=false
# zplug "b4b4r07/enhancd", use:init.sh
# zplug "zsh-users/zsh-history-substring-search", defer:3
# zplug "zsh-users/zsh-syntax-highlighting", defer:2

# #zplug "b4b4r07/zsh-vimode-visual", use:"*.zsh", defer:3
# #zplug "b4b4r07/zsh-vimode-visual", defer:3

# zplug "mafredri/zsh-async"

# # completions
# zplug "zsh-users/zsh-completions"
# zplug "felixr/docker-zsh-completion", defer:3
# #zplug "glidenote/hub-zsh-completion"
# compdef -d play # disable completion for play command, we want to use sox completion
# zplug 'Valodim/zsh-curl-completion'
# zplug "zsh-users/zsh-autosuggestions"
# zplug "cpitt/zsh-dotenv", as:plugin


# # zplug "sindresorhus/pure"
# #POWERLEVEL9K_MODE='awesome-fontconfig'
# #POWERLEVEL9K_MODE='default'
# #POWERLEVEL9K_MODE='nerdfont-complete'
# #zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# zplug romkatv/powerlevel10k, as:theme, depth:1

# # colors
# zplug marlonrichert/zcolors
# # zcolors >| ~/.zcolors
# source ~/.zcolors

# DIRCOLORS_SOLARIZED_ZSH_THEME="256dark"
# zplug "pinelibg/dircolors-solarized-zsh"