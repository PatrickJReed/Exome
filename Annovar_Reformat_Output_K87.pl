#!/usr/bin/perl -w
use strict;
use warnings;
my $Input_File1		= "./K87_final.recal_Both.vcf.hg19_multianno.txt";
my $Output_File		= "./K87_final.recal_Both.vcf.hg19_multianno.Annotated.txt";
my (%DATA1, %DATA2, %OMIM_DATA, @tmp1, @tmp2, @tmp_omim, $HEAD, $article, @titles, @links, @Dumb, @IDs);



open (LIST, $Input_File1) || die "File not found\n";     
     while (<LIST>) {
     chomp;
         @tmp1 = split(/\t/, $_);
         if ($tmp1[1] ne "Start"){
		 $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Chr"} = $tmp1[0];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Start"} = $tmp1[1];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"End"} = $tmp1[2];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Ref"} = $tmp1[3];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Alt"} = $tmp1[4];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} = $tmp1[5];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Gene.refGene"} = $tmp1[6];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ExonicFunc.refGene"} = $tmp1[7];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"AAChange.refGene"} = $tmp1[8];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"esp6500si_all"} = $tmp1[9];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000g2012apr_all"} = $tmp1[10];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"snp138NonFlagged"} = $tmp1[11];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"clinvar_20140211"} = $tmp1[12];         
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ljb23_all"} = $tmp1[13];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"caddgt10"} = $tmp1[14];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"OMIM_Regions"} = $tmp1[15];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"tfbs"} = $tmp1[16];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"gerp++gt2"} = $tmp1[17];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"gwasCatalog"} = $tmp1[18];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"wgRna"} = $tmp1[19];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"targetScanS"} = $tmp1[20];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"pubsBlat"} = $tmp1[21];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"DGVMerged"} = $tmp1[22];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"TYPE"} = $tmp1[23];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"CHROM"} = $tmp1[24];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"POS"} = $tmp1[25];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ID"} = $tmp1[26];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"REF"} = $tmp1[27];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ALT"} = $tmp1[28];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"QUAL"} = $tmp1[29];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"FILTER"} = $tmp1[30];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"INFO"} = $tmp1[31];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"FORMAT"} = $tmp1[32];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"450"} = $tmp1[33];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"452"} = $tmp1[34];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"925"} = $tmp1[35];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"926"} = $tmp1[36];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"927"} = $tmp1[37];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"929"} = $tmp1[38];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"930"} = $tmp1[39];
      	} 
     if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} eq "intergenic") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} eq "ncRNA_intronic") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} eq "intronic") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} eq "upstream") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} eq "downstream") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ExonicFunc.refGene"} eq "synonymous SNV") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"snp138NonFlagged"} =~ /^rs/) {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000g2012apr_all"}) 
		{if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000g2012apr_all"} > 0) {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"esp6500si_all"}) 
		{if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"esp6500si_all"} > 0) {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}}
};
close(LIST);

open(MYOUTPUTFILE, ">$Output_File");
@IDs =keys(%DATA1);
print MYOUTPUTFILE "Chr\tStart\tEnd\tRef\tAlt\tFunc.refGene\tGene.refGene\tExonicFunc.refGene\tAAChange.refGene\tesp6500si_all\t1000g2012apr_all\tsnp138NonFlagged\tclinvar_20140211\tljb23_all\tcaddgt10\tOMIM_Regions\ttfbs\tgerp++gt2\tgwasCatalog\twgRna\ttargetScanS\tpubsBlat\tdgvMerged\tTYPE\tCHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tK87-450_final\tK87-452_final\tK87-925_final\tK87-926_final\tK87-927_final\tK87-929_final\tK87-930_final\n"; 
foreach (@IDs) { 
print MYOUTPUTFILE $DATA1{$_}{"Chr"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"Start"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"End"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Ref"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Alt"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Func.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Gene.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"ExonicFunc.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"AAChange.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"esp6500si_all"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"1000g2012apr_all"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"snp138NonFlagged"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"clinvar_20140211"}."\t";          
print MYOUTPUTFILE $DATA1{$_}{"ljb23_all"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"caddgt10"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"OMIM_Regions"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"tfbs"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"gerp++gt2"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"gwasCatalog"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"wgRna"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"targetScanS"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"pubsBlat"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"DGVMerged"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"TYPE"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"CHROM"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"POS"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"ID"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"REF"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"ALT"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"QUAL"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"FILTER"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"INFO"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"FORMAT"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"450"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"452"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"925"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"926"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"927"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"929"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"930"}."\n"; 
  	};		
close(MYOUTPUTFILE);

 
