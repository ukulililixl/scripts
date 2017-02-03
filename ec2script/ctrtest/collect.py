# python collect.py city

import os
import sys

city=sys.argv[1]
logdir="/home/xiaolu/iperflog/"
tempfile="/home/xiaolu/iperflog/tempfile"

originmat=[[float(0)] for i in range(0, 16)]

citelist=["ohio2", "ohio3", "ohio4", "ohio5", "california1", "california2", "california3", "california4",
"oregon1", "oregon2", "oregon3", "oregon4", "canada1", "canada2", "canada3", "canada4"]

maplist={}
maplist["ohio"]=["ohio2", "ohio3", "ohio4", "ohio5", "california1", "california2", "california3", "california4",
"oregon1", "oregon2", "oregon3", "oregon4", "canada1", "canada2", "canada3", "canada4"]
maplist["california"]=["california1", "california2", "california3", "california4","oregon1", "oregon2", "oregon3", "oregon4",
"canada1", "canada2", "canada3","canada4","ohio2", "ohio3", "ohio4", "ohio5"]
maplist["oregon"]=["oregon1", "oregon2", "oregon3", "oregon4","canada1", "canada2", "canada3","canada4",
"ohio2", "ohio3", "ohio4", "ohio5","california1", "california2", "california3", "california4"]
maplist["canada"]=["canada1", "canada2", "canada3", "canada4","ohio2", "ohio3", "ohio4", "ohio5",
"california1", "california2", "california3", "california4","oregon1", "oregon2", "oregon3", "oregon4"]

for i in range(0, 16):
	templist=originmat[i]
	for j in range(0, 16-len(templist)):
		templist.append(float(0))
for i in range(0, 16):
	print citelist[i]
	filename=logdir+citelist[i]
	os.system('grep \"sender\" '+filename+' >'+tempfile)
	f=open(tempfile, "r")
	j=i+1
	line=f.readline()
	while line:
		arr=line.split()
		value=float(arr[4])
		originmat[i][j]=value
		originmat[j][i]=value
		line=f.readline()
		j=j+1

for i in range(0, 16):
	groupnum=i/4
	print groupnum
	tempvalue=float(0)
	for j in range(groupnum*4, (groupnum+1)*4):
		tempvalue=tempvalue+originmat[i][j]
	originmat[i][i]=("%f" % (tempvalue/3))

for i in range(0, 16):
	for j in range(0, 16):
		originmat[i][j]=("%f" % (float(1)/float(originmat[i][j])))

for i in range(0, 16):
	print originmat[i]
# now the originmat is the sequence in citylist	

# start to arrange the matrix
matrix=[[float(0)] for i in range(0, 16)]
mylist=maplist[city]
print mylist

for i in range(0, 16):
	templist=matrix[i]
	for j in range(0, 16-len(templist)):
		templist.append(float(0))

for i in range(0, 16):
	city1=mylist[i]
	index1=citelist.index(city1)
	for j in range(0, 16):
		city2=mylist[j]
		index2=citelist.index(city2)
	 	matrix[i][j]=originmat[index1][index2]

outputfile="/home/xiaolu/matrix/"+city
for i in range(0, 16):
	tempstr=""
	for j in range(0, 16):
		tempstr=tempstr+str(matrix[i][j])+" "
	if i==0:
		os.system('echo '+tempstr+' >'+outputfile)
	else:
		os.system('echo '+tempstr+' >>'+outputfile)
