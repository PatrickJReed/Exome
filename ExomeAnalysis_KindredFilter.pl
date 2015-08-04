#!/usr/bin/perl -w
use strict;
use warnings;

 my $InputVCF	= "./SleepApnea.Exome_hg19.vcf";
 my $Header 	= "./header.txt";
 my $tmpdata 	= "./file_wo_Header.txt";
 my ($CHROM, $POS, $ID, $REF, $ALT, $QUAL, $FILTER, $INFO, $FORMAT, $S1, $S2, $S3, $S4, $S5, $S6, $S7, %VarData, @varID, $var, $PL, $GT, $DP, $GQ, $pPL, $pGT, $pDP, $pGQ, $aGT, $aPL, $aDP, $aGQ, $uGT, $uPL, $uDP, $uGQ, $dum, $depth, %Genotypes, $Ale1, $Ale2, $pAle1, $pAle2, $aAle1, $aAle2);
 # Define Pedigree structure
 # Unique IDs for each sample
 my @UID = (204,205,2037,2047);

 my %sample_info = (
 	
 	$UID[0], { "Sex", "F", "Mother", "NS", "Father", "NS", "Generation", "1", "Affected", "N" }, 	
 	$UID[1], { "Sex", "M", "Mother", "NS", "Father", "NS", "Generation", "1", "Affected", "N" },    
 	$UID[2], { "Sex", "F", "Mother", $UID[1], "Father", $UID[0], "Generation", "2", "Affected", "N" }, 	
 	$UID[3], { "Sex", "M", "Mother", $UID[1], "Father", $UID[0], "Generation", "2", "Affected", "Y" }, 	

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
         ($CHROM, $POS, $ID, $REF, $ALT, $QUAL, $FILTER, $INFO, $FORMAT, $S1, $S2, $S3, $S4) = split(/\t/, $_);
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
         $VarData{ "$CHROM\t$POS" }{"Depth"} = $depth; #Cumulative depth accross all samples
         $VarData{ "$CHROM\t$POS" }{"Quality"} = $QUAL;
         $VarData{ "$CHROM\t$POS" }{"EntireLine"} = "$CHROM\t$POS\t$ID\t$REF\t$ALT\t$QUAL\t$FILTER\t$INFO\t$FORMAT\t$S1\t$S2\t$S3\t$S4";
     };
close(LIST);

`rm $tmpdata`;
@varID =keys(%VarData);
print scalar(@varID);
print "\n";


# Filter variants by comparison to parents, top down (gen1 then gen2.......)
#sort UID array by value of Key Generation in Hash sample_info


my @Parents =("Mother", "Father");
foreach my $ID (@UID) {
	foreach my $Parent (@Parents) {
		if ($sample_info{$ID}{$Parent} ne "NS") {
			my $pID = $sample_info{$ID}{$Parent};
			if($sample_info{$ID}{"Affected"} eq "Y" and $sample_info{$pID}{"Affected"} eq "N"){	
			#redefine @varID
				@varID =keys(%VarData);
				foreach $var (@varID) {
					my ($GT, $PL, $DP, $GQ) = split(':', $VarData{$var}{$ID});
					my ($pGT, $pPL, $pDP, $pGQ) = split(':', $VarData{$var}{$pID});
					my ($Ale1, $Ale2) = split('/', $GT);
					my ($pAle1, $pAle2) = split('/', $pGT);
					if ($DP >= 6 and $pDP >= 6) {
						if (($GT eq $pGT) or ($Ale1 eq $Ale2)){
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
			if ((($VarData{$var}{"Depth"}>=8) and ($GT eq "0/1")) or (($DP>=8) and ($GT eq "1/1"))){
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
