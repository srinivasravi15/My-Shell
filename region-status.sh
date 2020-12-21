#!/bin/bash
for line in $(cat region.txt);
    do     
    echo "Checking Stream Status for region: $line"
    <python utility> -P $line status all
    sleep 3         
    done > output.txt
