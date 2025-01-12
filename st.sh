#!/bin/bash

# Description:
# 	If you don't want to keep in mind your target's IP, this script will help you.
# 	It creates a file in your home folder with your target's IP address: $HOME/.config/target
# 	and also adds a line to your shell's rc file, to have an environment variable $target, with the IP address.
# 	On top of that, it creates a line in your /etc/hosts file, that points the domainname 'target' to the IP.
# Dependencies:
# 	sudo,sed,tee,grep,xclip
# Short description: st | writing target IP into a file, exporting it as environment variable and adding it to hosts file

if [ $# -ne 1 ]; then
    echo "[*] Usage: $0 <target_ip>"
    exit 1
fi


new_ip=$1
directory="$HOME/.config"

if [ -d "$directory" ]; then
	:
else
  mkdir -p $directory
fi
echo $new_ip > $directory/target 

current_shell=$(basename "$SHELL")

case "$current_shell" in
  bash)
    rc_file="$HOME/.bashrc"
    ;;
  zsh)
    rc_file="$HOME/.zshrc"
    ;;
  fish)
    rc_file="$HOME/.config/fish/config.fish"
    ;;
  *)
    echo "[!] Unexpected shell type: $current_shell"
    exit 1
    ;;
esac

export_line="export target=$(cat $directory/target)"

if grep -q "^export target=" "$rc_file"; then
	sed -i "s/^export target=.*/$export_line/" "$rc_file"
	echo "[*] Updated: '$export_line' in $rc_file file."
else
  	echo "$export_line" >> "$rc_file"
  	echo "[+] Added: '$export_line' to $rc_file file."
fi
echo "[!] You need to use this command: source $rc_file"
echo -n "source $rc_file" | xclip -sel clip

hostname="target"
hosts_file="/etc/hosts"

echo "[+] Need SUDO password for editing $hosts_file"

if grep -q "\s$hostname$" "$hosts_file"; then
    sudo sed -i "s/.*\s$hostname\$/$new_ip\t$hostname/" "$hosts_file"
else
    echo -e "$new_ip\t$hostname" | sudo tee -a "$hosts_file"
fi
echo -e "[*] last line of /etc/hosts file:\n$(grep target $hosts_file)"
