alias _gtp="cd \$(find * -type d -not -path '*/\.git/*' | fzf)"
alias ddu='du -sh * | sort -hr | head -20'
alias ll="ls --color -hltra"
alias lt='ls --human-readable --size -1 -S --classify'

# FZF AG
_fw() {
	local file
	file="$(ag --nobreak --noheading $@ | fzf-tmux -0 -1 | awk -F: '{print $1}')"
	if [[ -n $file ]]; then
		[[ -n "$file" ]] && print -z "${EDITOR:-nvim} \"${file}\""
	fi
}

# FZF Files
_ff() {
	local files
	IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview="cat {}"))
	#[[ -n "$files" ]] && print -z "${EDITOR:-nvim} \"${files[@]}\""
  #files="${files[@]}"
  files="${files[*]}"
  files=$(echo $files | sed ':a;N;$!ba;s/\n/\t/g')
	[[ -n "$files" ]] && print -z "${EDITOR:-nvim} ${files}"
}
 
# List dirs by size
_dirs_by_size() { du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e';}

_find_dup_files(){
  find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD
}

_find_largest_file(){
  #shopt -s globstar
  #shopt -s checkwinsize
  max_s=0
  for f in **; do
    if [[ -f "$f" && ! -L "$f" ]]; then
      size=$( stat -c %s -- "$f" )
      if (( size > max_s )); then
        max_s=$size
        max_f=$f
      fi
    fi
  done
  #max_s=$(bc <<< "scale=2; $max_s/1024")
  echo "${max_s} $max_f"
}
