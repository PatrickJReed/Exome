#!/usr/bin/perl -w
use strict;
use warnings;

 my $InputVCF	= "./K87_NEW_7.Exome_hg19.vcf";
 my $Header 	= "./header.txt";
 my $tmpdata 	= "./file_wo_Header.txt";
 my ($CHROM, $POS, $ID, $REF, $ALT, $QUAL, $FILTER, $INFO, $FORMAT, $S1, $S2, $S3, $S4, $S5, $S6, $S7, %VarData, @varID, $var, $PL, $GT, $DP, $GQ, $pPL, $pGT, $pDP, $pGQ, $aGT, $aPL, $aDP, $aGQ, $uGT, $uPL, $uDP, $uGQ, $dum, $depth, %Genotypes, $Ale1, $Ale2, $pAle1, $pAle2, $aAle1, $aAle2);
 # Define Pedigree structure
 # Unique IDs for each sample
 my @UID = my @UID = (450,452,925,926,927,929,930);

 my %sample_info = (
 	
 	$UID[0], { "Sex", "M", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "N" },
 	$UID[1], { "Sex", "F", "Mother", $UID[3], "Father", "NS", "Generation", "3", "Affected", "Y" },
 	$UID[2], { "Sex", "F", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "Y" },
 	$UID[3], { "Sex", "F", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "Y" },
 	$UID[4], { "Sex", "F", "Mother", "NS", "Father", "NS", "Generation", "1", "Affected", "Y" },
 	$UID[5], { "Sex", "F", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "N" },
	$UID[6], { "Sex", "M", "Mother", $UID[4], "Father", "NS", "Generation", "2", "Affected", "N" }
		);
#order samples by generation  
 
print @UID; 
#get data lines from vcf file, don't know how to do this in perl
`grep ^#CHROM $InputVCF > $Header`;
open(HEAD, $Header);
while (<HEAD>) { print $_;}
close(HEAD);

`grep ^chr $InputVCF > $tmpdata`;
#create hash of all information for each sample where top key is unique position of chr and position
open (LIST, $tmpdata) || die "File not found\n";     
     while (<LIST>) {
         ($CHROM, $POS, $ID, $REF, $ALT, $QUAL, $FILTER, $INFO, $FORMAT, $S1, $S2, $S3, $S4, $S5, $S6, $S7) = split(/\t/, $_);
         my @info = split(';', $INFO);
         if ($info[0] eq "INDEL") {
         	($dum,$depth) = split('=', $info[1]);
         }
         else {
         	($dum,$depth) = split('=', $info[0]);
         }
         
         $VarData{ "$CHROM\t$POS" }{ $UID[0] } = $S1;
         $VarData{ "$CHROM\t$POS" }{ $UID[1] } = $S2;
         $VarData{ "$CHROM\t$POS" }{ $UID[2] } = $S3;
         $VarData{ "$CHROM\t$POS" }{ $UID[3] } = $S4;
         $VarData{ "$CHROM\t$POS" }{ $UID[4] } = $S5;
         $VarData{ "$CHROM\t$POS" }{ $UID[5] } = $S6;
         $VarData{ "$CHROM\t$POS" }{ $UID[6] } = $S7;
         $VarData{ "$CHROM\t$POS" }{"Depth"} = $depth; #Cumulative depth accross all samples
         $VarData{ "$CHROM\t$POS" }{"Quality"} = $QUAL;
         $VarData{ "$CHROM\t$POS" }{"EntireLine"} = "$CHROM\t$POS\t$ID\t$REF\t$ALT\t$QUAL\t$FILTER\t$INFO\t$FORMAT\t$S1\t$S2\t$S3\t$S4\t$S5\t$S6\t$S7";
     };
close(LIST);

`rm $tmpdata`;
@varID =keys(%VarData);
print scalar(@varID);
print "\n";


@varID =keys(%VarData);
foreach $var (@varID) {
	if ($VarData{$var}{"Depth"}<8){
		delete $VarData{$var};
	}
	else {
	my ($GT1, $PL1, $DP1, $GQ1) = split(':', $VarData{$var}{$UID[0]});
	my ($GT2, $PL2, $DP2, $GQ2) = split(':', $VarData{$var}{$UID[1]});
	my ($GT3, $PL3, $DP3, $GQ3) = split(':', $VarData{$var}{$UID[2]});
	my ($GT4, $PL4, $DP4, $GQ4) = split(':', $VarData{$var}{$UID[3]});
	my ($GT5, $PL5, $DP5, $GQ5) = split(':', $VarData{$var}{$UID[4]});
	my ($GT6, $PL6, $DP6, $GQ6) = split(':', $VarData{$var}{$UID[5]});
	my ($GT7, $PL7, $DP7, $GQ7) = split(':', $VarData{$var}{$UID[6]});
		if ($DP1 < 8 and $DP2 < 8 and $DP3 < 8 and $DP4 < 8 and $DP5 < 8 and $DP6 < 8 and $DP7 < 8) {
		delete $VarData{$var};
		}
	}
}		



