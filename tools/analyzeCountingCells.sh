#!/bin/bash

if [ $# != 2 ]; then
	echo -ne "Arguments Error.\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <ResultsDirectory> <OutputFile><\n"
	exit 7

elif [ ! -d $1 ]; then
	echo -ne "$1 is not a directory.\n"
	echo -ne "Usage:\n"
	echo -ne "\t$0 <ResultsDirectory> <OutputFile>\n"
	exit 77

else

RESULTSDIR=$1
CELLSFILE=$2

if [ -f ${CELLSFILE} ]; then
	echo -ne "[\033[34m${CELLSFILE}\033[0m] is exist and will be removed now.\n"
	rm -f ${CELLSFILE}
	echo -ne "[\033[34m${CELLSFILE}\033[0m] is removed.\n"
fi

if [ -f ${RESULTSDIR}/multiple.cells ]; then
    cat ${RESULTSDIR}/multiple.cells >> ${CELLSFILE}
fi

for i in $(ls ${RESULTSDIR}/*-multiple.cells); do
    echo -ne "Processing \033[41;33m$i\033[0m\n"
    paste ${CELLSFILE} $i > tmp
    cat tmp > ${CELLSFILE}
done
rm -f tmp
echo -ne "\t\tWELL DONE!"

fi
