#usage: python runiperf.py 

import os
import sys

logdir="/home/xiaolu/iperflog/"

cluster=[[""] * 2] * 16
cluster[0]=["ohio2", "52.14.97.165"]
cluster[1]=["ohio3", "52.14.53.124"]
cluster[2]=["ohio4", "52.14.104.92"]
cluster[3]=["ohio5", "52.14.72.239"]
cluster[4]=["california1", "54.183.87.142"]
cluster[5]=["california2", "52.53.210.52"]
cluster[6]=["california3", "52.53.232.194"]
cluster[7]=["california4", "54.67.47.129"]
cluster[8]=["oregon1", "35.166.45.82"]
cluster[9]=["oregon2", "50.112.19.78"]
cluster[10]=["oregon3", "35.161.4.24"]
cluster[11]=["oregon4", "52.34.6.118"]
cluster[12]=["canada1", "52.60.39.184"]
cluster[13]=["canada2", "52.60.103.4"]
cluster[14]=["canada3", "52.60.105.122"]
cluster[15]=["canada4", "52.60.96.226"]

os.system('rm /home/xiaolu/iperflog/*')

for i in range(0, len(cluster)):
	servername=cluster[i][0]
	serverip=cluster[i][1]
	logfile=logdir+servername
	os.system('echo start server on '+servername+' > '+logfile)
	os.system('ssh '+serverip+' \"iperf3 -s >>/dev/null & \"')
	start=int(0)
	for j in range(0, len(cluster)):
		if start==0:
			if cluster[j][0] == servername:
			 	start=1
		else:
			clientname=cluster[j][0]
			clientip=cluster[j][1]
			os.system('echo start client on '+clientname+' >> '+logfile)
			os.system('ssh '+clientip+' \"iperf3 -c '+serverip+'\" >> '+logfile)
	os.system('ssh '+serverip+' \"killall iperf3\"')
			
