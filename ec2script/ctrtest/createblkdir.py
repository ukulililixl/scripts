# python createblkdir.py k m stripenum

import os
import random
import sys

K=sys.argv[1]
M=sys.argv[2]
STRIPE=sys.argv[3]
N=int(K)+int(M)
subnum=N+1
basedir="/home/xiaolu/CTDR/input"
cluster=["52.14.97.165",
	"52.14.53.124",
	"52.14.89.141",
	"52.14.72.239",
	"54.183.87.142",
	"52.53.210.52",
	"52.53.232.194",
	"52.53.163.41",
	"35.166.45.82",
	"50.112.19.78",
	"35.161.4.24",
	"52.34.6.118",
	"52.60.39.184",
	"52.60.103.4",
	"52.60.105.122",
	"52.60.96.226"]

# cluster=["54.183.87.142",
# 	"52.53.210.52",
# 	"52.53.232.194",
# 	"52.53.163.41",
# 	"35.166.45.82",
# 	"50.112.19.78",
# 	"35.161.4.24",
# 	"52.34.6.118",
# 	"52.60.39.184",
# 	"52.60.103.4",
# 	"52.60.105.122",
# 	"52.60.96.226",
# 	"52.14.97.165",
# 	"52.14.53.124",
# 	"52.14.89.141",
# 	"52.14.72.239"]

subcluster=[]

# 0. clean

for i in range(0, len(cluster)):
	os.system('ssh ' + cluster[i] + ' "rm -rf /home/xiaolu/CTDR/blkDir/*"')

os.system('rm -rf /home/xiaolu/CTDR/stripeStore/*')
os.system('rm -rf ./stripeStore/*')

for i in range(0, len(cluster)):
	os.system('ssh ' + cluster[i] + ' "rm -rf /home/xiaolu/CTDR/stripeStore/*"')


# 1. choose subnum of nodes in sub-cluster, we will put data into
# these nodes
for i in range(0, subnum):
	subcluster.append(cluster[i])

# print "subcluster:"
# for name in subcluster:
# 	print name

# 2. try to create a stripe first
recover=[[] for n in range(0, subnum)]
for stripeid in range(0, int(STRIPE)):
#	print "stripe"+str(stripeid)+":"
	idxInStripe=int(0)
	stripestr=""	# record the stripe info in this stripe, will be used in creating stripeStore
	blklist=[]   	# record all the blks in this stripe
	
	# 2.0 write into blklist and stripestr
	for blkid in range(0, N):
		blkname="blk_"+str(stripeid)+"-"+str(blkid)
		blklist.append(blkname)
#		print blkname
		if blkid == int(0):
			stripestr=stripestr+blkname+"_"+str(idxInStripe)
		else:
			stripestr=stripestr+":"+blkname+"_"+str(idxInStripe)
		idxInStripe = idxInStripe + 1
#	print stripestr

	# 2.1 create stripeStore
	for i in range(0, len(blklist)):
#	for blk in blklist:
		blk=blklist[i]
	 	filename="rs:"+blk+"_"+str(i)
		os.system('echo ' + stripestr + " > stripeStore/" + filename)
	
	# 2.2 shuffle blks in blklist 
	random.shuffle(blklist)

	# 2.3 distribute blks and stripe info to different node
	recoverid=(stripeid + N) % subnum
 	for i in range(0, N):
		nodeidx=(stripeid + i) % subnum
#		print "scp " + blklist[i] + " to " + subcluster[nodeidx]
#		os.system('scp baseblk ' + subcluster[nodeidx] + ':/home/xiaolu/CTDR/blkDir/' + blklist[i])
		os.system('ssh '+subcluster[nodeidx]+' \"cp /home/xiaolu/CTDR/input/baseblk /home/xiaolu/CTDR/blkDir/'+blklist[i]+'\"')
	tempid = random.randint(0, N-1)
	recover[recoverid].append(blklist[tempid])
#	recover[recoverid]=blklist[tempid]

# 3. create issue file for recovery
start=int(0)
for i in range(0,subnum):
#	print "issue CTDRClient on " + subcluster[i] + " to read " + recover[i]
#	print len(recover[i])
	if len(recover[i]) > 0:
		if start==0:
#			print recover[i]
			for j in range(0, len(recover[i])):
				if j==0:
					os.system('echo ' + subcluster[i] + ' ' + recover[i][j] + ' > issue')
				else:
					os.system('echo ' + subcluster[i] + ' ' + recover[i][j] + ' >> issue')
#			os.system('echo ' + subcluster[i] + ' ' + recover[i] + ' > issue')
			start=start+1
		else:
#			print recover[i]
			for j in range(0, len(recover[i])):
				os.system('echo ' + subcluster[i] + ' ' + recover[i][j] + ' >> issue')
#			os.system('echo ' + subcluster[i] + ' ' + recover[i] + ' >>	issue')

#  # 4. copy stripeStore
#  CTDR_HOME="/home/xiaolu/CTDR/"
#  
#  # os.system('rm ' + CTDR_HOME + 'stripeStore/*')
#  os.system('cp ./stripeStore/* /home/xiaolu/CTDR/stripeStore/')
#  
#  for node in cluster:
#  #	os.system('ssh ' + node + ' "rm /home/xiaolu/CTDR/stripeStore/*"')
#  	os.system('scp ./stripeStore/* ' + node + ':/home/xiaolu/CTDR/stripeStore')
