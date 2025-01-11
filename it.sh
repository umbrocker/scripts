#!/bin/bash

if [ -z "$1" ]; then
	echo -n "python -c 'import pty;pty.spawn(\"/bin/bash\")'"
	echo -n "python -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
elif [ "$1" == "3" ]; then
	echo -n "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
	echo -n "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'" | xclip -sel clip
else
    echo "Nem értelmezhető"
fi

