#/bin/bash
# usage

K=$1
M=$2
POLICY=$3
nodeid=$4
PACKETSIZE=$5
PACKETCOUNT=$6

CTDR_HOME=/home/ncsgroup/xiaolu/CTDR
#LOGDIR=/home/ncsgroup/xiaolu/ctr5alog
LOGDIR=/home/ncsgroup/xiaolu/ctr5blog

#./newctr5a.sh 10 4 ctdr 10.10.10.32 1024 65536 >${LOGDIR}/log_1024_65536_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 2048 32768 >${LOGDIR}/log_2048_32768_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 4096 16384 >${LOGDIR}/log_4096_16384_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 8192 8192  >${LOGDIR}/log_8192_8192_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 16384 4096 >${LOGDIR}/log_16384_4096_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 32768 2048 >${LOGDIR}/log_32768_2048_6
#./newctr5a.sh 10 4 ctdr 10.10.10.26 65536 1024 >${LOGDIR}/log_65536_1024_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 131072 512 >${LOGDIR}/log_131072_512_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 262144 256 >${LOGDIR}/log_262144_256_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 524288 128 >${LOGDIR}/log_524288_128_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 1048576 64 >${LOGDIR}/log_1048576_64_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 2097152 32 >${LOGDIR}/log_2097152_32_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 4194304 16 >${LOGDIR}/log_4194304_16_6
#./newctr5a.sh 10 4 ctdr 10.10.10.32 8388608 8  >${LOGDIR}/log_8388608_8_6

./newctr5b.sh 10 4 ctdr 10.10.10.32 32768 8192  >${LOGDIR}/log_32768_8192
