#!/bin/bash

cd /home/ncsgroup/xiaolu/CTDR
redis-cli flushall
killall DRCoordinator
`./DRCoordinator &> output &`

for i in 1 2 4 5 6 7 8 9 11 13 14 15 16 17 18 19 20 22 23
do
	echo "working on cloud-node$i"
	ssh cloud-node$i "killall DRAgent"
	ssh cloud-node$i "killall CTDRClient"
	scp DRAgent cloud-node$i:~/xiaolu/CTDR/
	scp CTDRClient cloud-node$i:~/xiaolu/CTDR/
	ssh cloud-node$i "redis-cli	flushall"
	ssh cloud-node$i "cd xiaolu/CTDR; ./DRAgent &> output &"
done
