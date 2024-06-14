# vi: ft=bash
export LD_PRELOAD=""
export LANG="en_US.UTF-8"
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
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
export FZF_COMPLETION_OPTS='-m'
export FZF_DEFAULT_COMMAND='ag --follow --hidden -p ~/.agignore -g ""'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'
export FZF_COMPLETION_OPTS='--border --info=inline'
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# clang format 9
export PATH="/opt/clang-format-static:$PATH"

eval "$(fasd --init auto)"

## Final touches
current_script_path=$(realpath "$0")
current_script_directory=$(dirname "$current_script_path")
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
