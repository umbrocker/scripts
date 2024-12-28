#!/bin/bash
# Quick scan

if [ $# -ne 1 ]; then
    echo "[*] Usage: $0 <target_ip>"
    read
    exit 1
fi

echo "[+] Scanning for all ports."
echo "[!] Need sudo rights."
sudo nmap -sS -p- -oA $1_all_ports -Pn $1
echo "[+] Outputs saved as: $1_all_ports.nmap, $1_all_ports.gnmap, $1_all_ports.xml"

if [ -e  $1_all_ports.nmap ]; then
	ports=$(cat $1_all_ports.nmap | grep open | cut -d '/' -f1 | tr '\n' ',' | sed 's/,$//g')
	echo "[+] Scanning for services on open ports: $ports"
	nmap -sC -sV -p $ports -oA $1_service_scan $1
	echo "[+] Outputs saved as: $1_service_scan.nmap, $1_service_scan.gnmap, $1_service_scan.xml"
	echo "[*] Scans finished."
else
  echo "[!] File doesn't exist. Exiting."
  exit 1
fi


webservices=$(cat $1_service_scan.nmap | grep open | grep http | cut -d '/' -f1 | grep -E '^[0-9]{1,5}$'| tr '\n' ',' | sed 's/,$//g')
echo "[+] Potential web services: $webservices"

echo "# Host: $1" > $1_summary.md
echo "### Open ports:">>$1_summary.md
echo '`'$ports'`'>>$1_summary.md
echo "### All services:" >> $1_summary.md
echo '```bash'>> $1_summary.md
cat $1_service_scan.gnmap | grep open | cut -d':' -f 3 | tr ',' '\n' | tr '/' '\t'>>$1_summary.md
echo '```'>> $1_summary.md 
echo "### Potential web services:">>$1_summary.md
echo '`'"$webservices"'`'>>$1_summary.md
echo "[*] Summary saved: $1_summary.md"
