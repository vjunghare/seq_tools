import sys
import glob
from Bio import SeqIO

for SeqFile in glob.glob("*.fasta"):
    for record in SeqIO.parse(SeqFile, "fasta"):
        # print(record.id)
        u_id=((record.id).split('|'))[1]
        print(u_id)
        f=open("%s.fasta" %(u_id), "w")
        f.write('>%s\n'%record.description)
        f.write('%s'%record.seq)
        f.close()
        # print(record.description)
        # print(record.seq)
        # b=record.seq
