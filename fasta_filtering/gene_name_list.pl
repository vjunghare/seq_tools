#!/usr/bin/perl
# Seq file
open(SEQFILE,'uniprot-transpeptidase.fasta');
$cls='yst';
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
#@t_nwdata=@nwdata[1..10];
$k=0, $k2=0;
#filteration criteria
open (GEN_SEQFILE, '>gene_list.txt');
$er='>'; ## identifier of FASTA sequence
$seq_count=0;
foreach $i (@nwdata)
{
	if($i=~ /$er/)
	{
		#print $i;
		@i_seq=split('\n',$i);
		#$i_seq[0]=~s/\s/_/g;
		###### OS Filteration ######
		$uni_header = $i_seq[0];
		@split_header = split(/ /,$i_seq[0]);
		#print "$split_header[1]\n";
		$for_posi=0;
		$flag = 1;
		$diff_seq_flag=1;
		#print $i_seq[0];
		if(($i_seq[0]=~ /putative/i)||($i_seq[0]=~ /fragment/i))
		{
			$diff_seq_flag=0;
			#print $i_seq[0];
		}
		if($diff_seq_flag==1)
		{
			foreach $_ (@split_header)
			{
				
				if($_ =~ /OS/)
				{
					$temp_gene_name=join(' ',@split_header[1..($for_posi-1)]);
					if($seq_count==0)
					{
						push @gene_name, $temp_gene_name;
					}
					if($seq_count>0)
					{
						foreach $t_ (@gene_name)
						{
							#$temp_gene_name=~s/ /_/g;
							#$t_=~s/ /_/g;
							if($temp_gene_name  eq $t_)
							{
								$flag=0;
								last;
							}
						}
						if($flag==1)
						{

							push @gene_name, $temp_gene_name;
						}					
					}

					
					#print join (' ',$_, $split_header[($for_posi+1)]);
					
				}
				$for_posi=$for_posi + 1;
			}
		}
		
		$seq_count=$seq_count+1;
	}
}
@gene_name=sort @gene_name;
foreach $ui (@gene_name)
{
	print GEN_SEQFILE $ui;
	print GEN_SEQFILE "\n";
}
#print "@gene_name\n";
close SEQFILE;
close GEN_SEQFILE;
print"\nDONE!\n";
exit;