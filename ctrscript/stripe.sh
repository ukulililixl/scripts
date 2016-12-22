#!/bin/bash

CTDR_HOME=/home/ncsgroup/xiaolu/CTDR
HADOOP_HOME=/home/ncsgroup/xiaolu/hadoop-20-ctdr

rm $CTDR_HOME/stripeStore/*
ssh cloud-node13 "scp /home/ncsgroup/xiaolu/hadoop-20-ctdr/stripeStore/* cloud-node12:/home/ncsgroup/xiaolu/CTDR/stripeStore"
#cp $HADOOP_HOME/stripeStore/* $CTDR_HOME/stripeStore
#cd $CTDR_HOME/stripeStore
#rename "s/drc/rs/" *

for i in 1 2 4 5 6 7 8 9 11 14 15 16 17 18 19 20 21 22 23
do
    echo "on cloud-node$i"
	ssh cloud-node$i "rm /home/ncsgroup/xiaolu/CTDR/stripeStore/*"
	scp $CTDR_HOME/stripeStore/* cloud-node$i:/home/ncsgroup/xiaolu/CTDR/stripeStore/
done
