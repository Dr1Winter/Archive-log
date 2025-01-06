#!/bin/bash
NAME=$(date +%Y-%m-%d-%H-%M-%S)
OUTPUTHLOGTAR="/home/server-logs"
PATHTOLOGTAR="/var/log"
CURENTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p $OUTPUTHLOGTAR
while [ -n "$1" ]
do 
case "$1" in
-d | --directory) PATHTOLOGTAR="$2"
shift;;
-o | --outputpath) OUTPUTHLOGTAR="$2"
shift;;
-t |--time)
case "$2" in
m | minute) ROPTIONS="* * * * *";;
h | hour) ROPTIONS="0 * * * *";;
d | day) ROPTIONS="0 0 * * *";;
mo | month) ROPTIONS="0 0 1 * *";;
y | year) ROPTIONS="0 0 1 12 *";;
*) echo "Invalyd syntax"
exit 1;;
esac 
shift
crontab -l > newcron
echo "$ROPTIONS" "$CURENTDIR" >> newcron
crontab newcron
cat newcron
rm newcron
echo "Timer sucsessfull installed"
exit;;
-r | --reset-timer)
crontab -l | sed '/server-logs.sh/d' > newcron
crontab newcron
rm newcron
echo "Timer sucsessfull removed"
exit;;
*) echo "Invalyd syntax"
exit;;
esac
shift 
done
tar -cvzf server-logs-"$NAME".tar.gz "$PATHTOLOGTAR" #>&/dev/null
mv server-logs-"$NAME".tar.gz $OUTPUTHLOGTAR