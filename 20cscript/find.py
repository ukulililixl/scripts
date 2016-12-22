import sys
 
sourcepath = "/user/ncsgroup/raidTest"
START = False
path = ""

f = open("checkblock","r")

line = f.readline()
while line:
    if START == False:
        if line.find(sourcepath, 0, len(sourcepath)) == 0:
            START = True
    else:
        arr = line.split()

        if line[0] == '/':
            line = f.readline()
            continue
        elif len(arr) == 0:
            line = f.readline()
            continue
        elif line.find("Status", 0, len("Status")) == 0:
            break
        else:
            arr = line.split()
            nodeaddr = arr[4]
#            print nodeaddr
            nodeaddr = nodeaddr[1:len(nodeaddr)-7]
            print nodeaddr
            break
    line = f.readline()

f.close()
