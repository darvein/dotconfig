alias genpasswd="openssl rand -base64 16"
alias pbc='xsel -ib'
alias pbp='xclip -selection clipboard -o'
alias script='script -t -a 2> ~/tmp/typescripts/time-`date +"%m-%d-%y-%H.%M.%S"`.log ~/tmp/typescripts/record-`date +"%m-%d-%y-%H.%M.%S"`.log'
#alias fzf="fzf --no-color --preview 'head -50 {}'"
#alias fzf="fzf --preview 'head -50 {}'"
alias newsboat-jobs="newsboat -u ~/.config/newsboat/jobs -c ~/.config/newsboat/cache-jobs.db"

# Get 1password details
_1p(){
  op whoami >/dev/null 2>&1 \
    || eval $(op signin --account nextbravellc.1password.com)

  opbash_get_names=$(op item list --format=json | jq -r '.[].title')
  opname=$(echo $opbash_get_names | fzf-tmux)
  #json=$(op item get "$opname" )
  #echo $json
  json=$(op item get "$opname" | grep -E 'username|passw')
  echo $json | column -t
}

_t2n(){
  #tmux capture-pane -pS -1000000 | nvim -
  tmux capture-pane -pS -1000000 | _t2t
}

_t2t(){
  ifs='' read -d '' input 
  echo "${input}" | pbc | tmux split-window 'nvim -c "enew" -c "PASTE"; zsh'
}

_google(){
  query="${*}"
  rm -rf ~/work/me/rutils/tmp/*.txt
  source ~/work/me/rutils/venv/bin/activate
  python3 ~/work/me/rutils/rutils_search_google.py "${query}"
  deactivate
  nvim ~/work/me/rutils/tmp/*
}

_s(){
  apppath=~/work/me/tts
  
  if [ "$#" -gt 0 ]; then
    input="$*"
  else
    ifs='' read -d '' input 
  fi

  source $apppath/venv/bin/activate
  echo "${input}" \
    | python3 $apppath/chatgpt_code.py
  deactivate
}

_chat(){
  source ~/work/me/tts/venv/bin/activate
  python3 ~/work/me/tts/chatgpt_chat.py
  deactivate
}

_chat2() {
  local output
  local chat_dir="$HOME/.config/openaiprompt"

  output=$(date +"%H-%M-%S")
  output="${output}.random"

  source ~/work/me/openai-prompt/venv/bin/activate
  ~/work/me/openai-prompt/venv/bin/python3 ~/work/me/openai-prompt/openai-prompt.py --topic "${output}"
  deactivate
}
_sc(){
  apppath=~/work/me/tts
  
  if [ "$#" -gt 0 ]; then
    input="$*"
  else
    ifs='' read -d '' input 
  fi

  source $apppath/venv/bin/activate
  echo "${input}" \
    | python3 $apppath/chatgpt_text.py
  deactivate
}
 
_get_recents_by_exiftool(){
  dirpath=$1
  find $dirpath -type f | xargs -I{} exiftool -p '${CreateDate} ${Filename}' '{}' | sort | head -n 5
}

_unhistory () {
   LC_ALL=C sed -i '/'$1'/d' $HISTFILE
   histdb --forget "$1"
}

_daymode () {
  xrandr --output DP-2 --gamma 1.0:1.0:1.0 --brightness 0.8
}

_nightmode () {
  xrandr --output DP-2 --gamma 1.0:0.90:0.75 --brightness 0.7
  #xrandr --output DP-2 --gamma 1.0:0.85:0.6 --brightness 0.5
}

_clips() {
  selected=$(for i in $(seq 0 20); do echo $i; done | fzf --preview "copyq read {}" --preview-window 'right:90%:nohidden') 
  if [[ -n "$selected" ]]; then
      copyq read "$selected" | xsel --clipboard --input
      echo "Content of item $selected copied to clipboard."
  fi
}

_get_web() {
  url=$*

  curl -s "${url}" \
    | html2text \
    --no-wrap-links \
    --ignore-links \
    --ignore-images \
    -e \
    -s \
    --escape-all \
    | tee >(copyq add -) \
    | glow -p
}

_while() {
  cmd=$*
  while true; do clear; eval "${cmd}"; sleep 3; done
}

_capture_last() {
    # Get the last command executed
    local last_command=$(fc -ln -1 | sed 's/^[[:space:]]*//')

    # Capture the current pane's content to a temporary file
    local tmp_file=$(mktemp)
    tmux capture-pane -p > $tmp_file

    # Find the last command in the captured content and print everything after it
    local last_output=$(awk -v command="$last_command" 'BEGIN{found=0} 
    {
        if(found) {
            print $0;
        } 
        else {
            # Check if the line contains the last command
            if(index($0, command) > 0) {
                found=1;
            }
        }
    }' $tmp_file)

    # Clean up the temporary file
    rm $tmp_file

    # Print the captured output
    echo "$last_command \n $last_output" | tee >(copyq add -)
}
