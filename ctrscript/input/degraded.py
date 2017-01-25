# python degraded.py

import os
import sys
import threading
import time

f=open("issue", "r")

dictionary={}

line=f.readline()
while line:
	arr=line.split()
	if dictionary.has_key(arr[0]):
		dictionary[arr[0]].append(arr[1])
	else:
		dictionary[arr[0]]=[]
		dictionary[arr[0]].append(arr[1])
#	dictionary[arr[0]]=arr[1]
	line=f.readline()

diclen=len(dictionary)

class myThread(threading.Thread):
	def __init__(self, machine, blk):
		threading.Thread.__init__(self)
		self.machine = machine
		self.blk = blk
	def run(self):
		print "Starting CTDRClient on "+self.machine+" to read "+self.blk
		os.system('ssh '+self.machine+' "cd xiaolu/CTDR; ./CTDRClient '+self.blk+'"')

threads=[]

for (k, v) in dictionary.items():
	for item in v:
		t = myThread(k, item)
		t.start()
		threads.append(t)

for t in threads:
	t.join()
