#python createblk_ohio.py k m 

import os
import random
import sys

K=sys.argv[1]
M=sys.argv[2]
N=int(K)+int(M)

cluster=["52.60.39.184",
	"52.60.103.4",
	"52.60.105.122",
	"52.60.96.226",
	"52.14.97.165",
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
        "52.34.6.118"]

# 0. clean stripeStore and blkDir
os.system('rm -rf /home/xiaolu/CTDR/stripeStore/*')
os.system('rm -rf ./stripeStore/*')

for i in range(0, len(cluster)):
	os.system('ssh ' + cluster[i] + ' "rm -rf /home/xiaolu/CTDR/stripeStore/*"')
for i in range(0, len(cluster)):
	os.system('ssh ' + cluster[i] + ' "rm -rf /home/xiaolu/CTDR/blkDir/*"')

# 1. create a path
path=[]
f=open("path", "r")
line=f.readline()
while line:
	arr=line.split()
	for i in range(1, len(arr)):
		path.append(arr[i])
	line=f.readline()

# 2. create stripeStore
stripestr=""
blklist=[]
for blkidx in range(0, N):
	if blkidx<int(10):
		blkname="blk_"+str(blkidx)
	elif blkidx==int(10):
		blkname="blk_a"
	elif blkidx==int(11):
		blkname="blk_b"
	elif blkidx==int(12):
		blkname="blk_c"
	elif blkidx==int(13):
		blkname="blk_d"
	elif blkidx==int(14):
		blkname="blk_e"
	elif blkidx==int(15):
		blkname="blk_f"
	elif blkidx==int(16):
		blkname="blk_g"
	blklist.append(blkname)
	if blkidx==int(0):
		stripestr=stripestr+blkname+"_"+str(0)
	else:
		stripestr=stripestr+":"+blkname+"_"+str(0)
	
#print blklist
#print stripestr
	
for blkid in range(0, N):
	blk=blklist[blkid]
	filename="rs:"+blk+"_"+str(blkid)
	os.system('echo ' + stripestr + " > /home/xiaolu/matrix/stripeStore/" + filename)
os.system('cp /home/xiaolu/matrix/stripeStore/* /home/xiaolu/CTDR/stripeStore/')
for node in cluster:
	os.system('scp /home/xiaolu/matrix/stripeStore/* ' + node + ':/home/xiaolu/CTDR/stripeStore')


# 3. distribute	blk to all the nodes
requestor=cluster[0]
for blkid in range(0, int(K)+1):
	if blkid==int(0):
		node=cluster[0]
		blk=blklist[0]
#		print node, blk
		os.system('ssh '+node+' \"cp /home/xiaolu/CTDR/input/baseblk /home/xiaolu/CTDR/blkDir/'+blk+'\" &')
	else :
		nodeidx=int(path[blkid-1])
		node=cluster[nodeidx]
		blk=blklist[blkid]
#		print nodeidx, node, blk
		os.system('ssh '+node+' \"cp /home/xiaolu/CTDR/input/baseblk /home/xiaolu/CTDR/blkDir/'+blk+'\" &')

newpath=[]
for i in range(0, len(path)):
	newpath.append(int(path[i]))
newpath.sort()
newpath.reverse()
for i in range(0, len(newpath)):
	nodeidx=int(newpath[i])
#	print "delete", nodeidx, cluster[nodeidx]
	del cluster[nodeidx]

for blkid in range(int(K)+1, N):
	blk=blklist[blkid]
	r=random.randint(0, len(cluster)-1)
	node=cluster[r]
	del cluster[r]
#	print node, blk
	os.system('ssh '+node+' \"cp /home/xiaolu/CTDR/input/baseblk /home/xiaolu/CTDR/blkDir/'+blk+'\" &')

# 4. issue file
os.system('echo '+requestor+" blk_0"+' > /home/xiaolu/CTDR/input/issue')


