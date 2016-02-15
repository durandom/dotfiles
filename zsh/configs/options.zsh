# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# remove / from WORDCHARS
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
autoload -U select-word-style
select-word-style bash

