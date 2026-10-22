#!/usr/bin/perl -w
# Seq file
open(SEQFILE,'uniprot_xr_yeast.fasta');
$cls='yst';
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
$k=0, $k2=0;
#filteration criteria
$find='d-xylose reductase';
$max_limit=450, $min_limit=250;
open (F_SEQFILE, '>ttxr_yeast.fasta'); #output file
open (D_SEQFILE, '>ttdeleted_xr.fasta'); #file containing excluded sequences
$max_len = 0;
$i_seq_len=0;
$min_len = 9999;
print F_SEQFILE ">sp|KmIIPE453XRKS|KmXR|hazralab_yst_1\nMTYLAPTVTLNNGSKMPLVGLGCWKIPNEVCAEQVYEAIKLGYRLFDGAQDYANEKEVGQGINRAIKEGIVKREDLVVVSKLWNSFHHPDNVRTAVERTLNDLQLDYLDLFYIHFPLAFKFVPLDEKYPPGFYTGKDNFAKEIIEEEPVPILDTYRALEKLVDEGLIKSLGISNFSGALIQDLLRGARIKPVALQIEHHPYLVQDRLITYAQKVGLQVVAYSSFGPLSFVELNNEKALHTKTLFENDTIKAIAQKHNVTPSHVLLKWSTQRGIAVIPKSSKKERLLENLKIEETFTLSDEEIKEINGLDQGLRFNDPWDWLGNEFPTFI\n\n";
$seq_added=1;
$er='>'; ## identifier of FASTA sequence
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
			if($i_seq_len > $max_len)
			{
				$max_len = $i_seq_len;
			}
			if($i_seq_len < $min_len)
			{
				$min_len = $i_seq_len;
			}
			#print $i;
			####### Finding sequences of our interest  ######
			if(($i=~ m/$find/i)&&($i_seq_len<$max_limit)&&($i_seq_len>$min_limit))
			{
				$k=$k+1;
				$k2=$k+$seq_added;
				$i_new_header= ('>sp|'. $i_id .'|'. $i_os .'|'.'hazralab_'. $cls . '_' . $k2);
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
print "\nXR Seq- $k,\nmaximum sequence length = $max_len\n minimum sequence length = $min_len\n";
close SEQFILE;
close F_SEQFILE;
exit;
