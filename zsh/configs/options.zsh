autoload -U colors
colors

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extended_glob

# Allow [ or ] whereever you want
unsetopt nomatch

# remove / from WORDCHARS
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
autoload -U select-word-style
select-word-style bash

# No Beep
setopt no_beep
setopt no_list_beep
setopt no_hist_beep

# Show exit status if it's except zero.
setopt print_exit_value

# Confirm when executing 'rm *'
setopt rm_star_wait

# Let me know immediately when terminating job
setopt notify

# Show process ID
setopt long_list_jobs

# Resume when executing the same name command as suspended process name
setopt auto_resume

# If the path is directory, add '/' to path tail when generating path by glob
setopt mark_dirs

setopt always_last_prompt
setopt auto_cd
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt complete_in_word
setopt globdots
setopt interactive_comments
setopt list_types
setopt magic_equal_subst
