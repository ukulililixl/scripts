#!/bin/bash

virginia=54.210.48.215
ohio=52.14.53.78
california=54.67.102.120
oregon=35.167.107.79
canada=52.60.103.85
ireland=52.31.15.230
frankfurt=35.156.150.213
london=52.56.98.43
singapore=54.169.67.87
sydney=13.55.15.2
seoul=52.79.176.239
tokyo=54.64.152.3
mumbai=35.154.106.140
saopaulo=52.67.112.53

virginia2=52.206.206.116
ohio2=52.14.22.154
california2=52.53.171.34
oregon2=52.10.61.191
canada2=52.60.88.57
ireland2=52.214.132.145
frankfurt2=35.157.42.119
london2=52.56.102.187
singapore2=54.179.190.224
sydney2=13.55.152.73
seoul2=52.79.174.52
tokyo2=52.193.23.50
mumbai2=35.154.91.26
saopaulo2=52.67.201.160

cluster=( $virginia  $ohio  $california  $oregon  $canada  $ireland  $frankfurt  $london  $singapore  $sydney  $seoul  $tokyo  $mumbai  $saopaulo 
	  $virginia2 $ohio2 $california2 $oregon2 $canada2 $ireland2 $frankfurt2 $london2 $singapore2 $sydney2 $seoul2 $tokyo2 $mumbai2 $saopaulo2 )



for item in ${cluster[@]}
do
	ssh $item "mkdir iperftest"
	ssh $item "mkdir iperflog"
done
