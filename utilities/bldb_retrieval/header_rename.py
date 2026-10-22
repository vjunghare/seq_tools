#!/usr/bin/python
import glob
gene_list=[]
for name in glob.glob('*-seq-protein.fasta'):
    gene_list.append(name)
#gene_list.append("OXA-seq-protein.fasta")
print (gene_list)
for gn in gene_list:
    gene_fn=gn.split('.')[0]
    gene_n=gn.split('-')[0]
    print (gene_n)
    f1=open(gn,"r")
    gene_nm=gene_fn + '_mod.fasta'
    f2=open(gene_nm,"w+")
    data=f1.read()
    #data=data.replace('>','#>')
    #print data
    seqs=[]
    seqs=data.split('>')
    seqs.pop(0)
    #print seqs
    i_count=0
    for i in seqs:
        i_count=i_count+1
        i_split=i.split('\n')
        i_header=i_split[0]
        i_split.pop(0)
        i_seq=''.join(i_split)
        i_seq.replace('\n','')
        seq_len=len(i_seq)
        #print i_header
        #print '\n'
        #print i_seq
        #print '\n\n'
        i_hsplit=i_header.split('|')
        i_id=[]
        i_gene=[]
        i_h_len=len(i_hsplit)
        flag=0
        for j in i_hsplit:
            if('.' in j):
                i_id.append(j)
            if((gene_n+'-') in j):
                i_gene=j
            if('[' in j):
                flag=1
                org_split=j.split('[')
                i_org=org_split[1].split(']')[0]
        i_gene=i_hsplit[i_h_len-2]
        if (flag==0):
            i_org='NA'
        if(flag==1):
            i_org.replace(" ","_")
        print (i_org)
        i_org2="_".join(i_org.split())
        i_nw_header=">" +i_org2 + "|"+i_id[0]+"|"+ i_gene+"|hlab_BL-B1-"+ str(i_count)
        i_nw_header.replace(" ", "_")
        f2.write(i_nw_header+"\n" + i_seq +"\n\n")
    f2.close()
    f1.close()
print ("DONE")
