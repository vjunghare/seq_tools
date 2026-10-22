#!/usr/bin/python 

import numpy as np
import os

cwd = os.getcwd()
cwd = cwd + '/'

pep = ['Pepsin_pH_1.3','Pepsin_pH_2 ','Elastase1 ',' Elastase2 ','ChymotrypsinogenB1 ','ChymotrypsinC ',' PancreaticEndopeptidaseE ','Enteropeptidase ','Trypsin1',' Prostasin',' Gastricin', 'FruitBromelain','StemBromelain','Ananain','PapayaProteinase','Chymopapain','Chymosin'
, 'Caricain']


for p in pep:
	p = p.strip()
	f = open(cwd + p, "r")        
	f5 = open(cwd + p + '_5aa', "w+")
	f4 = open(cwd + p + '_4aa', "w+")
	f3 = open(cwd + p +'_3aa', "w+")
	f2 = open(cwd + p +'_2aa', "w+")
	count_5 = 0
	count_4 = 0
	count_3 = 0
	count_2 = 0
	lines = f.readlines()
	for line in lines:
		if ( len(line.strip()) == 5):
			count_5 = count_5+1
			f5.write(line)
		if ( len(line.strip()) == 4):
			count_4 = count_4+1
			f4.write(line)
		if ( len(line.strip()) == 3):
			count_3 = count_3+1
			f3.write(line)
		if ( len(line.strip()) == 2):
			count_2 = count_2+1
			f2.write(line) 
	if(count_5 == 0):
		f5.write("No peptide is available")
	if(count_4 == 0):
		f4.write("No peptide is available")
	if(count_3 == 0):
		f3.write("No peptide is available")
	if(count_2 == 0):
		f2.write("No peptide is available")

	f5.close()
	f4.close()
	f3.close()
	f2.close()

