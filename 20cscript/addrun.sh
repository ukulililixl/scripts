#!/bin/bash

# 

for i in 11 12 13 14 15
do
    timeout 30m ./test.sh 12 4 64 1 ctdr $i
done

for i in 11 12 13
do
    timeout 30m ./test.sh 12 4 64 1 conv $i
done

