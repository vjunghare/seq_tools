#!/usr/bin/perl -w
# Seq file
#@files = glob "*.fasta"
open(SEQFILE,'OS_all_ME.fasta');
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
$k=0, $k2=0;
#filteration criteria
#$find='d-xylose reductase';
$max_limit=800, $min_limit=450;
open (F_SEQFILE, '>LR_OS_all_ME.fasta'); #output file
open (D_SEQFILE, '>Del_LR_OS_all_ME.fasta'); #file containing excluded sequences
$max_len = 0;
$i_seq_len=0;
$min_len = 9999;
$seq_added=1;
$er='>'; ## identifier of FASTA sequence
$no_of_seq=0;
$all_seq_len=0;
foreach $i (@nwdata)
{
	if($i=~ /$er/)
	{
		@i_seq=split('\n',$i);
		#$i_seq[0]=~s/\s/_/g;
		###### OS Filteration ######
		$i_header =$i_seq[0];
		#print "@split_header\n";
		$for_posi=0;
		$flag = 1;
		$diff_os_flag=0;
		
		if($diff_os_flag==0)
		{
			
			$i=join ("\n",@i_seq);
			shift @i_seq;
			$i_temp_seq=join ("",@i_seq);
			$i_temp_seq =~ s/\n//g;
			$i_seq_len=length($i_temp_seq);
			$all_seq_len=$all_seq_len+$i_seq_len;
			
			if(($i_seq_len<$max_limit)&&($i_seq_len>$min_limit))
			{
				$no_of_seq=$no_of_seq+1;
				if($i_seq_len > $max_len)
				{
					$max_len = $i_seq_len;
				}
				if($i_seq_len < $min_len)
				{
					$min_len = $i_seq_len;
				}
				$k=$k+1;
				$k2=$k+$seq_added;
				#$i_new_header= ('>sp|'. $i_id .'|'. $i_os .'|'.'hazralab_'. $cls . '_' . $k2);
				#print "$i_new_header\n";
				push @f_data, $i;
				print F_SEQFILE $i_header;
				print F_SEQFILE "\n";
				print F_SEQFILE $i_temp_seq;
				print F_SEQFILE "\n\n";
				push @f_data, $i;			
			}
			else
			{
				print D_SEQFILE $i;
				print D_SEQFILE "\n";
			}
		}
	}
}
$avg_seq_len=($all_seq_len)/$no_of_seq;
print "\nMaximum sequence length = $max_len\nMinimum sequence length = $min_len\nAverage sequence length = $avg_seq_len\n";
close SEQFILE;
close F_SEQFILE;
exit;
