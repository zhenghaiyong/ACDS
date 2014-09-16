#!/bin/bash

if [ $# != 1 ]; then
	echo -ne "Arguments Error.\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <Dir>\n"
	exit 7

elif [ ! -d $1 ]; then
	echo -ne "$1 is not a directory..\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <Dir>\n"
	exit 77

else

DIR=$1
for i in $(find ${DIR} -type f|grep '/[1-9].png')
do 
	echo -ne "RENAME: \033[34m $i \033[0m\t=>\t\033[41;33m ${DIR}/00${i##*/} \033[0m\n"
	mv $i ${DIR}/00${i##*/}
done
for i in $(find ${DIR} -type f|grep '/[1-9][0-9].png')
do 
	echo -ne "RENAME: \033[34m $i \033[0m\t=>\t\033[41;33m ${DIR}/0${i##*/} \033[0m\n"
	mv $i ${DIR}/0${i##*/}
done

fi
