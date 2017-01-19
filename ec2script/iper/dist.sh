#!/bin/bash

virginia=54.210.48.215
ohio=52.14.53.218
california=54.67.66.211
oregon=35.167.180.92
canada=52.60.82.252
ireland=34.248.90.227
frankfurt=35.157.43.65
london=52.56.102.149
singapore=54.169.104.10
sydney=13.55.165.219
seoul=52.79.157.233
tokyo=52.199.128.5
mumbai=35.154.115.209
saopaulo=52.67.242.96
cluster=( $virginia $ohio $california $oregon $canada $ireland $frankfurt $london $singapore $sydney $seoul $tokyo $mumbai $saopaulo )

array=( "virginia:$virginia"
	"ohio:$ohio"
	"california:$california"
	"oregon:$oregon"
	"canada:$canada"
	"ireland:$ireland"
	"frankfurt:$frankfurt"
	"london:$london"
	"singapore:$singapore"
	"sydney:$sydney"
	"seoul:$seoul"
	"tokyo:$tokyo"
	"mumbai:$mumbai"
	"saopaulo:$saopaulo" )

virginia2=54.174.39.239
ohio2=52.14.33.83
california2=54.67.31.225
oregon2=35.166.35.128
canada2=52.60.39.201
ireland2=34.248.129.8
frankfurt2=35.156.131.133
london2=52.56.101.62
singapore2=52.77.250.120
sydney2=13.55.214.210
seoul2=52.79.183.8
tokyo2=54.64.36.117
mumbai2=35.154.108.22
saopaulo2=52.67.24.227


array2=( "virginia2:$virginia2"
        "ohio2:$ohio2"
        "california2:$california2"
        "oregon2:$oregon2"
        "canada2:$canada2"
        "ireland2:$ireland2"
        "frankfurt2:$frankfurt2"
        "london2:$london2"
        "singapore2:$singapore2"
        "sydney2:$sydney2"
        "seoul2:$seoul2"
        "tokyo2:$tokyo2"
        "mumbai2:$mumbai2"
        "saopaulo2:$saopaulo2" )
	
num=${#array[@]}
max=`expr $num - 1`

testnum=1

for i in `seq 0 ${max}`
do
      	server=${array[i]}
      	servername="${server%%:*}"
      	serverip="${server##*:}"
	scp ./iperftest.sh $serverip:~/iperftest/	
done

for i in `seq 0 ${max}`
do
        server=${array2[i]}
        servername="${server%%:*}"
        serverip="${server##*:}"
        scp ./iperftest.sh $serverip:~/iperftest/
done
