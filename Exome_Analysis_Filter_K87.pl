#!/usr/bin/perl -w
use strict;
use warnings;
my $Input_File1		= "./K87_FINAL.recal_Hap.SNP.vcf.hg19_multianno.txt";
my $Input_File2		= "./K87_FINAL.recal_Hap.SNP.vcf.avinput.hg19_vcf_dropped";
my $Output_File		= "./K87_final.recal_Both.vcf.hg19_Filtered_Annotated.txt";
my (@tmp1, @tmp2, @IDs);
my ($CHROM, $POS, $ID, $REF, $ALT, $QUAL, $FILTER, $INFO, $FORMAT, $S1, $S2, $S3, $S4, $S5, $S6, $S7, %DATA1, @varID, $var, $PL, $GT, $DP, $GQ, $pPL, $pGT, $pDP, $pGQ, $aGT, $aPL, $aDP, $aGQ, $uGT, $uPL, $uDP, $uGQ, $dum, $depth, %Genotypes, $Ale1, $Ale2, $pAle1, $pAle2, $aAle1, $aAle2);
 # Define Pedigree structure
 # Unique IDs for each sample
 my @UID = ("450","452","925","926","927","929","930");

 my %sample_info = (
 	
 	$UID[0], { "Sex", "M", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "N" },
 	$UID[1], { "Sex", "F", "Mother", $UID[3], "Father", "NS", "Generation", "3", "Affected", "Y" },
 	$UID[2], { "Sex", "F", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "Y" },
 	$UID[3], { "Sex", "F", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "Y" },
 	$UID[4], { "Sex", "F", "Mother", "NS", "Father", "NS", "Generation", "1", "Affected", "Y" },
 	$UID[5], { "Sex", "F", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "N" },
	$UID[6], { "Sex", "M", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "N" }
		);


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
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"GeneDetail.refGene"} = $tmp1[7];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ExonicFunc.refGene"} = $tmp1[8];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"AAChange.refGene"} = $tmp1[9];
         $DATA1{"$tmp2[2]\t$tmp2[3]\t$tmp2[4]"}{"ExAC"} = 0;
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"PopFreqMax"} = $tmp1[10];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000G2012APR_ALL"} = $tmp1[11];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ESP6500si_ALL"} = $tmp1[16];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"CG46"} = $tmp1[19];         
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"esp6500si_all"} = $tmp1[20];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000g2012apr_all"} = $tmp1[21];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"snp138NonFlagged"} = $tmp1[22];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"clinvar_20140211"} = $tmp1[23];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"SIFT_score"} = $tmp1[24];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Polyphen2_HDIV_score"} = $tmp1[26];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Polyphen2_HVAR_score"} = $tmp1[28];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"LRT_score"} = $tmp1[30];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"MutationTaster_score"} = $tmp1[32];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"MutationAssessor_score"} = $tmp1[34];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"FATHMM_score"} = $tmp1[36];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"RadialSVM_score"} = $tmp1[38];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"LR_score"} = $tmp1[40];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"VEST3_score"} = $tmp1[42];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"CADD_raw"} = $tmp1[43];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"CADD_phred"} = $tmp1[44];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"GERP++_RS"} = $tmp1[45];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"phyloP46way_placental"} = $tmp1[46];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"phyloP100way_vertebrate"} = $tmp1[47];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"SiPhy_29way_logOdds"} = $tmp1[48];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"caddgt10"} = $tmp1[49];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"OMIM_Regions"} = $tmp1[50];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"tfbs"} = $tmp1[51];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"gerp++gt2"} = $tmp1[52];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"gwasCatalog"} = $tmp1[53];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"wgRna"} = $tmp1[54];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"targetScanS"} = $tmp1[55];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"genomicSuperDups"} = $tmp1[56];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"TYPE"} = $tmp1[57];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"CHROM"} = $tmp1[58];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"POS"} = $tmp1[59];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ID"} = $tmp1[60];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"REF"} = $tmp1[61];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ALT"} = $tmp1[62];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"QUAL"} = $tmp1[63];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"FILTER"} = $tmp1[64];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"INFO"} = $tmp1[65];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"FORMAT"} = $tmp1[66];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"450"} = $tmp1[67];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"452"} = $tmp1[68];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"925"} = $tmp1[69];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"926"} = $tmp1[70];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"927"} = $tmp1[71];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"929"} = $tmp1[72];
         $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"930"} = $tmp1[73];

      	} 
     if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"Func.refGene"} ne "intergenic") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"ExonicFunc.refGene"} eq "synonymous SNV") {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000g2012apr_all"}) 
		{if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"1000g2012apr_all"} > .01) {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}}
	elsif ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"esp6500si_all"}) 
		{if ($DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"}{"esp6500si_all"} > .01) {delete $DATA1{"$tmp1[0]\t$tmp1[1]\t$tmp1[2]"};}}
};
close(LIST);

open (LIST, $Input_File2) || die "File not found\n";     
     while (<LIST>) {
     chomp;
         @tmp2 = split(/\t/, $_);
         if ($tmp2[1] ne "Start"){
		 $DATA1{"$tmp2[2]\t$tmp2[3]\t$tmp2[4]"}{"ExAC"} = $tmp2[1];
	}
}


@varID =keys(%DATA1);
print scalar(@varID);
print "\n";

my @Parents =("Mother", "Father");
foreach my $ID (@UID) {
	foreach my $Parent (@Parents) {
		if ($sample_info{$ID}{$Parent} ne "NS") {
			my $pID = $sample_info{$ID}{$Parent};
			if($sample_info{$ID}{"Affected"} eq "Y" and $sample_info{$pID}{"Affected"} eq "Y"){	
			#redefine @varID  
				@varID =keys(%DATA1);	
				foreach $var (@varID) {
					my ($GT, $GQ, $PL) = split(':', $DATA1{$var}{$ID});
					my ($pGT, $pGQ, $pPL) = split(':', $DATA1{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 10 and $pDP >= 10) {
						if (($Ale1 eq $Ale2) or ($pAle1 eq $pAle2)) {
							delete $DATA1{$var};
							}				
						}	
					}
				}	
					
			elsif($sample_info{$ID}{"Affected"} eq "Y" and $sample_info{$pID}{"Affected"} eq "N"){	
			#redefine @varID
				@varID =keys(%DATA1);
				foreach $var (@varID) {
					my ($GT, $GQ, $PL) = split(':', $DATA1{$var}{$ID});
					my ($pGT, $pGQ, $pPL) = split(':', $DATA1{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 10 and $pDP >= 10) {
						if (($GT eq $pGT) or ($Ale1 eq $Ale2)){
							delete $DATA1{$var};
							}
						}	
					}
				}	
		 	
		 	elsif($sample_info{$ID}{"Affected"} eq "N" and $sample_info{$pID}{"Affected"} eq "Y"){	
			#redefine @varID
				@varID =keys(%DATA1);
				foreach $var (@varID) {
					my ($GT, $GQ, $PL) = split(':', $DATA1{$var}{$ID});
					my ($pGT, $pGQ, $pPL) = split(':', $DATA1{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 10 and $pDP >= 10) {
						if (($GT eq $pGT) or ($pAle1 eq $pAle2)){
							delete $DATA1{$var};

						}	
					}		
				}			
			}
		}
	}
}

@varID =keys(%DATA1);
print scalar(@varID);
print "\n";

#Define subset of unaffected Individuals
my @Unaffected;
foreach (@UID) {
	if ($sample_info{$_}{"Affected"} eq "N") {
		push(@Unaffected, $_);	
	}
}
print "@Unaffected\n";
# Define subset of affected Individuals
my @Affected;
foreach (@UID) {
	if ($sample_info{$_}{"Affected"} eq "Y") {
		push(@Affected, $_);	
	}
}
print "@Affected\n";

# Filter variants by presence of homozygosity among affected Individuals 

if (scalar(@Affected) > 0) {
			foreach (@Affected) {
			@varID =keys(%DATA1);
			foreach $var (@varID) {
			my ($GT, $GQ, $PL) = split(':', $DATA1{$var}{$_});
			my ($Ale1, $Ale2) = split('/', $GT);
			if ($DP >= 10) {
				if ($Ale1 eq $Ale2) {
					delete $DATA1{$var};
					}
				}			
			}	
		}	          
	}
@varID =keys(%DATA1);
print scalar(@varID);
print "\n";

if (scalar(@Affected) > 0) {
			@varID =keys(%DATA1);
			foreach $var (@varID) {
			my $count=0;	
			foreach (@Affected) {
			my ($GT, $GQ, $PL) = split(':', $DATA1{$var}{$_});
			if ($DP>=10 and $GT eq "0/1") {
				$count++
					}
				}			
			if ($count < 1) {delete $DATA1{$var}};
			}	
		}	          
@varID =keys(%DATA1);
print scalar(@varID);
print "\n";

#Filter variants by presence of variant
if (scalar(@Unaffected) > 0) {
			foreach (@Unaffected) {
			@varID =keys(%DATA1);
			foreach $var (@varID) {
			my ($GT, $GQ, $PL) = split(':', $DATA1{$var}{$_});
			if ($DP>=10 & (($GT eq "0/1") or ($GT eq "1/1"))){
					delete $DATA1{$var};
					}
				}			
			}	
		}	          
	

# Filter variants by pairwise comparison of each affected to unaffected subjects
foreach my $aftd (@Affected) {
	foreach my $unaftd (@Unaffected) {
		@varID =keys(%DATA1);
		foreach $var (@varID) {
			my ($aGT, $aGQ, $aPL) = split(':', $DATA1{$var}{$aftd});
			my ($uGT, $uGQ, $uPL) = split(':', $DATA1{$var}{$unaftd});
			if ($aDP >= 10 and $uDP >= 10) {
			if (($aGT eq $uGT)) {
			delete $DATA1{$var};
						}
					}			
				}				
			}
		}

@varID =keys(%DATA1);
print scalar(@varID);
print "\n";
@varID =keys(%DATA1);
print scalar(@varID);
print "\n";
open(MYOUTPUTFILE, ">$Output_File");
@IDs =keys(%DATA1);
print MYOUTPUTFILE "Chr\tStart\tEnd\tRef\tAlt\tFunc.refGene\tGene.refGene\tExonicFunc.refGene\tAAChange.refGene\tesp6500si_all\t1000g2012apr_all\tsnp138NonFlagged\tclinvar_20140211\tljb23_all\tcaddgt10\tOMIM_Regions\ttfbs\tgerp++gt2\tgwasCatalog\twgRna\ttargetScanS\tpubsBlat\tGenomeSuperDup\tTYPE\tCHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tK87-450_final\tK87-452_final\tK87-925_final\tK87-926_final\tK87-927_final\tK87-929_final\tK87-930_final\n"; 
foreach (@IDs) { 
 print MYOUTPUTFILE $DATA1{$_}{"Chr"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"Start"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"End"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Ref"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Alt"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Func.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Gene.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"GeneDetail.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"ExonicFunc.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"AAChange.refGene"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"ExAC"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"PopFreqMax"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"1000G2012APR_ALL"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"ESP6500si_ALL"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"CG46"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"esp6500si_all"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"1000g2012apr_all"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"snp138NonFlagged"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"clinvar_20140211"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"SIFT_score"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Polyphen2_HDIV_score"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"Polyphen2_HVAR_score"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"LRT_score"}."\t"; 
print MYOUTPUTFILE $DATA1{$_}{"MutationTaster_score"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"MutationAssessor_score"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"FATHMM_score"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"RadialSVM_score"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"LR_score"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"VEST3_score"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"CADD_raw"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"CADD_phred"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"GERP++_RS"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"phyloP46way_placental"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"phyloP100way_vertebrate"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"SiPhy_29way_logOdds"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"caddgt10"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"OMIM_Regions"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"tfbs"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"gerp++gt2"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"gwasCatalog"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"wgRna"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"targetScanS"}."\t";
print MYOUTPUTFILE $DATA1{$_}{"genomicSuperDups"}."\t";
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

 
