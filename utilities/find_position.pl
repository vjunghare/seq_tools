#!/usr/bin/perl -w
open(GENOMEFILE,'CP011974_1_BE_genome.fasta');
open(SEQFILE,'BE_phacgene_tr1.fasta');
@data=<GENOMEFILE>;
$line=join("",@data);
@nwdata=split('\n', $line);
#print "$nwdata[1]";
$line_nwdata=@nwdata;
for($i=1;$i<$line_nwdata;$i++)
{
	$final_data[$i-1]=$nwdata[$i];
}
#print "$final_data[0]";
$genome_data = join("",@final_data);
$genome_data=~s/\n//g;
$q=length($genome_data);

@seqdata=<SEQFILE>;
$seqline=join("",@seqdata);
@seqnwdata=split('\n', $seqline);
#print "$nwdata[1]";
$seqline_nwdata=@seqnwdata;
for($j=1;$j<$seqline_nwdata;$j++)
{
	$seqfinal_data[$j-1]=$seqnwdata[$j];
}
#print "$seqfinal_data[0]";
$seq_data = join("",@seqfinal_data);
$seq_data=~s/\n//g;
$p=length($seq_data);
print "\n$p\n$seq_data";
$flag=0;

open (FORW_SEQ, '>forward_seq.fasta');
for ($k=0;$k<($q-$p+1);$k=$k+1)
{
	#print "$\nge- genome_data[0:$k+1]\n";
	$sub_genome_seq = substr($genome_data, $k, $p);
	#print "\n$k $sub_genome_seq";
	if ($sub_genome_seq =~ $seq_data)
	{
		$flag=1;
	}
	if($flag==1)
	{
		print "\n\nHere you find it at ($k)";
		$position=$k;
		last;
	}
	#else
	#{
		#print "\n$k Go to hell";
	#}
}
$position=($position-50);
$for_seq = substr($genome_data, $position, 60);
print FORW_SEQ ">gene_BE\n";
print FORW_SEQ $for_seq;
close SEQFILE;
close FORW_SEQ;
close GENOMEFILE;