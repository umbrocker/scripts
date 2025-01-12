#!/bin/bash

# Description:
# 	If you don't want to always type the usual stuff for getting a fully interactive shell,
# 	just use this command, and it will be copied to your clipboard.
# Dependencies:
# 	xclip
# Short description: it | interactive shell line copied to clipboard

function help() {
    echo "[*] Usage:"
	echo "[*] For normal python install: $(basename $0)"
	echo "[*] For python3 install: $(basename $0) 3"
}

if [ -z "$1" ]; then
	echo -en "[*] Copied to clipboard:\npython -c 'import pty;pty.spawn(\"/bin/bash\")'"
	echo -n "python -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
elif [ "$1" == "3" ]; then
	echo -en "[*] Copied to clipboard:\npython3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
	echo -n "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
else
	help
fi

