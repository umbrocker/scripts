#!/bin/bash

# Description:
#   Simple network interface lister.
# Dependencies:
#   ip, awk, cut, column
# Short description: si | showing all interfaces with IP addresses


# Gyűjtsük össze az adatokat egy változóba
output=""
for interface in $(ip -o link show | awk -F': ' '{print $2}'); do
    ip_address=$(ip -4 -o addr show $interface | awk '{print $4}' | cut -d'/' -f1)
    if [ -n "$ip_address" ]; then
        output+="│ $interface \t $ip_address \n"
    fi
done

# Formázott táblázat kiírása
echo -e "$output" | column -t -s $'\t' -N '│ INTERFACE ',' ADDRESS ' -o │

