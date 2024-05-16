source ~/.drv.profile
source ~/.config/zplug/init.zsh

# Load plugins
zplug "agkozak/zsh-z"
zplug "m42e/zsh-histdb-fzf", from:github, at:main
zplug "larkery/zsh-histdb", from:github, at:main
zplug "Aloxaf/fzf-tab", from:github, at:main

if ! zplug check; then
    zplug install
fi
zplug load

export FZF_BASE=~/.fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U promptinit; promptinit
autoload U colors && colors
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i

autoload zmv zcalc take
alias zcp='zmv -C' zln='zmv -L'

setopt AUTO_NAME_DIRS
setopt autocd autopushd cdable_vars extended_glob ksh_glob

# Dirs
hash -d inc=~/work/inc
hash -d me=~/work/me

# Autocompletion
source <(awless completion zsh)
source <(helm completion zsh)
complete -o nospace -C /usr/bin/terraform terraform
complete -C '~/.local/bin/aws_completer' aws

# histdb
HISTDB_FZF_DEFAULT_MODE=4
bindkey '^R' histdb-fzf-widget

# vi mode
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)
bindkey '^l' clear-screen # Clear screen

# fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:make:*:targets' call-command true
zstyle ':completion:*' menu select

setopt PROMPT_SUBST
PROMPT='%{$fg_bold[white]%}%(4~|../%2~|%~)%{$fg_bold[yellow]%}➤ %{$reset_color%}'
