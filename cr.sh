#!/bin/bash

# Description:
# 	If you have multiple credentials obtained, store them in a creds, or creds.txt file in your folder.
# 	Every line should look like this:
# 	username:password
# Dependencies:
# 	xclip,cut,fzf
# Short description: cr | credentials formatter and exporter

if [[ -f creds ]]; then
    creds_content="creds"
elif [[ -f creds.txt ]]; then
    creds_content="creds.txt"
else
    echo "[!] No creds or creds.txt in $PWD"
    exit 1
fi

creds=$(cat $creds_content | fzf)
user=$(echo $creds | cut -d':' -f1)
echo $user
passwd=$(echo $creds | cut -d':' -f2)
echo $passwd
echo "export U='$user'; export P='$passwd'" | xclip -sel clip
echo -e "\n[*] You can export creds now, just paste clipboard to cli."

