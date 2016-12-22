#!/bin/bash
# usage ./test.sh K M POLICY NODEID PACKETSIZE PACKETCOUNT 

K=$1
M=$2
POLICY=$3
NODEID=$4
PACKETSIZE=$5
PACKETCOUNT=$6

CTDRHOME=/home/ncsgroup/xiaolu/CTDR
cd $CTDRHOME

# 0. stop ctdr
$CTDRHOME/stop.sh

# 1. config
cd $CTDRHOME/xiaoluconf
$CTDRHOME/xiaoluconf/createconf.sh $K $M $POLICY $NODEID $PACKETSIZE $PACKETCOUNT

# 2. stripeStore
cd ..
$CTDRHOME/stripe.sh

# 3. start
$CTDRHOME/run.sh
