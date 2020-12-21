#!/bin/bash
cd /var/www/html/linear/
sudo rm *.txt
cd /home/sravi609/linear/
rm *.txt
while IFS= read -r context
do
   kubectl config use-context $context
   sleep 1
   total_nodes=$(kubectl get nodes | sed '1d' | wc -l)
   total_pods=$(kubectl get pods | sed '1d' | wc -l)
   nodes=$(kubectl get nodes | grep -v "NotReady" | sed '1d' | wc -l)
   pods=$(kubectl get pods | grep Running | wc -l)
   echo "Active Nodes: $nodes/$total_nodes" > "$context"_stats.txt
   echo "Active Pods: $pods/$total_pods" >> "$context"_stats.txt
   kubectl get pods > "$context".txt
   sleep 1
   awk -F ' ' '$3 == "CrashLoopBackOff" { print $1 }' "$context".txt > "$context"_clbo.txt
   if [ -s "$context"_clbo.txt ]
   then
           while IFS= read -r line
            do
              echo "$line is in CrashLoopBackOff state!" >> "$context"_clbo_alert.txt
            done < "$context"_clbo.txt
   fi
   sleep 1
   kubectl get nodes > "$context"nodes.txt
   awk -F ' ' '$2 == "NotReady"||$2 == "NotReady,SchedulingDisabled" { print $1 }' "$context"nodes.txt > "$context"_node.txt
   if [ -s "$context"_node.txt ]
   then
           while IFS= read -r line
            do
              echo "$line is in NotReady state!" >> "$context"_node_alert.txt
            done < "$context"_node.txt
   fi
   a=$(date)
   echo "$context DETAILED INFO - $a" >> "$context"info.txt
   echo "===================================================================PODS===================================================================" >> "$context"info.txt
   kubectl get pods -o wide >> "$context"info.txt
   echo "=================================================================SERVICES=================================================================" >> "$context"info.txt
   kubectl get services -o wide >> "$context"info.txt
   echo "================================================================END POINTS================================================================" >> "$context"info.txt
   kubectl get ep -o wide >> "$context"info.txt
   echo "===================================================================NODES==================================================================" >> "$context"info.txt
   kubectl get nodes -o wide >> "$context"info.txt
done < contexts/contexts.txt
sleep 2
sudo cp *.txt /var/www/html/linear/
sleep 2