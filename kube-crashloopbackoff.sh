#!/bin/bash
kubectl config use-context <kube context name>
sleep 1
kubectl get pods > file.txt
sleep 1
awk -F ' ' '$3 == "CrashLoopBackOff" { print $1 }' file.txt > file-CLK.txt
if [ -s file-CLK.txt ]
then
        while IFS= read -r line
         do
           echo "$line is in CrashLoopBackOff state!" > file-CLKalert.txt
           kubectl describe pod $line >> file-CLKalert.txt
           echo "*******************************************************************************" >> file-CLKalert.txt
                   kubectl logs -c nginx $line >> file-CLKalert.txt
                   kubectl logs -c <app> $line >> file-CLKalert.txt
         done < file-CLK.txt
else
         echo "No pods are found to be in CrashLoopBackOff state" > file-CLKalert.txt
fi
sleep 2
python CLKalert.py