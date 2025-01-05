#!/bin/bash
NAME=$(date +%Y-%m-%d-%H-%M-%S)
OUTPUTHLOGTAR="/home/server-logs"
PATHTOLOGTAR="/var/log"
CURENTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
while [ -n "$1" ]
do 
case "$1" in
-p | --path) PATHTOLOGTAR="$2"
shift;;
-o | --outputpath) OUTPUTHLOGTAR="$2";;
-i |--install) sudo cp -r $CURENTDIR /opt/
sudo cp /opt/application/application.desktop /home/$USER/.local/share/applications
chmod +x /home/$USER/.local/share/applications/application.desktop;;
esac
shift 
done
sudo mkdir -p $OUTPUTHLOGTAR
sudo tar -cvzf server-logs-"$NAME".tar.gz "$PATHTOLOGTAR"
sudo mv server-logs-"$NAME".tar.gz $OUTPUTHLOGTAR