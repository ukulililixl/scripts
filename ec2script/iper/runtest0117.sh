#!/bin/bash

sleep 2220

for i in `seq 0 7`
do
	echo i = $i
	date
	./runiperf.sh $i
	date
	sleep 2160
done
