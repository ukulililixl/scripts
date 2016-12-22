# python erasurecoding.py rs
import sys
myargs=sys.argv

f = open("checkblock");
code=myargs[1]

codepath = "/"+code+"/user/ncsgroup/raidTest"
#print codepath
CHECK=False
START=False
path=""


line = f.readline()
while line:
#    print line
    if START == False:
        if line.find(codepath,0,len(line)) == 0:
#            print line
            START = True
    else:
        arr = line.split()
        if len(arr) < 6:
            CHECK = True
            break
        elif len(arr) > 6:
            CHECK = False
            break
    line = f.readline()
f.close()

if CHECK == False:
    print 0
else:
    print 1
