#!/bin/bash
# usage: ./test.sh serversite serverip isserver testid

SERVERSITE=$1
SERVERIP=$2
ISSERVER=$3
TESTID=$4
CLIENTSITE=$5
LOG=/home/xiaolu/iperflog/${SERVERSITE}_${TESTID}


if [ "$ISSERVER" == "1" ]
then 
	iperf3 -s >>/dev/null & 
else 
	iperf3 -c $SERVERIP
fi
