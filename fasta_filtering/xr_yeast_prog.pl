#!/usr/bin/perl -w
# Seq file
open(SEQFILE,'uniprot_phac.fasta');
open(SEQFILE2, 'uniprot-pha+synthase.fasta');
open (SEQFILE3, 'uniprot-Poly+3-hydroxyalkanoate+polymerase.fasta');
@data=<SEQFILE>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
@nwdata=split('#', $line);
$k=0, $k2=0, $k3=0;
#@f_data;
#filteration criteria
@find=('Bacillus', 'bacillus');

#$find2='Xylose';
#$find3='Fragment';
open (F_SEQFILE, '>bacillus_phac_r2.fasta');
open (D_SEQFILE, '>deleted_bacillus_phac_r2.fasta');
$max_len = 0;
$i_seq_len=0;
$min_len = 9999;
$er='>';
#print F_SEQFILE ">RMIIPL32XRKS_\nMSQQIPSVKLSNGAEFPLLGFGTWQSAPGEVGKAVEVALKAGYRHLDLAKVYGNQKEIAPAIANSGVDRKDIFITSKLWNSQHKPELVEAALDDTLKELGLEYLDLYLIHWPVAFPAEGDPHSNLFPKENGECKIDTSVSIVDTWKAMIKLLDTGKTKAVGVSNFSPAMVDAITEATGVKPVVNQIERHPRLLQKDLLKHHKEKNIVVTAYSGFGNNSVGEPLLLEHPTVKKIAEAKGANPGQVLIAWGMHGGHAIIPKSVTPSRIESNFKVISLTDDEVAEINKIGEEKPARFNLPILYSPLWPGSLLSITF\n\n>KSIIPE453XRKS_\nMTYLAPTVTLNNGSKMPLVGLGCWKIPNEVCAEQVYEAIKLGYRLFDGAQDYANEKEVGQGINRAIKEGIVKREDLVVVSKLWNSFHHPDNVRTAVERTLNDLQLDYLDLFYIHFPLAFKFVPLDEKYPPGFYTGKDNFAKEIIEEEPVPILDTYRALEKLVDEGLIKSLGISNFSGALIQDLLRGARIKPVALQIEHHPYLVQDRLITYAQKVGLQVVAYSSFGPLSFVELNNEKALHTKTLFENDTIKAIAQKHNVTPSHVLLKWSTQRGIAVIPKSSKKERLLENLKIEETFTLSDEEIKEINGLDQGLRFNDPWDWLGNEFPTFI\n\n";
#$lig= ("NADH");
foreach $i (@nwdata)
{
	if(($i=~ /$er/) )#&& (!($i=~ /$lig/)))
	{
		@i_seq=split('\n',$i);
		$i_seq[0]=~s/\s/_/g;
		$i=join ("\n",@i_seq);
		#print $i;
		shift @i_seq;
		$i_temp_seq=join ("",@i_seq);
		$i_temp_seq =~ s/\n//g;
		$i_seq_len=length($i_temp_seq);
		if($i_seq_len > $max_len)
		{
			#print "$i_seq_len $i\n";
			$max_len = $i_seq_len;
		}
		if($i_seq_len < $min_len)
		{
			$min_len = $i_seq_len;
		}
	
		$t_flag=0;
		for($x=0;$x<2;$x++)
		{	
			if(($i=~ /$find[$x]/)&&($i_seq_len<400)&&($i_seq_len>300))
			{
				$t_flag = 1;
			}
		}
		if ($t_flag == 1)
		{
			$k=$k+1;
			push @f_data, $i;
			#if($i=~ /$lig/)
				#{
				#	$k2=$k2+1;
				#}
				#else
				#{
				$k3=$k3+1;
				print F_SEQFILE $i;
				print F_SEQFILE "\n\n";
				push @f_data, $i;
				#}
		}
		else
		{
			print D_SEQFILE $i;
			print D_SEQFILE "\n";
		}
	}
}
print "$i_seq_len";
#print @f_data;

print "\nSeq- $k,\nFragment- $k2,\n Final Seq- $k3\nmaximum sequence length = $max_len\n minimum sequence length = $min_len\n";

close SEQFILE;
close F_SEQFILE;
#data_process();
system ("muscle -in bacillus_phac_r2.fasta -fastaout bacillus_phac_r2_aln.fasta -clwout bacillus_phac_r2_clw.aln -maxiters 2");
print "\n........Alignment is done !.......\n";

#open(CLWALNFILE,'xrdata_wo_frag4.aln');
#@aln_data=<CLWALNFILE>;

exit;
