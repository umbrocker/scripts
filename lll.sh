#!/bin/bash

# Description:
# 	Starting listener quickly.
# Dependencies:
# 	nc,sudo,rlwrap
# Short description: lll | starting listener quickly with rlwrap

if [ $# -ne 1 ]; then
	port=443
else
	if [[ "$1" =~ ^[0-9]+$ ]]; then
		port=$1
	else
		echo "[*] Usage: $(basename $0) [port]"
		exit 1
	fi
fi
echo "[+] Starting listener on port $port"
echo "\$ sudo rlwrap -cAr nc -nlvp $port"
sudo rlwrap -cAr nc -nlvp $port
