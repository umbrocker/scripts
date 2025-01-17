#!/bin/bash

# Description:
#       Easy to use script to start a python http server, to share files via web. Even adds download string to clipboard. 
# Dependencies:
#       awk,cut,ip,fzf,xclip
# Short description: up4 | python3 http server for hosting files easily (I'm still working on it, a bit buggy)

if [ $# -lt 1 ]; then
    selected=$(ip -4 -o addr show | awk '{print $2,$4}' | cut -d'/' -f1 | tr ' ' '\t' | fzf)
    ip_address=$(echo $selected | awk '{print $2}')
else
	interface=$1
    ip_address=$(ip -4 -o addr show $interface | awk '{print $4}' | cut -d'/' -f1)
	if [ -z "$ip_address" ]; then
                echo "[*] Usage: $(basename $0) [interface] [port]"
                exit 1
    fi
fi


if [ -n "$2" ]; then
	echo -n "certutil -urlcache -split -f http://$ip_address:$2/" | xclip -sel clip
	echo "[+] Copied to clipboard: certutil -urlcache -split -f http://$ip_address:$2/"
	python3 -m http.server $2
else
	echo -n "certutil -urlcache -split -f http://$ip_address/" | xclip -sel clip
	echo "[+] Copied to clipboard: certutil -urlcache -split -f http://$ip_address/"
	echo "[*] Need sudo to run on port 80!"
	sudo python3 -m http.server 80 
fi

