#!/bin/bash
#!/usr/bin/env python36
for line in $(cat region.txt);
    do     
    echo "Checking Stream Status for region: $line"
    sudo <python utility> -P $line status all
    sleep 3         
    done > output.txt
sleep 5
awk '{for (I=1;I<=NF;I++) if ($I == "500s:") {print $(I+1),$1};}' output.txt > logs.txt
sleep 5
#echo "REGION STATUS THAT SURPASSED 8 DOWN STREAMS" > health_alert.txt
sleep 1
awk '($1>8)' logs.txt | sort -nr > health_alert.txt
python notifier.py
sleep 5
