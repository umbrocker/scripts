#!/bin/bash

# Description:
#       Terminal image viewer.
# Dependencies:
#       kitty,fzf,ls
# Short description: k | view image in terminal 

picture=$(ls -1 ls *.jpg *.jpeg *.png *.gif *.bmp *.tiff *.tif *.webp *.ico *.svg *.heif *.heic *.apng *.avif *.pbm *.pgm *.ppm *.xbm *.xpm *.dds 2>/dev/null | fzf --header="Choose a picture: " --border=bold --border=rounded --margin=15% --color=dark --height=75% --header-first --layout=reverse)
kitty +kitten icat $picture
