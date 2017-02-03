# python newcreate.py K M

import os
import random
import sys

cluster=["52.14.97.165",
	"52.14.53.124",
	"52.14.104.92",
	"52.14.72.239",
	"54.183.87.142",
	"52.53.210.52",
	"52.53.232.194",
	"54.67.47.129",
	"35.166.45.82",
	"50.112.19.78",
	"35.161.4.24",
	"52.34.6.118",
	"52.60.39.184",
	"52.60.103.4",
	"52.60.105.122",
	"52.60.96.226"]

print len(cluster)

K=sys.argv[1]
M=sys.argv[2]
N=int(K)+int(M)

# 0. clean the blkDir and stripeStore in all the nodes
os.system('rm -rf /home/xiaolu/CTDR/stripeStore/*')
os.system('rm -rf ./stripeStore/*')
for i in range(0, len(cluster)):
	os.system('ssh ' + cluster[i] + ' "rm -rf /home/xiaolu/CTDR/stripeStore/*"')
for i in range(0, len(cluster)):
	os.system('ssh ' + cluster[i] + ' "rm -rf /home/xiaolu/CTDR/blkDir/*"')

# 1. create blklist and recoverlist
recover={}
for i in range(0, 4):
	idx=i*4;
	node=cluster[idx]
	recover[node]=[]

for stripeid in range(0, 4):
	# 1.1 choose requestor
	requestor=cluster[stripeid*4]
	# 1.2 choose subcluster to place this stripe
	subcluster=[]
	for node in cluster:
		if requestor!=node:
			subcluster.append(node)
	todelnum=len(subcluster)-int(N)
	for j in range(0, todelnum):
		r=random.randint(0, len(subcluster)-1)
		del subcluster[r]
 	print len(subcluster)
	if todelnum<0:
		subcluster.append(requestor)
	random.shuffle(subcluster)	
	# 1.3 place N blocks into subcluster
	stripestr=""
	blklist=[]
	for blkid in range(0, N):
		blkname="blk_"+str(stripeid)+"-"+str(blkid)
		blklist.append(blkname)
		if blkid==int(0):
			stripestr=stripestr+blkname+"_"+str(blkid)
		else:
			stripestr=stripestr+":"+blkname+"_"+str(blkid)
	# 1.4 create stripeStore
	for blkid in range(0, len(blklist)):
		blk=blklist[blkid]
		filename="rs:"+blk+"_"+str(blkid)
		os.system('echo ' + stripestr + " > /home/xiaolu/CTDR/input/stripeStore/" + filename)
	# 1.5 distribute blks to all the nodes
	for i in range(0, N):
		os.system('ssh '+subcluster[i]+' \"cp /home/xiaolu/CTDR/input/baseblk /home/xiaolu/CTDR/blkDir/'+blklist[i]+'\" &')
		if subcluster[i]==requestor:
			recover[requestor].append(blklist[i])

	# 1.6 create blk for requestor to read
	r=random.randint(0, len(blklist)-1)	
	if len(recover[requestor])==0:
		recover[requestor].append(blklist[r])

# 2 create issue file
start=int(0)
for (k, v) in recover.items():
	for item in v:
		if start==int(0):
			os.system('echo '+k+" "+item+' > /home/xiaolu/CTDR/input/issue')
			start=start+1
		else:
			os.system('echo '+k+" "+item+' >> /home/xiaolu/CTDR/input/issue')

# 3. distribute stripeStore
os.system('cp /home/xiaolu/CTDR/input/stripeStore/* /home/xiaolu/CTDR/stripeStore/')
for node in cluster:
	os.system('scp /home/xiaolu/CTDR/input/stripeStore/* ' + node + ':/home/xiaolu/CTDR/stripeStore')
