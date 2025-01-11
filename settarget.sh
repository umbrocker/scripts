#!/bin/bash

# usage:
# chmod +x settarget
# source ./settarget <target_ip>
if [ $# -ne 1 ]; then
    echo "[*] Usage: $0 <target_ip>"
    read
    exit 1
fi


new_ip=$1
echo $new_ip > /home/$(whoami)/target
export target=$new_ip
hostname="target"
hosts_file="/etc/hosts"

echo "[+] Need SUDO password for editing $hosts_file"

if grep -q "\s$hostname$" "$hosts_file"; then
    sudo sed -i "s/.*\s$hostname\$/$new_ip\t$hostname/" "$hosts_file"
else
    echo -e "$new_ip\t$hostname" | sudo tee -a "$hosts_file"
fi

cat /etc/hosts
