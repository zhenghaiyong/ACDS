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
sum1=0.00000
sum2=0.00000
num=1
avg1=0.00000
avg2=0.00000
cat ${ACDSTIMEFILE} | grep "jpg" | awk -F" " '{print $5,$6}'|while read time1 time2
do
    printf "%3d: " $((num++))
    echo -ne "\033[36m$sum1\033[0m + "
	sum1=$(echo "scale=5;$sum1 + $time1"|bc -l)
    avg1=$(echo "scale=5;$sum1 / ($num-1)"|bc)
	echo -ne "\033[34m$time1\033[0m = \033[41;33m$sum1\033[0m"
    echo -ne " Average: \033[35m$avg1\033[0m"
    echo -ne " || "
    echo -ne "\033[36m$sum2\033[0m + "
	sum2=$(echo "scale=5;$sum2 + $time2"|bc -l)
    avg2=$(echo "scale=5;$sum2 / ($num-1)"|bc)
	echo -ne "\033[34m$time2\033[0m = \033[41;33m$sum2\033[0m"
    echo -ne " Average: \033[35m$avg2\033[0m\n"
done
echo -ne "\033[31m$(cat ${ACDSTIMEFILE} | grep "Total")\033"

fi
