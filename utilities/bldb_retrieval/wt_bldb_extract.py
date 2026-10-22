import urllib2
import glob
f_2=open("WT-error.txt",'w')
#for name in glob.glob('*.list'):
	#gene=name.split('.')[0]
	#print gene
	#gene_n=gene + '-seq-protein.fasta'
f_ = open('wild_type-mod.fasta', 'w+')
f_1 = open('/home/vivz/Documents/amr_database/class_A/clsA_nw.list', 'r')
data=f_1.readlines()
for i in data:
	try:
		i=i.strip()
		url='http://www.bldb.eu/seq_prot/'+i
		print url
		response = urllib2.urlopen(url)
		webContent = response.read()
		f_.write(webContent)
		f_.write("\n")
	except:
		f_2.write("%s\n"%i)
		pass
f_.close
f_1.close
f_2.close
print("\nSequence feching has been successfully done!\n")


