#!/bin/bash

# Description:
# 	Starting HTTP server in current directory.
# Dependencies:
# 	xclip,fzf,python3,ls,column,awk,tr,cut,ip
# Short description: up4 | starting an HTTP server in current directory

if [ $# -lt 1 ]; then
  port=80
else
  port="$@"
fi

menu=("certutil" "curl" "Invoke-WebRequest" "wget")
selection=$(printf "%s\n" "${menu[@]}" | fzf --header="[?] Download method?" --border=bold --border=rounded --margin=15% --color=dark --height=75% --header-first --layout=reverse)

selected=$(ip -4 -o addr show | awk '{print $2,$4}' | cut -d'/' -f1 | tr ' ' '\t' | fzf --header="[?] HTTP server ip?" --border=bold --border=rounded --margin=15% --color=dark --height=75% --header-first --layout=reverse)
myip=$(echo $selected | awk '{print $2}')
file=$(ls -1 | fzf --header="[?] Which file?" --border=bold --border=rounded --margin=15% --color=dark --height=75% --header-first --layout=reverse)

case "$selection" in
"wget")
  echo -n "wget http://$myip:$port/$file" | xclip -sel clip
  ;;
"certutil")
  echo -n "certutil -urlcache -split -f http://$myip:$port/$file" | xclip -sel clip
  ;;
"Invoke-WebRequest")
  echo -n "iwr -Uri http://$myip:$port/$file" | xclip -sel clip
  ;;
"curl")
  echo -n "curl -o $file http://$myip:$port/$file" | xclip -sel clip
  ;;
esac

ls -1 | column && echo "$ python3 -m http.server $port" && python3 -m http.server $port
