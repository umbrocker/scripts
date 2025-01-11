#!/bin/bash

# Description:
# 	If you don't want to always type the usual stuff for getting a fully interactive shell,
# 	just use this command, and it will be copied to your clipboard.
# Dependencies:
# 	xclip

if [ -z "$1" ]; then
	echo -en "[*] Copied to clipboard:\npython -c 'import pty;pty.spawn(\"/bin/bash\")'"
	echo -n "python -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
elif [ "$1" == "3" ]; then
	echo -en "[*] Copied to clipboard:\npython3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
	echo -n "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
else
    echo "[*] Usage:"
	echo "[*] For normal python install: $0"
	echo "[*] For python3 install: $0 3"
fi

