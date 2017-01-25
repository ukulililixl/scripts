#!/bin/bash
# usage ./test.sh K M PACKETSIZE PACKETCOUNT DPOLICY CPOLICY requesthandlernum distnum workthread RACKNUM cross stripenum shuffle

K=$1
M=$2
PACKETSIZE=$3
PACKETCOUNT=$4
DPOLICY=$5
CPOLICY=$6
RNUM=$7
DISTNUM=$8
WTHREAD=$9
RACKNUM=${10}
BDWT=${11}
STRIPE=${12}
SHUFFLE=${13}

CTDRHOME=/home/ncsgroup/xiaolu/CTDR
cd $CTDRHOME

# 0. stop ctdr
echo "stop ctr"
$CTDRHOME/stop.sh

echo "clean rack awareness"
for i in 1 2 4 5 6 7 8 9 11 13 14 15 16 17 18 19 20 22 23
do
	ssh cloud-node$i "sudo tc qdisc del dev eth0 root"
done

# 1. config
echo "create conf"
cd $CTDRHOME/fullnodeconf
python createconf.py $K $M $PACKETSIZE $PACKETCOUNT $DPOLICY $CPOLICY $RNUM $DISTNUM $WTHREAD $RACKNUM $SHUFFLE

sleep 60

# 2. create data and stripe
echo "create data"
cd $CTDRHOME/input
python createblkdir.py $K $M $STRIPE
sleep 60

# 3. start
echo "start ctr"
$CTDRHOME/run.sh
cd $CTDRHOME/rack

echo "create rack awareness"
$CTDRHOME/rack/dist.sh $K $M $RACKNUM $BDWT
sleep 60

# 4. issue degraded read
echo "issue degraded read"
cd $CTDRHOME/input
python degraded.py

