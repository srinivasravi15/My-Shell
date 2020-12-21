#!/bin/bash
mv ~/Downloads/cookies.txt .
curl -s --cookie "cookies.txt" "Service Now Dashboard URL" > parking_lot.csv
cat parking_lot.csv | cut -d, -f1 -f5
cat parking_lot.csv | cut -d, -f1 -f5 > inc.txt 
grep -o ' down: .*$' inc.txt | cut -c8- | awk '{print $1}' | sed 's/.$//' > stream_list.txt
scp stream_list.txt user@hostip:/home/<user>/parkinglot/
scp inc.txt user@hostip:/home/<user>/parkinglot/
ssh user@hostip "cd \$HOME; cd parkinglot; ./stream_status.sh; "