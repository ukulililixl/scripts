#!/bin/bash
# usage: ./test.sh k m blocksize usectdr policy run

K=$1
M=$2
BLOCKSIZE=$3
USECTDR=$4
POLICY=$5
RUN=$6

RES=/home/ncsgroup/xiaolu/hadoopctdrlogs/degradedlogs/res_${K}_${M}_${BLOCKSIZE}_${USECTDR}_${POLICY}_${RUN}
HADOOPHOME=/home/ncsgroup/xiaolu/hadoop-20-ctdr

echo "start k=$K m=$M blocksize=${BLOCKSIZE}MB usectdr=$USECTDR policy=$POLICY for the $RUN time of degraded read" >$RES
date >>$RES

# 0 clear last run
echo "clear last run" >>$RES
stop-mapred.sh
stop-raidnode.sh
stop-dfs.sh
${HADOOPHOME}/killjava.sh
${HADOOPHOME}/clear_ctdr.sh
sleep 60

# 1. distribute hdfs-site.xml
HDFSSITE=/home/ncsgroup/xiaolu/lxltest/conf/hdfs-site-${K}-${M}-${BLOCKSIZE}MB-${USECTDR}.xml
echo "hdfs-site:${HDFSSITE}" >>$RES
cp $HDFSSITE ${HADOOPHOME}/conf/hdfs-site.xml
${HADOOPHOME}/distribute_hdfs.sh

# 2. format hdfs and start dfs
echo "format hdfs and start dfs" >>$RES
hadoop namenode -format
sleep 60
start-dfs.sh

# 3. check whether dfs start fine
tryCount="0"
nodenum=`expr ${K} + ${M}`
while [ $tryCount -lt 5 ]
do
    tryCount=$[$tryCount+1]
    s=`hadoop dfsadmin -report|grep total`
    checkres=`python checknodes.py ${nodenum} $s`
    if [ "$checkres" == "0" ]
    then
        echo "Warning: datanodes not enough for this run.---1">>$RES
        stop-dfs.sh; sleep 10
        start-dfs.sh; sleep 10
    else
        echo "datanodes enough for this run.---1">>$RES
        break
    fi
done

# 4. write file into hdfs
BASIC1=/home/ncsgroup/xiaolu/wordcount/wdinput_${BLOCKSIZE}_1
numtemp=`expr $K - 1`
BASIC2=/home/ncsgroup/xiaolu/wordcount/wdinput_${BLOCKSIZE}_${numtemp}
echo "basic file is $BASIC1 and $BASIC2" >>$RES
TIMES=1
echo "write into hdfs $BASIC1" >>$RES
hadoop dfs -put $BASIC1 raidTest/input1
echo "write into hdfs $BASIC2" >>$RES
hadoop dfs -put $BASIC2 raidTest/input2

sleep 60

# 5. start raidnode
echo "start raidnode" >>$RES
start-raidnode.sh
sleep 60

# 6. check erasurecoding
echo "check erasure coding" >>$RES
${HADOOPHOME}/check.sh > /home/ncsgroup/xiaolu/lxltest/checkblock
checkres=`exec python erasurecoding.py rs`
codeready="1"
checkidx=1
while [ "$checkres" == "0" ]
do
    if [ $checkidx -eq 10 ]
    then
        echo "not erasure coding well in this run, please restart" >>$RES
        codeready="0"
        break
    fi
    sleep 60
    echo "not finish replication to erasure coding">>$RES
    ${HADOOPHOME}/check.sh > /home/ncsgroup/xiaolu/lxltest/checkblock
    checkres=`exec python erasurecoding.py rs`
    checkidx=`expr $checkidx + 1`
done

if [ "$codeready" == "1" ]
then
    echo "finish replication to erasure coding at:" >>$RES
    date >>$RES
else
    exit
fi

echo "block placement is:" >>$RES
${HADOOPHOME}/check.sh >> $RES

# 7. stop raidnode
echo "stop-raidnode" >>$RES
stop-raidnode.sh

# 8. find a node have data
nodeid=`exec python find.py`
echo "find a nodeid have block is $nodeid" >>$RES

sleep 60

# # 9. start ctdr
# echo "start ctdr with k=$K m=$M policy=$POLICY nodeid=$nodeid" >>$RES
# ssh cloud-node12 "/home/ncsgroup/CTDR/test.sh $K $M $POLICY $nodeid"

# sleep 30

# 10. rm data
echo "rm data on $nodeid">>$RES
TMP=`ssh ${nodeid} "find -name finalized"`
FS=${TMP:2}
FS=/home/ncsgroup/$FS
echo "data path on $nodeid : $FS" >>$RES
echo "delete data in that path" >>$RES
ssh $nodeid "rm ${FS}/*"

# # 11. stop dfs
# echo "stop dfs">>$RES
# stop-dfs.sh
# sleep 60
# 
# # 12. redistribute hdfs-site
# echo "redistribute hdfs-site">>$RES
# SITEFILE=${HADOOPHOME}/conf/hdfs-site.xml
# sed -i "6a\
# <property><name>hdfs.raid.min.filesize</name><value>1000000000000</value></property>" $SITEFILE
# ${HADOOPHOME}/distribute_hdfs.sh
# sleep 60
# 
# # 13. start dfs and check whether is restart fine
# ${HADOOPHOME}/killjava.sh
# start-dfs.sh
# ${HADOOPHOME}/check.sh > /home/ncsgroup/xiaolu/lxltest/checkblock
# restartcheck=`cat checkblock | grep -i "MISSING\!" | wc -l`
# while [ $restartcheck -gt 1 ]
# do 
#     echo "not well restarted" >>$RES
#     stop-dfs.sh
#     sleep 60
#     start-dfs.sh
#     ${HADOOPHOME}/check.sh > /home/ncsgroup/xiaolu/lxltest/checkblock
#     restartcheck=`cat checkblock | grep -i "MISSING\!" | wc -l`
# done
# 
# echo "now block placement is:" >>$RES
# ${HADOOPHOME}/check.sh >>$RES
# 
# # 14. START RAIDNODE
# echo "start-raidnode" >>$RES
# start-raidnode.sh
# sleep 60
# echo "check recover" >>$RES
# recoverres=`./donerecover.sh`
# idx=1
# while [ "$recoverres" == "0" ]
# do
#     if [ $idx -gt 10 ]
#     then
#         echo "there is something wrong is this recover, please restart"
#         break
#     fi
#     echo "not finish recover" >>$RES
#     sleep 60
#     recoverres=`./donerecover.sh`
#     idx=`expr $idx + 1`
# done
# 
# echo "now block placement is:" >>$RES
# ${HADOOPHOME}/check.sh >>$RES

# 14 degraded read
rm output
time hadoop dfs -copyToLocal raidTest/input1 output >>$RES 2>&1

sleep 30

# # 15 backup logs
# HADOOPLOG=/home/ncsgroup/xiaolu/hadoopctdrlogs/degradedlogs
# CTDRLOG=/home/ncsgroup/xiaolu/hadoopctdrlogs/ctdrlogs
# for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
# do
# echo "on cloud-node$i"
# ssh cloud-node$i "cp -r /home/ncsgroup/xiaolu/hadoop-20-ctdr/logs ${HADOOPLOG}/logs_${K}_${M}_${BLOCKSIZE}_${USECTDR}_${POLICY}_${RUN}"
# ssh cloud-node$i "cp -r /home/ncsgroup/CTDR/output ${CTDRLOG}/degradedoutput_${K}_${M}_${BLOCKSIZE}_${USECTDR}_${POLICY}_${RUN}"
# done 
# 
# date >>$RES
