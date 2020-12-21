#!/bin/bash
echo "------------------------------------NODES and PODS LIST-------------------------------------" > access.txt
while IFS= read -r line
do
  echo "---------------------------------------Context $line----------------------------------------" >> access.txt
  kubectl config use-context $line
  #echo "-----------Nodes-----------" >> node.txt
  kubectl get nodes | awk '{print $1}' | sed -n '1!p' > node.txt
  #echo "-----------Pods-----------" >> node.txt
  #kubectl get pods | awk '{print $1}' | sed -n '1!p' >> node.txt
  pssh -O StrictHostKeyChecking=no -l <username> -h node.txt date | grep FAILURE | awk '{print $4}' >> access.txt 
done < context.txt