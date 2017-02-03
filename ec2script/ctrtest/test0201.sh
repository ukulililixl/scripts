#!/bin/bash

LOGDIR=/home/xiaolu/heterolog

TRUE="true"
FALSE="false"

# 1. requestor at ohio
cd /home/xiaolu/iperftest
python runiperf.py
cd /home/xiaolu/matrix
python collect.py ohio

MATRIX=/home/xiaolu/matrix/ohio
DSTMATRIX=/home/xiaolu/CTREnh/inputMat
cp $MATRIX $DSTMATRIX

# 1.1 test k=6 m=3
cd /home/xiaolu/CTREnh
./main 9 6 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_ohio.py 6 3

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 6 3 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_6_3_opt_ohio_$i
done

# 1.1 test k=8 m=1
cd /home/xiaolu/CTREnh
./main 9 8 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_ohio.py 8 1

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 8 1 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_8_1_opt_ohio_$i
done

# 1.1 test k=10 m=4
cd /home/xiaolu/CTREnh
./main 14 10 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_ohio.py 10 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 10 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_10_4_opt_ohio_$i
done

# 1.1 test k=12 m=4
cd /home/xiaolu/CTREnh
./main 16 12 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_ohio.py 12 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 12 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_12_4_opt_ohio_$i
done



# 1. requestor at canada
cd /home/xiaolu/iperftest
python runiperf.py
cd /home/xiaolu/matrix
python collect.py canada

MATRIX=/home/xiaolu/matrix/canada
DSTMATRIX=/home/xiaolu/CTREnh/inputMat
cp $MATRIX $DSTMATRIX

# 1.1 test k=6 m=3
cd /home/xiaolu/CTREnh
./main 9 6 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_canada.py 6 3

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 6 3 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_6_3_opt_canada_$i
done

# 1.1 test k=8 m=1
cd /home/xiaolu/CTREnh
./main 9 8 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_canada.py 8 1

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 8 1 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_8_1_opt_canada_$i
done

# 1.1 test k=10 m=4
cd /home/xiaolu/CTREnh
./main 14 10 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_canada.py 10 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 10 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_10_4_opt_canada_$i
done

# 1.1 test k=12 m=4
cd /home/xiaolu/CTREnh
./main 16 12 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_canada.py 12 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 12 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_12_4_opt_canada_$i
done



# 1. requestor at oregon
cd /home/xiaolu/iperftest
python runiperf.py
cd /home/xiaolu/matrix
python collect.py oregon

MATRIX=/home/xiaolu/matrix/oregon
DSTMATRIX=/home/xiaolu/CTREnh/inputMat
cp $MATRIX $DSTMATRIX

# 1.1 test k=6 m=3
cd /home/xiaolu/CTREnh
./main 9 6 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_oregon.py 6 3

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 6 3 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_6_3_opt_oregon_$i
done

# 1.1 test k=8 m=1
cd /home/xiaolu/CTREnh
./main 9 8 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_oregon.py 8 1

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 8 1 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_8_1_opt_oregon_$i
done

# 1.1 test k=10 m=4
cd /home/xiaolu/CTREnh
./main 14 10 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_oregon.py 10 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 10 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_10_4_opt_oregon_$i
done

# 1.1 test k=12 m=4
cd /home/xiaolu/CTREnh
./main 16 12 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_oregon.py 12 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 12 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_12_4_opt_oregon_$i
done



# 1. requestor at california
cd /home/xiaolu/iperftest
python runiperf.py
cd /home/xiaolu/matrix
python collect.py california

MATRIX=/home/xiaolu/matrix/california
DSTMATRIX=/home/xiaolu/CTREnh/inputMat
cp $MATRIX $DSTMATRIX

# 1.1 test k=6 m=3
cd /home/xiaolu/CTREnh
./main 9 6 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_california.py 6 3

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 6 3 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_6_3_opt_california_$i
done

# 1.1 test k=8 m=1
cd /home/xiaolu/CTREnh
./main 9 8 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_california.py 8 1

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 8 1 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_8_1_opt_california_$i
done

# 1.1 test k=10 m=4
cd /home/xiaolu/CTREnh
./main 14 10 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_california.py 10 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 10 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_10_4_opt_california_$i
done

# 1.1 test k=12 m=4
cd /home/xiaolu/CTREnh
./main 16 12 1|grep "path:" >/home/xiaolu/matrix/path
cd /home/xiaolu/matrix
python createblk_california.py 12 4

cd /home/xiaolu/CTDR
for i in 1 2 3 4 5
do
timeout 30m ./optimal.sh 12 4 32768 2048 ctdr pipeline 4 $FALSE >${LOGDIR}/log_12_4_opt_california_$i
done

