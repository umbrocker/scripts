#!/bin/bash

# Description:
# 	If you don't want to always type the usual stuff for getting a fully interactive shell,
# 	just use this command, and it will be copied to your clipboard.
# Dependencies:
# 	xclip
# Short description: it | interactive shell line copied to clipboard

function help() {
  echo "[*] Usage: $(basename $0) [3]"
}

if [ -z "$1" ]; then
  echo -en "[*] Copied to clipboard:\npython -c 'import pty;pty.spawn(\"/bin/bash\")'"
  echo -n "python -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
elif [ "$1" == "3" ]; then
  echo -e "[*] Copied to clipboard:\npython3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
  echo -n "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
else
  help
fi
echo -e "\n"
echo -e "[+] Steps:\nctrl+z\nstty -a | head -1\t# this line is to check your current terminal size"
echo -e "stty raw -echo\nfg\nreset\nstty rows [rows] columns [columns]"
echo -e "export TERM=xterm; export SHELL=bash"
