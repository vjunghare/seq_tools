#!/usr/bin/perl -w

open(SEQFILE,'uniprot-malic+AND+enzyme+AND+length%3A%5B500+TO+600%5D.fasta');
@data=<SEQFILE>;
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
$k=0;
$k2=0;
$k3=0;
#print $nwdata[2];
#@f_data;
$find='malic';
$find2='Malic';
$find3='Fragment';
open (F_SEQFILE, '>malic.fasta');
#sub data_process()	
	foreach $i (@nwdata){
		@i_seq=split('\n',$i);
		#print $i_seq[0];
		shift @i_seq;
		$i_temp_seq=join ("",@i_seq);
		$i_temp_seq =~ s/\n//g;
		$i_seq_len=length($i_temp_seq);
		print $i_seq_len;
		if(($i=~ /$find/)&&($i_seq_len<600)&&($i_seq_len>500)){
			$k=$k+1;
			#push @f_data, $i;
			if($i=~ /$find3/){
				$k2=$k2+1;
			}
			else{
				$k3=$k3+1;
				print F_SEQFILE $i;
				print F_SEQFILE "\n";
				push @f_data, $i;
			}
		}
		if(($i=~ /$find2/)&&($i_seq_len<600)&&($i_seq_len>500)){
			$k=$k+1;
			#push @f_data, $i;
			if($i=~ /$find3/){
				$k2=$k2+1;
			}
			else{
				$k3=$k3+1;
				print F_SEQFILE $i;
				print F_SEQFILE "\n";
				push @f_data, $i;
			}
		}		
	}
print $i_seq_len;
#print @f_data;

print "\n";
print "$k, $k2, $k3";


close SEQFILE;
close F_SEQFILE;
#data_process();
system ("muscle -in malic.fasta -fastaout malic_aln_fa4.fasta -clwout malic_aln_clw4.aln -maxiters 2");
print "\n........Alignment is done !.......\n";

#open(CLWALNFILE,'xrdata_wo_frag4.aln');
#@aln_data=<CLWALNFILE>;

exit;
