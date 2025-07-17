#!/bin/bash

# Description:
# 	Helper script to all of my own scripts.
# Dependencies:
# 	grep,cut,tr
# Short description: h | this help menu

grep "# Short description" /opt/scripts/*.sh /opt/scripts/*.py | grep -v grep | cut -d : -f3 | tr '|' '\t\t'
