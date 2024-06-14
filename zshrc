source ~/.drv.profile
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf initialization
export FZF_BASE=~/.fzf

# Load prompt and other utilities
autoload -U promptinit; promptinit
autoload -U colors && colors
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i

# Custom functions and aliases
autoload zmv zcalc take
alias zcp='zmv -C' zln='zmv -L'

# Options
setopt AUTO_NAME_DIRS
setopt autocd autopushd cdable_vars extended_glob ksh_glob

# Directory shortcuts
hash -d inc=~/work/inc
hash -d me=~/work/me
hash -d tmp=~/tmp

# histdb settings
HISTDB_FZF_DEFAULT_MODE=4
bindkey '^R' histdb-fzf-widget

# vi mode settings
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)
bindkey '^l' clear-screen                        # Clear screen

# fzf-tab settings
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

# Prompt configuration
setopt PROMPT_SUBST
PROMPT='%{$fg_bold[white]%}%(4~|../%2~|%~)%{$fg_bold[yellow]%}➤ %{$reset_color%}'

# Autocompletion
for file in ~/.zsh.d/*.autocomplete; do source $file ; done

# Load plugins
source ~/.config/zplug/init.zsh
zplug "agkozak/zsh-z", defer:2
zplug "m42e/zsh-histdb-fzf", defer:2, from:github, at:main
zplug "larkery/zsh-histdb", defer:2, from:github, at:main
zplug "Aloxaf/fzf-tab", defer:2, from:github, at:main
zplug load

