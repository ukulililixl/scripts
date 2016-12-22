#/bin/bash
# usage

K=$1
M=$2
POLICY=$3
nodeid=$4
PACKETSIZE=$5
PACKETCOUNT=$6

CTDR_HOME=/home/ncsgroup/xiaolu/CTDR

ssh cloud-node12 "/home/ncsgroup/xiaolu/CTDR/test.sh $K $M $POLICY $nodeid $PACKETSIZE $PACKETCOUNT"

cd CTDR_HOME
./CTDRClient blk_-3326128831913612761

