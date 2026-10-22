#!/usr/bin/perl
###################   Gene Bank Protein Sequence   ############################
# Seq file
open(SEQFILE,'blast-i7-qc7.fasta');
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/@>/g;
@nwdata=split('@', $line);
$k=0, $k2=1;
#filteration criteria
$seq_added=1;
$er='>'; ## identifier of FASTA sequence
open(NON_ORGI,'>non_organism_input.fasta');
open(REPEAT_ORGI,'>repeated_organism_input.fasta');
open(F_ORGI,'>single_organism_input.fasta');
open(N_ORGI,'>organism_list.docx');
foreach $i (@nwdata)
{
	if($i=~ /$er/)
	{
		#print "$i\n";
		@i_seq=split('\n',$i);
		#$i_seq[0]=~s/\s/_/g;
		###### OS Filteration ######
		#$lac='lactamase';
		$i_header=$i_seq[0];
		if ($i_seq[0]=~/\[/)
		{
			@split_header = split(/\[/,$i_seq[0]);
			@sp_split_header = split(/\s/,$split_header[1]);
			$orgi = join(" ",$sp_split_header[0],$sp_split_header[1]);
			print "$orgi\n";
			@sp_header=split(/\s/,$split_header[0]);
			$count=0;
			#print "$gene_c\n";
			#print "$sp_header[$gene_c-1]\n";
			#print "$sp_header[0]\n";
			#if($split_header[0]=)
			$orgi=~s/\s/_/g;
			if ($k==0)
			{
				push @orgi_extract, $orgi;
			}
			$orgi_fail=0;
			if($k>0)
			{
				foreach $nam (@orgi_extract)
				{
					#print "$nam\n$orgi\n";
					if ($orgi =~ m/$nam/i)
					{
						#print "$nam";
						$orgi_fail=1;
					}
				}
				if($orgi_fail == 1)
				{
					print REPEAT_ORGI $i;
					print REPEAT_ORGI "\n";
				}
				#@id_extract= split(/\s/,$sp_header[0]);
				$i_id=$sp_header[0];
				$i_os=$orgi;
				#$i_gene=$sp_header[$gene_c-1];
				$cls='beta-lactamase|';
				
				#$i_header=('>seq|'. $i_id .'|'. $i_os .'|'. $cls .'hazralab_'. '_' . $k2);
				$tp=shift @i_seq;
				if($orgi_fail == 0)
				{
					print "$sp_header[$gene_c-1]\n";
					push @orgi_extract, $orgi;
					print F_ORGI $i_header;
					print F_ORGI "\n";
					print F_ORGI @i_seq;
					print F_ORGI "\n\n";
					$orgi=~s/_/ /g;
					print N_ORGI "$orgi\n";
					#print "$orgi\n";
					$k2=$k2+1;
				}
				
				
			}
		}
		else
		{
			print NON_ORGI $i;
			print NON_ORGI "\n\n";
		}
		
		#@split_header = split(/\[/,$i_seq[0]);
		#print "@split_header\n";
		$for_posi=0;
		$flag = 1;
		$diff_os_flag=1;
		#print substr($split_header[1],0, length($split_header[1])-1);
		#print "\n";
		$k=$k+1;
		#print @i_seq;
		
		#print "$i_os\n";
		
	}
}
#print @orgi_extract;
close SEQFILE;
close NON_ORGI;
close REPEAT_ORGI;
close F_ORGI;

exit;
 
