import urllib2
import glob
for name in glob.glob('*.list'):
    gene=name.split('.')[0]
    print gene
    gene_n=gene + '-seq-protein.fasta'
    f_ = open(gene_n, 'w+')
    f_1 = open(name, 'r')
    data=f_1.readlines()
    for i in data:
        i=i.strip()
        url='http://www.bldb.eu/seq_prot/'+i
        print url
        response = urllib2.urlopen(url)
        webContent = response.read()
        f_.write(webContent)
        f_.write("\n")
    f_.close
    f_1.close
print("\nSequence feching has been successfully done!\n")


