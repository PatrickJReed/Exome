#!/usr/bin/perl -w
use strict;
use warnings;

 my $InputVCF	= "./K87_final.recal_Both.vcf.hg19_multianno.txt";
 my $tmpdata 	= "./file_wo_Header.txt";
 my ($CHROM, $POS, $ID, $REF, $ALT, $QUAL, $FILTER, $INFO, $FORMAT, $S1, $S2, $S3, $S4, $S5, $S6, $S7, %VarData, @varID, $var, $PL, $GT, $DP, $GQ, $pPL, $pGT, $pDP, $pGQ, $aGT, $aPL, $aDP, $aGQ, $uGT, $uPL, $uDP, $uGQ, $dum, $depth, %Genotypes, $Ale1, $Ale2, $pAle1, $pAle2, $aAle1, $aAle2, @tmp1, %DATA1);


`grep ^chr $InputVCF > $tmpdata`;

open (LIST, $tmpdata) || die "File not found\n";     
     while (<LIST>) {
         chomp;
         @tmp1 = split(/\t/, $_);
         if ($tmp1[1] ne "Start"){
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} = $tmp1[5];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"QUAL"} = $tmp1[29];
         my @info = split(';', $tmp1[31]);
         	if ($info[4] eq "DB") {
         	($dum,$depth) = split('=', $info[5]);
         	}
         	else {
         	($dum,$depth) = split('=', $info[4]);
         	}
         $DATA1{ "$tmp1[0]\t$tmp1[1]\t$tmp1[2]" }{"Depth"} = $depth; #Cumulative depth accross all samples
         }
         if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} ne "exonic") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
     };
close(LIST);

`rm $tmpdata`;
@varID =keys(%DATA1);

open(MYOUTPUTFILE, ">./K87_final.Qual.Cov.txt");
foreach (@varID) { 
	print MYOUTPUTFILE $DATA1{$_}{"Depth"}."\t";
	print MYOUTPUTFILE $DATA1{$_}{"QUAL"}."\n";
  }		
close(MYOUTPUTFILE);


