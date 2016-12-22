#/bin/bash
# usage

K=$1
M=$2
POLICY=$3
nodeid=$4
PACKETSIZE=$5
PACKETCOUNT=$6

CTDR_HOME=/home/ncsgroup/xiaolu/CTDR
LOGDIR=/home/ncsgroup/xiaolu/ctr5alog

RES=$LOGDIR/log_${PACKETSIZE}_${PACKETCOUNT}

echo "start test K=$K M=$M POLICY=$POLICY PACKETSIZE=$PACKETSIZE PACKETCOUNT=$PACKETCOUNT"

#ssh cloud-node12 "/home/ncsgroup/xiaolu/CTDR/test.sh $K $M $POLICY $nodeid $PACKETSIZE $PACKETCOUNT" 

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
echo "start the ${i}th read"
ssh cloud-node12 "/home/ncsgroup/xiaolu/CTDR/test.sh $K $M $POLICY $nodeid $PACKETSIZE $PACKETCOUNT"
cd $CTDR_HOME
./CTDRClient blk_-1472687081474282940
done

