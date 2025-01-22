#!/bin/bash


# Description:
# 	Runs 2 nmap scans on your target:
# 		- First, it looks for all open ports;
# 		- Second, it will enumerates the open ports for services and runs the default nmap scripts.
# 	If it finds http like services, then it runs 'whatweb' on those ports too.
# 	After that, it generates a markdown file, that can be easily imported into your obsidian notes.
# Dependencies:
# 	cut,sudo,sed,grep,nmap,whatweb,tr
# Short description: bs | running basic nmap scans (all ports, service scan) and whatweb, then generating report in md 

if [ $# -ne 1 ]; then
	echo "[*] Usage: $(basename $0) <target_ip>"
    exit 1
fi


echo "[+] Scanning for all ports."
echo "[+] Creating directory: $PWD/scans"
mkdir -p scans
echo "[!] Need sudo rights."
sudo nmap -sS -p- -oA scans/$1_all_ports -Pn $1
echo "[+] Outputs saved as: $PWD/scans/$1_all_ports.nmap, $1_all_ports.gnmap, $1_all_ports.xml"

if [ -e  scans/$1_all_ports.nmap ]; then
	ports=$(cat scans/$1_all_ports.nmap | grep open | cut -d '/' -f1 | tr '\n' ',' | sed 's/,$//g')
	echo "[+] Scanning for services on open ports: $ports"
	nmap -sC -sV -p $ports -oA scans/$1_service_scan $1
	echo "[+] Outputs saved as: $PWD/scans/$1_service_scan.nmap, $1_service_scan.gnmap, $1_service_scan.xml"
	echo "[*] Scans finished."
else
  echo "[!] File doesn't exist. Exiting."
  exit 1
fi


webservices=$(cat scans/$1_service_scan.nmap | grep open | grep http | cut -d '/' -f1 | grep -E '^[0-9]{1,5}$'| tr '\n' ',' | sed 's/,$//g')
echo "[+] Potential web services: $webservices"

echo "# Host: $1" > $1_summary.md
echo "### Open ports:">>$1_summary.md
echo '`'$ports'`'>>$1_summary.md
echo "### All services:" >> $1_summary.md
echo '```bash'>> $1_summary.md
cat scans/$1_service_scan.gnmap | grep open | cut -d':' -f 3 | tr ',' '\n' | tr '/' '\t'>>$1_summary.md
echo '```'>> $1_summary.md 
echo "### Potential web services:">>$1_summary.md
echo '`'"$webservices"'`'>>$1_summary.md
echo "[*] Summary saved: $1_summary.md"
