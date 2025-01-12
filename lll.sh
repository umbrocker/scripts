#!/bin/bash

# Description:
# 	Starting listener quickly.
# Dependencies:
# 	nc,sudo,rlwrap
# Short description: lll | starting listener quickly with rlwrap

if [ $# -ne 1 ]; then
	port=443
else
	port=$1
fi
echo "[+] Starting listener on port $port"
sudo rlwrap nc -nlvp $port
