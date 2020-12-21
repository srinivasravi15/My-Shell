#!/bin/bash
for i in `cat stream.txt`
do
echo $i
ppod=`kubectl get pods -l stream=$i |tail -n 1`
echo $ppod
ppod1=`kubectl get pods -l stream=$i |tail -n 1 | awk '{print$1}'`
#echo $ppod1
endpt=`kubectl get ep -l pod=$ppod1 | tail -n 1 | awk '{print$2}'`
echo $endpt
echo `curl -sI http://$endpt/$i/manifest.mpd | head -n 1`
echo "=================================================="
done