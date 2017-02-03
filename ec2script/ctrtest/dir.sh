#!/bin/bash

ohio1=52.14.86.225
ohio2=52.14.97.165
ohio3=52.14.53.124
ohio4=52.14.104.92
ohio5=52.14.72.239

california1=54.183.87.142
california2=52.53.210.52
california3=52.53.232.194
california4=54.67.47.129

oregon1=35.166.45.82
oregon2=50.112.19.78
oregon3=35.161.4.24
oregon4=52.34.6.118

canada1=52.60.39.184
canada2=52.60.103.4
canada3=52.60.105.122
canada4=52.60.96.226

cluster=( $ohio2 $ohio3 $ohio4 $ohio5
$california1 $california2 $california3 $california4
$oregon1 $oregon2 $oregon3 $oregon4
$canada1 $canada2 $canada3 $canada4)
 


for item in ${cluster[@]}
do
#	ssh $item "mkdir /home/xiaolu/CTDR/fullnodeconf"
#	scp /home/xiaolu/CTDR/fullnodeconf/createconf.py $item:/home/xiaolu/CTDR/fullnodeconf/
#	scp /home/xiaolu/CTDR/DRAgent $item:/home/xiaolu/CTDR/
#	scp /home/xiaolu/CTDR/CTDRClient $item:/home/xiaolu/CTDR
#	scp /home/xiaolu/CTDR/fullnodeconf/rsEncMat_8_1 $item:/home/xiaolu/CTDR/fullnodeconf
#	ssh $item "mkdir /home/xiaolu/CTDR/input"
#	ssh $item "cp /home/xiaolu/scripts/ctrscript/input/baseblk /home/xiaolu/CTDR/input/"
#	ssh $item "mkdir /home/xiaolu/CTDR/blkDir"
	ssh $item "mkdir /home/xiaolu/iperftest"
done
