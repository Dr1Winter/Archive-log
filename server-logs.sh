#!/bin/bash
NAME=$(date +%Y-%m-%d-%H-%M-%S)
OUTPUTHLOGTAR="/home/Server-logs"
PATHTOLOGTAR="/var/log"
while [ -n "$1" ]
do 
case "$1" in
-p) PATHTOLOGTAR="$2"
shift;;
-o) OUTPUTHLOGTAR="$2";;
esac
shift 
done
sudo mkdir -p $OUTPUTHLOGTAR
sudo tar -cvzf server-logs-"$NAME".tar.gz "$PATHTOLOGTAR"
sudo mv server-logs-"$NAME".tar.gz $OUTPUTHLOGTAR