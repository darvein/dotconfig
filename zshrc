#source ~/.config/zplug/init.zsh
fpath=(~/.zsh/completion $fpath)
fpath=(~/.zsh.d/ $fpath)

source ~/.drv.profile
#source ~/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/modules/zsh-z.plugin.zsh

export FZF_BASE=~/.fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.config/fzf-tab/fzf-tab.plugin.zsh

autoload -U promptinit; promptinit
autoload U colors && colors
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit -i

autoload zmv zcalc take
alias zcp='zmv -C' zln='zmv -L'

# zsh history
source ~/.config/zsh/plugins/zsh-histdb/sqlite-history.zsh
source ~/.config/zsh/plugins/zsh-histdb-fzf/fzf-histdb.zsh
HISTDB_FZF_DEFAULT_MODE=4
autoload -Uz add-zsh-hook

# zsh apps
#zplug 'm42e/zsh-histdb-skim', from:github, at:main
#bindkey '^R' histdb-skim-widget

# correctiosn
setopt correct
export SPROMPT="Correct %R to %r? [Yes, No, Abort, Edit] "

setopt AUTO_NAME_DIRS
setopt autocd autopushd cdable_vars extended_glob ksh_glob

# Dirs
hash -d revista=~/work/revista
hash -d morni=~/work/morni

#bindkey '^R' histdb-fzf-widget

# Autocompletion
source <(awless completion zsh)
source <(helm completion zsh)
complete -C '~/.local/bin/aws_completer' aws
complete -o nospace -C /usr/bin/terraform terraform

# vi mode
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
#bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
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

#zstyle ':completion:*' file-list all
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion::complete:make:*:targets' call-command true
zstyle ':completion:*' menu select

setopt PROMPT_SUBST
PROMPT='%{$fg_bold[white]%}%(4~|../%2~|%~)%{$fg_bold[yellow]%}➤ %{$reset_color%}'
#compdef _eb_instances eb_instances

alias luamake=~/tmp/lua-language-server/3rd/luamake/luamake

PATH="~/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="~/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="~/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"~//perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=~/perl5"; export PERL_MM_OPT;
