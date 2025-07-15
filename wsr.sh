#!/usr/bin/env python3

# Description:
# 	XFCE workspace renamer tool.
# Dependencies:
# 	fzf,xfconf,python3,python3-pyfzf
# Short description: wsr | XFCE workspace renamer, written in python


import subprocess
from pyfzf.pyfzf import FzfPrompt
fzf = FzfPrompt()

def main():
    options = ["[-] Reset workspace names.", "[+] Rename workspace."]
    option = fzf.prompt(options, '--header="Choose an option: " --border=bold --border=rounded --margin=15% --color=dark --height=75% --header-first --layout=reverse')[0]
    if "Reset" in option:
        reset_workspaces()
    else:
        rename_workspace()

def reset_workspaces():
    subprocess.run(["xfconf-query", "-c", "xfwm4", "-p", "/general/workspace_names", "--reset"]) 
    print("[*] Workspace names reset to default.")

def rename_workspace():
    result = subprocess.run(["xfconf-query", "-c", "xfwm4", "-p", "/general/workspace_names"], capture_output=True, text=True)
    ws = result.stdout.split('\n')
    ws.pop(0)
    ws.pop(0)
    ws.pop()
    renamable = fzf.prompt(ws, '--header="Choose a workspace: " --border=bold --border=rounded --margin=15% --color=dark --height=75% --header-first --layout=reverse')[0]
    print(f"[*] Chosen workspace: {renamable}")
    new_name = input("[+] Workspace's new name: ")
    index = ws.index(renamable)
    ws[index] = new_name
    #print(ws)
    command = ["xfconf-query", "-c", "xfwm4", "-p", "/general/workspace_names"]
    for item in ws:
        command.append("-t")
        command.append("string")
        command.append("-s")
        command.append(item)
    #print(command)
    subprocess.run(command)

if __name__ == "__main__":
    main()
