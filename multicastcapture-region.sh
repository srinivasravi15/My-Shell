#!/bin/bash
while IFS= read -r line
do
file_name=$(basename $line)
wget -q -O $file_name $line
sleep 2
done < region-json2.txt
