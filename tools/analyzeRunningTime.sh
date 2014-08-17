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

ACDSTIMEFILE=$1
sum=0
num=1
avg=0
cat ${ACDSTIMEFILE} | grep "Salient Objects Detection" | awk -F" " '{print $5}'|while read time
do
    echo -ne "$((num++)): "
    echo -ne "\033[36m$sum\033[0m + "
	sum=$(echo "$sum + $time"|bc -l)
    avg=$(echo "scale=5;$sum / ($num-1)"|bc)
	echo -ne "\033[34m$time\033[0m = \033[41;33m$sum\033[0m"
    echo -ne " Average: \033[36m$avg\033[0m\n"
done

fi
