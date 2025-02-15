#!/bin/bash

# Description:
# 	Simple network interface lister.
# Dependecies:
# 	ip,awk,cut
# Short description: si | showing all interfaces with IP addresses

echo -e "┌───────────────────────┬───────────────────────┐"
echo -e "│\tInterface\t│\tAddress\t\t│"
echo -e "├───────────────────────┼───────────────────────┤"
for interface in $(ip -o link show | awk -F': ' '{print $2}'); do
    ip_address=$(ip -4 -o addr show $interface | awk '{print $4}' | cut -d'/' -f1)
    if [ -n "$ip_address" ]; then
        string_length=${#interface}
	if [ $string_length -gt 4 ]; then
	    echo -e "│\t$interface\t│\t$ip_address\t│"
	else
	    echo -e "│\t$interface\t\t│\t$ip_address\t│"
	fi
    fi
done
echo -e "└───────────────────────┴───────────────────────┘"
