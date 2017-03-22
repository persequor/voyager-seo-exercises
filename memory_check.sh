#!/usr/bin/env bash
while getopts ":c:w:e:" option
do
        case "${option}"
        in
                c) CRITICAL=${OPTARG};;
                w) WARNING=${OPTARG};;
                e) EMAIL=${OPTARG};;
                :)  echo "Error: -$OPTARG requires an argument" 
                    exit
                    ;;
        esac
done
pass=1
if [ -z "$CRITICAL" ]
then
    echo "Error: option -c is required."
    pass=0
fi

if [ -z "$WARNING" ]
then
    echo "Error: option -w is required."
    pass=0
fi

if [ -z "$EMAIL" ]
then
    echo "Error: option -e is required."
    pass=0
fi

if ((pass == 0))
then
    exit
fi
re='^[0-9]+$'
if ! [[ $CRITICAL =~ $re ]] ; then
   echo "Error: -c argument should be an integer" >&2; exit
fi

if ! [[ $WARNING =~ $re ]] ; then
   echo "Error: -w argument should be a integer" >&2; exit
fi


if (( WARNING >= CRITICAL ))
then
    echo "-c argument should be greater than -w argument "
    exit
fi
TOTAL_MEMORY=$( free | grep Mem: | awk '{ print $2 }')
echo $TOTAL_MEMORY
if (( TOTAL_MEMORY >= CRITICAL ))
then
    exit 2
elif(( TOTAL_MEMORY >= WARNING ))
then 
    exit 1
else
    exit 0
fi



