#!/bin/bash
while IFS= read -r line
         do
            kubectl get pods -l stream=$line > pod_status.txt
            pod=$(awk -F ' ' '$3 == "Running" { print $1 }' pod_status.txt)
            #kubectl delete pod $pod
         done < streams.txt
