#!/bin/bash
stream=$(cat stream.txt)
url=$(grep -rnw -e $stream | grep <selector> | awk '{print $3}' | sed 's/.$//' | sed -e 's/^"//' -e 's/"$//')
<python utility> download $url