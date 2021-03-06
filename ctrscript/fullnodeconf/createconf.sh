#!/bin/bash
# usage: ./createconf.sh K M POLICY NODEID PACKETSIZE COUNT

K=$1
M=$2
POLICY=$3
NODEID=$4
PACKETSIZE=$5
COUNT=$6

N=`expr $K + $M`
DEFAULTCONF=/home/ncsgroup/xiaolu/CTDR/xiaoluconf/configdefault.xml
REALCONFDIR=/home/ncsgroup/xiaolu/CTDR/conf
CURRENTDIR=/home/ncsgroup/xiaolu/CTDR/xiaoluconf

echo $N

# 0. find FS
TMP=`ssh ${NODEID} "find -name finalized"`
echo "the block dir on hdfs datanode is $TMP"
FS=${TMP:2}
FS=/home/ncsgroup/$FS
echo "the block dir of ctr is $FS"

# 1. config for coordinator first
for i in 12 13 14 15 16 17 18 19 20 21 22
do
cp $DEFAULTCONF $CURRENTDIR/config$i.xml
sed -i "2a\
<attribute><name>erasure.code.k</name><value>$K</value></attribute>" $CURRENTDIR/config$i.xml

sed -i "3a\
<attribute><name>erasure.code.n</name><value>$N</value></attribute>" $CURRENTDIR/config$i.xml

sed -i "5a\
<attribute><name>packet.size</name><value>$PACKETSIZE</value></attribute>" $CURRENTDIR/config$i.xml

sed -i "6a\
<attribute><name>packet.count</name><value>$COUNT</value></attribute>" $CURRENTDIR/config$i.xml

sed -i "7a\
<attribute><name>degraded.read.policy</name><value>$POLICY</value></attribute>" $CURRENTDIR/config$i.xml

sed -i "14a\
<attribute><name>hdfs.block.directory</name><value>$FS</value></attribute>" $CURRENTDIR/config$i.xml

if [ $i -eq 12 ]
then
sed -i "28a\
<attribute><name>local.ip.address</name><value>127.0.0.1</value></attribute>" $CURRENTDIR/config$i.xml
else
IP=`expr $i + 10`
sed -i "28a\
<attribute><name>local.ip.address</name><value>192.168.0.$IP</value></attribute>" $CURRENTDIR/config$i.xml
fi

echo "copy config$i.xml and rsEncMat_${K}_${M} to cloud-node$i"
scp $CURRENTDIR/config$i.xml node$i:/home/ncsgroup/xiaolu/CTDR/conf/config.xml
scp $CURRENTDIR/rsEncMat_${K}_${M} node$i:/home/ncsgroup/xiaolu/CTDR/conf/rsEncMat
done
