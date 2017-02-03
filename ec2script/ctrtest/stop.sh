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
$canada1 $canada2 $canada3 $canada4 )
 
 
redis-cli flushall
killall DRCoordinator
#./DRCoordinator &> output &

for item in ${cluster[@]}
do
	echo "working on $item"
	ssh $item "killall DRAgent"
	ssh $item "redis-cli flushall"
	#ssh 192.168.0.$i "cd CTDR/ && ./DRAgent &>	output &"
done
