#!/bin/bash
cd ~/degraded/
rm -rf degraded_stream_alert.txt
echo "DEGRADED STREAMS LIST" >> degraded_stream_alert.txt
echo "-----------------------------------------------" >> degraded_stream_alert.txt
while IFS= read -r line
do
  content=$(wget $line -q -O - | grep -B90 '"source": "missing_profile"')
  stream_name=$(echo $content | grep -oP '(?<="name": ")[^"]*')
  #stream_Id=$(echo $content | grep -oP '(?<="streamId": ")[^"]*')
  details=$(echo $content | grep -oP '(?<="details": ")[^"]*')
  #logs=$(wget $line -q -O - | grep -A8 '"source": "missing_profile"')
  #hls=$(echo $logs | grep -oP '(?<="url": ")[^"]*')
  #sources=$(echo $content | grep -oP '(?<="source": ")[^"]*')
  #playable=$(echo $content | grep -oP '(?<="playable": ")[^"]*')
  if [ ! -z "$stream_name" ]; then
    echo "$stream_name" >> degraded_stream_alert.txt
  fi
  #echo "Stream ID: $stream_Id" >> degraded_stream_alert.txt
  #echo "Details: $details" >> degraded_stream_alert.txt
  #echo "Source: $sources" >> degraded_stream_alert.txt
  #echo "Status: $playable" >> degraded_stream_alert.txt
  #echo "-----------   HLS   ---------------" >> degraded_stream_alert.txt
  #logs=$(wget $line -q -O - | grep -A8 '"source": "missing_profile"')
  #hls=$(echo $logs | grep -oP '(?<="url": ")[^"]*')
  #manifest=$(curl -L $hls)
  #echo $manifest >> degraded_stream_alert.txt
  #echo "-----------------------------------" >> degraded_stream_alert.txt
done < region-json2.txt
#rlr=$(wget <json API URL> -q -O - | grep -B90 '"source": "missing_profile"')
#stream_namerlr=$(echo $rlr | grep -oP '(?<="name": ")[^"]*')
#stream_Id=$(echo $content | grep -oP '(?<="streamId": ")[^"]*')
#detailsrlr=$(echo $rlr | grep -oP '(?<="details": ")[^"]*')
#logs=$(wget $line -q -O - | grep -A8 '"source": "missing_profile"')
#hls=$(echo $logs | grep -oP '(?<="url": ")[^"]*')
#sources=$(echo $content | grep -oP '(?<="source": ")[^"]*')
#playable=$(echo $content | grep -oP '(?<="playable": ")[^"]*')
#if [ ! -z "$stream_namerlr" ]; then
#  echo "-----------------Redundancy---------------------" >> degraded_stream_alert.txt
#  echo "$stream_namerlr" >> degraded_stream_alert.txt
#fi
#awk '!seen[$0]++' degraded_stream_alert.txt > degraded_stream_alerts.txt
python degraded-notifier.py