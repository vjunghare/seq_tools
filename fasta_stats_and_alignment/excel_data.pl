#!/usr/bin/perl
#use strict;
#use warnings;
use Spreadsheet::WriteExcel;
use Excel::Writer::XLSX;

my $workbook  = Excel::Writer::XLSX->new('aln_70_above.xlsx');
my $worksheet = $workbook->add_worksheet();
open (ALN_FASTA, 'aln_70_above.fasta');
@data=<ALN_FASTA>;
# putting sequence in each block of array
$line=join("",@data);
$line =~ s/>/#>/g;
#chmod $line;
@nwdata=split('#', $line);
$data_len=scalar(@nwdata);
$row=0;
$col=0;
$er = '>';
#$format = $workbook->add_format();
#$format->set_align('center');
#$format->set_align('vcenter');
#$format->set_text_wrap();

foreach $i (@nwdata)
{
	if($i=~ /$er/)
		{
			@i_seq=split('\n',$i);
			$i_seq[0]=~s/\s/_/g;
			$space= '_';
			$endposi = length($i_seq[0]);
			#print "\nin- $result\n";
			$i_substr= substr $i_seq[0],0,($endposi);
			#print $i_substr;
			$i=join ("\n",@i_seq);
			$worksheet->set_column($row,0,20);
			$worksheet->write_string($row, 0, $i_substr);
			#print $i;
			shift @i_seq;
			$i_temp_seq=join ("",@i_seq);
			$i_temp_seq =~ s/\n//g;
			$i_seqlen=length($i_temp_seq);
			#print $i_seqlen;
			@i_alnseq= split (//,$i_temp_seq);
			for($j = 1; $j <$i_seqlen+1; $j++)
			{
				$worksheet->set_column($row,$j,2);
				$worksheet->write_string($row, $j, $i_alnseq[$j-1]);				
			}
			$row++;
		}
}
print "\n Alignment_export_to_excel";
#$workbook->add_formatset_text_wrap()
close ALN_FASTA;
