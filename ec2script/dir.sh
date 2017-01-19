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
cluster=( $virginia $ohio $california $oregon $canada $ireland $frankfurt $london $singapore $sydney $seoul $tokyo $mumbai $saopaulo )

for item in ${cluster[@]}
do
	ssh $item "mkdir iperftest"
done
