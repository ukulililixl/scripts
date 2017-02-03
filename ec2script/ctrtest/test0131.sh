#!/bin/bash

LOGDIR=/home/xiaolu/heterolog

TRUE="true"
FALSE="false"

# 1. test k=6 m=3
cd /home/xiaolu/CTDR/input
python newcreate.py 6 3

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./fullnode.sh 6 3 32768 2048 ctdr pipeline 4 $TRUE >${LOGDIR}/log_6_3_shuffle_$i
timeout 30m ./fullnode.sh 6 3 1048576 64 conv pipeline 4 $FALSE >${LOGDIR}/log_6_3_conv_$i
timeout 30m ./fullnode.sh 6 3 1048576 64 ppr pipeline 4 $FALSE >${LOGDIR}/log_6_3_ppr_$i
done

# 2. test k=8 m=1
cd /home/xiaolu/CTDR/input
python newcreate.py 8 1

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./fullnode.sh 8 1 32768 2048 ctdr pipeline 4 $TRUE >${LOGDIR}/log_8_1_shuffle_$i
timeout 30m ./fullnode.sh 8 1 1048576 64 conv pipeline 4 $FALSE >${LOGDIR}/log_8_1_conv_$i
timeout 30m ./fullnode.sh 8 1 1048576 64 ppr pipeline 4 $FALSE  >${LOGDIR}/log_8_1_ppr_$i
done

# 3. test k=10 m=4
cd /home/xiaolu/CTDR/input
python newcreate.py 10 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./fullnode.sh 10 4 32768 2048 ctdr pipeline 4 $TRUE >${LOGDIR}/log_10_4_shuffle_$i
timeout 30m ./fullnode.sh 10 4 1048576 64 conv pipeline 4 $FALSE >${LOGDIR}/log_10_4_conv_$i
timeout 30m ./fullnode.sh 10 4 1048576 64 ppr pipeline 4 $FALSE  >${LOGDIR}/log_10_4_ppr_$i
done

# 3. test k=12 m=4
cd /home/xiaolu/CTDR/input
python newcreate.py 12 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./fullnode.sh 12 4 32768 2048 ctdr pipeline 4 $TRUE >${LOGDIR}/log_12_4_shuffle_$i
timeout 30m ./fullnode.sh 12 4 1048576 64 conv pipeline 4 $FALSE >${LOGDIR}/log_12_4_conv_$i
timeout 30m ./fullnode.sh 12 4 1048576 64 ppr pipeline 4 $FALSE  >${LOGDIR}/log_12_4_ppr_$i
done
