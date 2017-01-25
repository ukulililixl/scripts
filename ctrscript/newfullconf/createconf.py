# python createconf.py k m packetsize packetnum degradedpolicy ctdrpolicy requesthandler distributor workerthread racknum shuffle

import os
import sys

K=sys.argv[1]
M=sys.argv[2]
N=int(K) + int(M)
PACKETSIZE=sys.argv[3]
PACKETNUM=sys.argv[4]
DPolicy=sys.argv[5]
CPolicy=sys.argv[6]
RHandler=sys.argv[7]
DNumber=sys.argv[8]
Worker=sys.argv[9]
racknum=sys.argv[10]
shuffle=sys.argv[11]

attribute=[]

line="<setting>"
attribute.append(line)

line="<attribute><name>erasure.code.k</name><value>"+K+"</value></attribute>"
attribute.append(line)

line="<attribute><name>erasure.code.n</name><value>"+str(N)+"</value></attribute>"
attribute.append(line)

line="<attribute><name>rs.code.config.file</name><value>/home/ncsgroup/xiaolu/CTDR/conf/rsEncMat</value></attribute>"
attribute.append(line)

line="<attribute><name>packet.size</name><value>"+PACKETSIZE+"</value></attribute>"
attribute.append(line)

line="<attribute><name>packet.count</name><value>"+PACKETNUM+"</value></attribute>"
attribute.append(line)

line="<attribute><name>degraded.read.policy</name><value>"+DPolicy+"</value></attribute>"
attribute.append(line)

line="<attribute><name>ctdr.policy</name><value>"+CPolicy+"</value></attribute>"
attribute.append(line)

line="<attribute><name>coordinator.address</name><value>10.10.10.22</value></attribute>"
attribute.append(line)

line="<attribute><name>coordinator.request.handler.thread.num</name><value>"+RHandler+"</value></attribute>"
attribute.append(line)

line="<attribute><name>coordinator.distributor.thread.num</name><value>"+DNumber+"</value></attribute>"
attribute.append(line)

line="<attribute><name>file.system.type</name><value>HDFS</value></attribute>"
attribute.append(line)

line="<attribute><name>hdfs.stripe.store</name><value>/home/ncsgroup/xiaolu/CTDR/stripeStore</value></attribute>"
attribute.append(line)

line="<attribute><name>hdfs.block.directory</name><value>/home/ncsgroup/xiaolu/CTDR/blkDir</value></attribute>"
attribute.append(line)

line="<attribute><name>path.shuffle</name><value>"+shuffle+"</value></attribute>"
attribute.append(line)

line="<attribute><name>agent.worker.thread.num</name><value>"+Worker+"</value></attribute>"
attribute.append(line)

line="<attribute><name>slaves.address</name>"
attribute.append(line)

cluster=["10.10.10.11",
	"10.10.10.12",
	"10.10.10.14",
	"10.10.10.15",
	"10.10.10.16",
	"10.10.10.17",
	"10.10.10.18",
	"10.10.10.19",
	"10.10.10.21",
	"10.10.10.23",
	"10.10.10.24",
	"10.10.10.25",
	"10.10.10.26",
	"10.10.10.27",
	"10.10.10.28",
	"10.10.10.29",
	"10.10.10.30",
	"10.10.10.32",
	"10.10.10.33"]

subnum=int(N)+1
racksize=int(subnum)/int(racknum)

for i in range(0, len(cluster)):
	if i<subnum:
		rackid=i/racksize
		if rackid==int(racknum):
			rackid=int(racknum)-1
		line="<value>rack"+str(rackid)+"/"+cluster[i]
	else:
		rackid="default"
		line="<value>"+rackid+"/"+cluster[i]
	line=line+"</value>"
	attribute.append(line)

line="</attribute>"
attribute.append(line)


# create conf for each node
# for coordinator
i=int(0)
filename="./config.xml_10.10.10.22"
for line in attribute:
#	print line
	if i==0:	
		os.system('echo \"' + str(line) + '\" > ' + filename)
	else:
		os.system('echo \"' + str(line) + '\" >> ' + filename)
	i=i+1

line="<attribute><name>local.ip.address</name><value>127.0.0.1</value></attribute>"
os.system('echo \"' + str(line) + '\" >> ' + filename)
line="</setting>"
os.system('echo \"' + line + '\" >> ' + filename)

os.system('cp ' + filename + ' /home/ncsgroup/xiaolu/CTDR/conf/config.xml')
os.system('cp rsEncMat_'+K+'_'+M + ' /home/ncsgroup/xiaolu/CTDR/conf/rsEncMat')

for node in cluster:
	filename="config.xml_"+node
	i=int(0)
	for line in attribute:
		if i==0: 
			os.system('echo \"' + line + '\" > ' + filename)
		else:
			os.system('echo \"' + line + '\" >> ' + filename)
		i=i+1
	line="<attribute><name>local.ip.address</name><value>"+node+"</value></attribute>"
	os.system('echo \"' + line + '\" >> ' + filename)
	line="</setting>"
	os.system('echo \"' + line + '\" >> ' + filename)
	os.system('scp ' + filename + ' ' + node + ":/home/ncsgroup/xiaolu/CTDR/conf/config.xml")
	os.system('scp rsEncMat_'+K+'_'+M + ' ' +	node+':/home/ncsgroup/xiaolu/CTDR/conf/rsEncMat')


