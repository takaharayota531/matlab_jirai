from operator import itemgetter
import sys 
args = sys.argv
print(args[1])
print(args[2])
path = args[1]

f1 = open(args[2], 'w')
with open(path) as f:
    lines=f.readlines()
    
    target_list = []
    ix=0
    iy=0
    divide_fre_index=0
    INDEX=200
    
    divide_index_y_target=int(args[3])
    for line in lines:
        
        # line=f.readline()
        if(not line):
            break
        tmp=line.split()
        # print(divide_fre_index)
        # print(tmp[2])
        # print(tmp[3])
        tmp_message=str(tmp[0])+' '+str(tmp[1])+' '+str(tmp[2])+' '+str(tmp[3])+' ' +str(ix)+' '+str(iy)  +'\n'
        target_list.append(tmp_message)
        
        divide_fre_index+=1
        if divide_fre_index==INDEX+1:
            iy+=1
            divide_fre_index=0
            
           
            
        if iy==divide_index_y_target+1 :
            iy=0
            ix+=1
        
        
       
    for i in range(len(target_list)):
        f1.writelines(target_list[i])
    
    
    
    f.close()
    f1.close()
   
    