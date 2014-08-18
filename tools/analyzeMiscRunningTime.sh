#!/bin/bash

if [ $# != 1 ]; then
	echo -ne "Arguments Error.\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <TimeFile>\n"
	exit 7

elif [ ! -f $1 ]; then
	echo -ne "$1 is not a regular file..\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <TimeFile>\n"
	exit 77

else

MISCTIMEFILE=$1
sum=0.00000
num=1
avg=0.00000
cat ${MISCTIMEFILE} | grep "jpg" | awk -F":" '{print $2}'|while read time
do
    printf "%3d: " $((num++))
    echo -ne "\033[36m$sum\033[0m + "
	sum=$(echo "scale=5;$sum + $time"|bc -l)
    avg=$(echo "scale=5;$sum / ($num-1)"|bc)
	echo -ne "\033[34m$time\033[0m = \033[41;33m$sum\033[0m"
    echo -ne " Average: \033[35m$avg\033[0m\n"
done
echo -ne "\033[31m$(cat ${MISCTIMEFILE} | grep "Total")\033"

fi
