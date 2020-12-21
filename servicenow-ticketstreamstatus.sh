#!/bin/bash
rm -rf Parkinglotstatus.txt
rm -rf streams.txt
while IFS= read -r line
do
  val=$(<python utility> status -s $line)
  if echo "$val" | grep 200; 
  then
   echo "$line Stream Status: OK - Please monitor the stream for stability and resolve the ticket; Ignore if already resolved" >> streams.txt
  else
   echo "Stream $line still down" >> streams.txt
  fi
done < stream_list.txt
awk '/down:/' inc.txt > incidents.txt
awk '{print $1}' incidents.txt | sed 's/,.*//' | sed 's/"//g' > incidentslist.txt
#awk '{print $1}' incidents.txt | sed 's/"//g' > incidentslist.txt
error="still down"
paste -d " " incidentslist.txt streams.txt > Parkinglotstatus.txt
sed -i "/down/d" Parkinglotstatus.txt
#sed -i "/$error/d" Parkinglotstatus.txt    > Parkinglotstatus.txt
python parkinglotnotifier.py