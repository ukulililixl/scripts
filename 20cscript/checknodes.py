import sys
 
myargs=sys.argv
minnum=myargs[1]
num=myargs[4]

#print minnum
#print num
#print num+minnum 

if int(num) >= int(minnum):
    print 1
else:
    print 0
