#!/usr/bin/perl -w
# Seq file
open(SEQFILE,'uniprot-Xylose+reductase.fasta');
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
$k=0, $k2=0, $k3=0;
#@f_data;
#filteration criteria
@find=('xylose','Xylose', 'reductase', 'Reductase');
$avoid=('Fragment');
#$find2='Xylose';
#$find3='Fragment';
open (F_SEQFILE, '>xylose_reductase_wo_farg.fasta');
#sub data_process()	
	foreach $i (@nwdata)
	{
		@i_seq=split('\n',$i);
		shift @i_seq;
		$i_temp_seq=join ("",@i_seq);
		$i_temp_seq =~ s/\n//g;
		$i_seq_len=length($i_temp_seq);
		for($x=0;$x<2;$x++)
		{	
			if(((($i=~ /$find[$x]/)&&($i=~ /$find[2]/))||(($i=~ /$find[$x]/)&&($i=~ /$find[3]/)))&&($i_seq_len<400)&&($i_seq_len>200))
			{
				$k=$k+1;
				push @f_data, $i;
				if($i=~ /$avoid/)
				{
					$k2=$k2+1;
				}
				else
				{
					$k3=$k3+1;
					print F_SEQFILE $i;
					print F_SEQFILE "\n";
					push @f_data, $i;
				}
			}
		}
	}
print $i_seq_len;
#print @f_data;

print "\nXR Seq- $k,\nFragment- $k2,\n Final Seq- $k3\n";

close SEQFILE;
close F_SEQFILE;
#data_process();
system ("muscle -in xylose_reductase_wo_farg.fasta -fastaout xrdata_aln_fa5.fasta -clwout xrdata_aln_clw5.aln -maxiters 3");
print "\n........Alignment is done !.......\n";

#open(CLWALNFILE,'xrdata_wo_frag4.aln');
#@aln_data=<CLWALNFILE>;

exit;
