#!/bin/bash

# Description:
# 	Easy to use script to copy your IP address to clipboard, from interactive menu, using fzf.
# Dependencies:
# 	awk,cut,ip,fzf,xclip
# Short description: myip | copying your selected interface's IP address to clipboard

if [ $# -ne 1 ]; then
	selected=$(ip -4 -o addr show | awk '{print $2,$4}' | cut -d'/' -f1 | tr ' ' '\t' | fzf)
	ip_address=$(echo $selected | awk '{print $2}')
else
	interface=$1
	ip_address=$(ip -4 -o addr show $interface | awk '{print $4}' | cut -d'/' -f1)
	if [ -z "$ip_address" ]; then
		echo "[*] Usage: $(basename $0) [interface]"
		exit 1
	fi
fi
echo "[+] IP address $ip_address copied to clipboard."
echo -n $ip_address | xclip -sel clip
