set +o errexit
# loop until doom arrives (e.g. we found a bug where valid events are logged but they don't appear in the manifest)
DOOM=false
while ! $DOOM; do
  # grab the last log entry that exists in the log file before we start the long running packet capture
  LAST_LOG_ENTRY=$(tail -n1 "$LOG_FILE")
  # start a 5min packet capture
  tcpdump -i "$NET_IF" udp and src "$SOURCE_IP" and dst "$GROUP_IP" and portrange $PORT_START-$PORT_END \
          -w $(printf "%s/%s-%s.pcap" "$DESTINATION_DIR" "$(basename "$0" .sh)" "$(basename "$CHANNEL_FILE" .conf)") -G 300 -W 1 -K -n &
  if [ $? -ne 0 ]; then
    retryWithMsg "tcpdump failed"
    continue
  fi
  PID=$!
  #running segment anachronism and looking for maxDiffSeconds
  maxdiffseconds=$(segment-anachronism -filename "$MANIFEST_FILE" | awk '{print $7}'| cut -d "=" -f 2-)
  if (( $(echo "$maxdiffseconds > 20" |bc -l) ));
  then
      DOOM=true
      wait $PID
  fi
 wait $PID
done
set -o errexit
log "$(printf "Exiting cleanly, found the issue and captured the packets to reproduce it: CHANNEL NAME:%s maxdiff:%f\n" "$BASE_CHANNEL_NAME" "$maxdiffseconds")"
exit 0


kubectl config use-context <kube-context>
kubectl exec -it <podname> bash
timeout 300 tcpdump -i po0 udp and src <SOURCE_IP> and dst <DESTINATION_IP> and portrange <PORT_RANGE> -w streamname.pcap
kubectl cp <podname>:streamname.pcap ~/streamname.pcap
scp user@hostip:/home/user/streamname.pcap .