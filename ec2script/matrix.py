# python matrix.py testnum

import os
import sys

testnum=sys.argv[1]

cluster=["virginia", "ohio", "california", "oregon", "canada", "ireland", "frankfurt", "london", "singapore", "sydney", "seoul", "tokyo", "mumbai", "saopaulo"]

num=len(cluster)

matrix=[[0 for col in range(num)] for row in range(num)]

for i in range(0, num):
	city=cluster[i]
	file=city+"_"+testnum
	os.system('grep sender ' + file + ' >res')
#	os.system('cat res')
	
	f=open("res", "r")
	j=i
	line=f.readline()
	while line:
		arr=line.split()
		matrix[i][j]=arr[6]
		sys.stdout.write(arr[6])
		sys.stdout.write(" ")
		j=j+1
		line=f.readline()

	print " "
	os.system('grep receiver ' + file + ' >res')

	f=open("res", "r")
	j=i+1
	line=f.readline()
	line=f.readline()
	while line:
		arr=line.split()
		matrix[j][i]=arr[6]
		j=j+1
		line=f.readline()
# for i in range(0,num):
# 	for j in range(0, num):
# 		sys.stdout.write(matrix[i][j])
# 		sys.stdout.write(" ")
# 	print " "
			
