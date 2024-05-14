# vi: ft=bash

current_script_path=$(realpath "$0")
current_script_directory=$(dirname "$current_script_path")

export LD_PRELOAD=""
export LANG="en_US.UTF-8"
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
export BROWSER=firefox
#export PAGER="vim -M +MANPAGER -"
#export MANPAGER="vim -M +MANPAGER -"
alias vimm="vim -M +MANPAGER -"
#export PAGER=less
#export MANPAGER=less
#export VISUAL=nvim
export EDITOR=nvim
export HISTIGNORE="&"
export HISTSIZE=1000
export XDG_CONFIG_HOME="$HOME/.config"

export NNN_PLUG='p:preview-tui;d:diffs;t:nmount;v:imgview'
export NNN_FIFO=/tmp/nnn.fifo

# PATH Configurations
export PATH="~/bin:/usr/bin/core_perl:$PATH"

# GO Configurations
export GOPATH=~/.golang
export GOROOT=/usr/lib/go
export PATH=$GOPATH/bin:$PATH
export PATH=$GOROOT/bin:$PATH

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH

# FZF Exports
export FZF_COMPLETION_OPTS='-m'
export FZF_DEFAULT_COMMAND='ag --follow --hidden -p ~/.agignore -g ""'
#export FZF_DEFAULT_OPTS='--preview "head -50 {}"'

# clang format 9
export PATH="/opt/clang-format-static:$PATH"

eval "$(fasd --init auto)"

## Final touches
for script in $(find "$current_script_directory/../zshlibs" -type f -name '*.zsh'); do source $script; done
if [ -n "$ZSH_VERSION" ]; then
  export KEYTIMEOUTT=1
elif [ -n "$BASH_VERSION" ]; then
  [ -r /usr/share/bash-completion/bash_completions ] &&
    . /usr/share/bash-completion/completions/*

  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  export PS1="\w $ "
  set -o vi # vim mode
fi
