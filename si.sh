#!/bin/bash

echo -e "┌───────────────────────┬───────────────────────┐"
echo -e "│\tInterface\t│\tAddress\t\t│"
echo -e "├───────────────────────┼───────────────────────┤"
for interface in $(ip -o link show | awk -F': ' '{print $2}'); do
    ip_address=$(ip -4 -o addr show $interface | awk '{print $4}' | cut -d'/' -f1)
    if [ -n "$ip_address" ]; then
        echo -e "│\t$interface\t\t│\t$ip_address\t│"
    fi
done
echo -e "└───────────────────────┴───────────────────────┘"
