#!/usr/bin/perl -w
# Seq file
open(SEQFILE,'input.fasta');
$cls='yst';
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
$k=0, $k2=0;
#filteration criteria
$find='malic enzyme';
open (F_SEQFILE, '>OS_all_ME.fasta'); #output file
open (D_SEQFILE, '>Del_OS_all_ME.fasta'); #file containing excluded sequences
$er='>'; ## identifier of FASTA sequence
foreach $i (@nwdata)
{
	if($i=~ /$er/)
	{
		@i_seq=split('\n',$i);
		#$i_seq[0]=~s/\s/_/g;
		###### OS Filteration ######
		@split_header = split(/ /,$i_seq[0]);
		$i_new_header=$i_seq[0];
		#print "@split_header\n";
		$for_posi=0;
		$flag = 1;
		$diff_os_flag=1;
		foreach $_ (@split_header)
		{
			$for_posi=$for_posi + 1;
			if($_ =~ /OS/)
			{
				$temp_os=join(' ',substr($_,3), $split_header[($for_posi)]);
				if($for_posi>0)
				{
					foreach $t_ (@os)
					{
						if($temp_os eq $t_)
						{
							$flag=0;
							last;
						}
					}
				}
				if($flag==1 || $for_posi==0)
				{
					$diff_os_flag=0;
					push @os, join(' ',substr($_,3), $split_header[($for_posi)]);
				}
				#print join (' ',$_, $split_header[($for_posi+1)]);
			}
		}
		#print @i_seq;
		$i_os=$temp_os;
		@split_header_first=split('\|',$split_header[0]);
		$i_id=$split_header_first[1];
		#print "$i_os\n";
		if($diff_os_flag==0)
		{
			$i=join ("\n",@i_seq);
			shift @i_seq;
			$i_temp_seq=join ("",@i_seq);
			$i_temp_seq =~ s/\n//g;
			$i_seq_len=length($i_temp_seq);
			####### Finding sequences of our interest  ######
			if(($i=~ m/$find/i))
			{
				$k=$k+1;
				#$i_new_header= ('>sp|'. $i_id .'|'. $i_os .'|malic_enzyme|'.'hazralab_'. $cls . '_' . $k);
				print "$i_new_header\n";
				push @f_data, $i;
				print F_SEQFILE $i_new_header;
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
print "\n Seq- $k\n";
close SEQFILE;
close F_SEQFILE;
exit;
