#!/bin/bash

HADOOPDIR=/home/ncsgroup/xiaolu/hadoop-20-ctdr
`$HADOOPDIR/check.sh > checkblock`

res=`cat checkblock | grep -i "MISSING\!" | wc -l`

# echo 0 means not finish, 1 means finish
if [ $res -gt 0 ]
then
    echo 0 
else
    echo 1
fi
