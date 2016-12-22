#!/bin/bash


for i in 1 2 3 4 5 6 7 8 9 10
do
  for policy in ctdr conv ppr
  do
    timeout 20m ./degradedtest.sh 10 1 64 1 $policy $i
  done
done

for i in 1 2 3 4 5 6 7 8 9 10
do
  timeout 20m ./degradedbasetest.sh 10 1 64 0 baseline $i
done
