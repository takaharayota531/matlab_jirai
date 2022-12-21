from operator import itemgetter
path = 'testVV.txt'
f = open('myfile.txt', 'w')
with open(path) as f:
    l = f.readlines()
    
    sorted_data = sorted(l,key=lambda x:(x[4],x[5].rstrip('\n')))
    print(l[0:10])
    f.write(str(sorted_data))
    f.close()
   
    