#!/usr/bin/perl
open(SEQFILE,'OS_all_ME.fasta');
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
#print $nwdata[1];
$max_len = 0;
$i_seq_len=0;
$min_len = 99999;
$seq_added=1;
$er='>'; ## identifier of FASTA sequence
$no_of_seq=0;
foreach $i (@nwdata)
{
	if($i=~ /$er/)
	{
		@i_seq=split('\n',$i);
		#$i_seq[0]=~s/\s/_/g;
		###### OS Filteration ######
		@split_header = split(/ /,$i_seq[0]);
		#print "@split_header\n";
		$for_posi=0;
		$flag = 1;
		$diff_os_flag=0;
		
		if($diff_os_flag==0)
		{
			$no_of_seq=$no_of_seq+1;
			$i=join ("\n",@i_seq);
			shift @i_seq;
			$i_temp_seq=join ("",@i_seq);
			$i_temp_seq =~ s/\n//g;
			$i_seq_len=length($i_temp_seq);
			$all_seq_len=$all_seq_len+$i_seq_len;
			if($i_seq_len > $max_len)
			{
				$max_len = $i_seq_len;
			}
			if($i_seq_len < $min_len)
			{
				$min_len = $i_seq_len;
			}
		}
	}
}
$avg_seq_len=($all_seq_len)/$no_of_seq;
print "\nMaximum sequence length = $max_len\nMinimum sequence length = $min_len\nAverage sequence length = $avg_seq_len\n";
close SEQFILE;
exit;