# Filter variants by comparison to parents, top down (gen1 then gen2.......)
#sort UID array by value of Key Generation in Hash sample_info



my @Parents =("Mother", "Father");
foreach my $ID (@UID) {
	foreach my $Parent (@Parents) {
		if ($sample_info{$ID}{$Parent} ne "NS") {
			my $pID = $sample_info{$ID}{$Parent};
			if($sample_info{$ID}{"Affected"} eq "Y" and $sample_info{$pID}{"Affected"} eq "Y"){	
			#redefine @varID  
				@varID =keys(%VarData);	
				foreach $var (@varID) {
					my ($GT, $PL, $DP, $GQ) = split(':', $VarData{$var}{$ID});
					my ($pGT, $pPL, $pDP, $pGQ) = split(':', $VarData{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 8 and $pDP >= 8) {
						if (($Ale1 eq $Ale2) or ($pAle1 eq $pAle2)) {
							delete $VarData{$var};
							}				
						}	
					}
				}	
					
			elsif($sample_info{$ID}{"Affected"} eq "Y" and $sample_info{$pID}{"Affected"} eq "N"){	
			#redefine @varID
				@varID =keys(%VarData);
				foreach $var (@varID) {
					my ($GT, $PL, $DP, $GQ) = split(':', $VarData{$var}{$ID});
					my ($pGT, $pPL, $pDP, $pGQ) = split(':', $VarData{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 8 and $pDP >= 8) {
						if (($GT eq $pGT) or ($Ale1 eq $Ale2)){
							delete $VarData{$var};
							}
						}	
					}
				}	
		 	
		 	elsif($sample_info{$ID}{"Affected"} eq "N" and $sample_info{$pID}{"Affected"} eq "Y"){	
			#redefine @varID
				@varID =keys(%VarData);
				foreach $var (@varID) {
					my ($GT, $PL, $DP, $GQ) = split(':', $VarData{$var}{$ID});
					my ($pGT, $pPL, $pDP, $pGQ) = split(':', $VarData{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 8 and $pDP >= 8) {
						if (($GT eq $pGT) or ($pAle1 eq $pAle2)){
							delete $VarData{$var};

						}	
					}		
				}			
			}
		}
	}
}

@varID =keys(%VarData);
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
			@varID =keys(%VarData);
			foreach $var (@varID) {
			my ($GT, $PL, $DP, $GQ) = split(':', $VarData{$var}{$_});
			my ($Ale1, $Ale2) = split('/', $GT);
			if ($DP >= 8) {
				if ($Ale1 eq $Ale2) {
					delete $VarData{$var};
					}
				}			
			}	
		}	          
	}
@varID =keys(%VarData);
print scalar(@varID);
print "\n";

#Filter variants by presence of variant
if (scalar(@Unaffected) > 0) {
			foreach (@Unaffected) {
			@varID =keys(%VarData);
			foreach $var (@varID) {
			my ($GT, $PL, $DP, $GQ) = split(':', $VarData{$var}{$_});
			if ((($DP>=1) and ($GT eq "0/1")) or (($DP>=1) and ($GT eq "1/1"))){
					delete $VarData{$var};
					}
				}			
			}	
		}	          
	
@varID =keys(%VarData);
print scalar(@varID);
print "\n";



# Filter variants by pairwise comparison of each affected to unaffected subjects
foreach my $aftd (@Affected) {
	foreach my $unaftd (@Unaffected) {
		@varID =keys(%VarData);
		foreach $var (@varID) {
			my ($aGT, $aPL, $aDP, $aGQ) = split(':', $VarData{$var}{$aftd});
			my ($uGT, $uPL, $uDP, $uGQ) = split(':', $VarData{$var}{$unaftd});
			if ($aDP >= 8 and $uDP >= 8) {
			if (($aGT eq $uGT)) {
			delete $VarData{$var};
						}
					}			
				}				
			}
		}
		
		
my @FinalVariantPositions =keys(%VarData);
print scalar(@FinalVariantPositions);
print "\n";


open(MYOUTPUTFILE, ">$InputVCF.tmp.vcf");
foreach (@FinalVariantPositions) { 
	print MYOUTPUTFILE $VarData{$_}{"EntireLine"};
	#print MYOUTPUTFILE "\n";
  }		
close(MYOUTPUTFILE);

`cat $Header $InputVCF.tmp.vcf > $InputVCF.Filtered`;
`rm $InputVCF.tmp.vcf`; 
