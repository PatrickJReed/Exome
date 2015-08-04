#!/usr/bin/perl -w
# BWA_Wrapper.pl

use strict;
use warnings;


my $bedtools	= "/glusterfs/users/preed/BEDTools-Version-2.12.0/bin";
my $bed_1 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr1_hg19.bed";
my $bed_2 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr2_hg19.bed";
my $bed_3 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr3_hg19.bed";
my $bed_4 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr4_hg19.bed";
my $bed_5 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr5_hg19.bed";
my $bed_6 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr6_hg19.bed";
my $bed_7 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr7_hg19.bed";
my $bed_8 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr8_hg19.bed";
my $bed_9 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr9_hg19.bed";
my $bed_10 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr10_hg19.bed";
my $bed_11 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr11_hg19.bed";
my $bed_12 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr12_hg19.bed";
my $bed_13 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr13_hg19.bed";
my $bed_14 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr14_hg19.bed";
my $bed_15 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr15_hg19.bed";
my $bed_16 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr16_hg19.bed";
my $bed_17 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr17_hg19.bed";
my $bed_18 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr18_hg19.bed";
my $bed_19 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr19_hg19.bed";
my $bed_20 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr20_hg19.bed";
my $bed_21 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr21_hg19.bed";
my $bed_22 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chr22_hg19.bed";
my $bed_X 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chrX_hg19.bed";
my $bed_Y 		= "/glusterfs/users/preed/K87/HG19_Analysis/Final_Coverage/SeqCap_Exome_chrY_hg19.bed";

my $file2		= "/glusterfs/users/preed/K87/HG19_Analysis/K87-452_final.recalibrated_final.bam";
my $file3		= "/glusterfs/users/preed/K87/HG19_Analysis/K87-925_final.recalibrated_final.bam";
my $file4		= "/glusterfs/users/preed/K87/HG19_Analysis/K87-926_final.recalibrated_final.bam";
my $file5		= "/glusterfs/users/preed/K87/HG19_Analysis/K87-927_final.recalibrated_final.bam";


		
	
		`$bedtools/coverageBed -abam $file2 -b $bed_1 -hist > $file2.chr1.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_2 -hist > $file2.chr2.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_3 -hist > $file2.chr3.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_4 -hist > $file2.chr4.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_5 -hist > $file2.chr5.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_6 -hist > $file2.chr6.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_7 -hist > $file2.chr7.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_8 -hist > $file2.chr8.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_9 -hist > $file2.chr9.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_10 -hist > $file2.chr10.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_11 -hist > $file2.chr11.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_12 -hist > $file2.chr12.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_13 -hist > $file2.chr13.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_14 -hist > $file2.chr14.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_15 -hist > $file2.chr15.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_16 -hist > $file2.chr16.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_17 -hist > $file2.chr17.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_18 -hist > $file2.chr18.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_19 -hist > $file2.chr19.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_20 -hist > $file2.chr20.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_21 -hist > $file2.chr21.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_22 -hist > $file2.chr22.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_X -hist > $file2.chrX.covered`;
		`$bedtools/coverageBed -abam $file2 -b $bed_Y -hist > $file2.chrY.covered`;
		
		
		
		`$bedtools/coverageBed -abam $file3 -b $bed_1 -hist > $file3.chr1.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_2 -hist > $file3.chr2.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_3 -hist > $file3.chr3.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_4 -hist > $file3.chr4.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_5 -hist > $file3.chr5.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_6 -hist > $file3.chr6.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_7 -hist > $file3.chr7.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_8 -hist > $file3.chr8.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_9 -hist > $file3.chr9.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_10 -hist > $file3.chr10.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_11 -hist > $file3.chr11.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_12 -hist > $file3.chr12.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_13 -hist > $file3.chr13.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_14 -hist > $file3.chr14.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_15 -hist > $file3.chr15.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_16 -hist > $file3.chr16.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_17 -hist > $file3.chr17.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_18 -hist > $file3.chr18.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_19 -hist > $file3.chr19.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_20 -hist > $file3.chr20.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_21 -hist > $file3.chr21.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_22 -hist > $file3.chr22.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_X -hist > $file3.chrX.covered`;
		`$bedtools/coverageBed -abam $file3 -b $bed_Y -hist > $file3.chrY.covered`;
		
		
		
		
		`$bedtools/coverageBed -abam $file4 -b $bed_1 -hist > $file4.chr1.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_2 -hist > $file4.chr2.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_3 -hist > $file4.chr3.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_4 -hist > $file4.chr4.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_5 -hist > $file4.chr5.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_6 -hist > $file4.chr6.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_7 -hist > $file4.chr7.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_8 -hist > $file4.chr8.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_9 -hist > $file4.chr9.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_10 -hist > $file4.chr10.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_11 -hist > $file4.chr11.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_12 -hist > $file4.chr12.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_13 -hist > $file4.chr13.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_14 -hist > $file4.chr14.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_15 -hist > $file4.chr15.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_16 -hist > $file4.chr16.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_17 -hist > $file4.chr17.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_18 -hist > $file4.chr18.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_19 -hist > $file4.chr19.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_20 -hist > $file4.chr20.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_21 -hist > $file4.chr21.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_22 -hist > $file4.chr22.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_X -hist > $file4.chrX.covered`;
		`$bedtools/coverageBed -abam $file4 -b $bed_Y -hist > $file4.chrY.covered`;
		
		
		
		`$bedtools/coverageBed -abam $file5 -b $bed_1 -hist > $file5.chr1.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_2 -hist > $file5.chr2.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_3 -hist > $file5.chr3.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_4 -hist > $file5.chr4.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_5 -hist > $file5.chr5.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_6 -hist > $file5.chr6.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_7 -hist > $file5.chr7.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_8 -hist > $file5.chr8.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_9 -hist > $file5.chr9.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_10 -hist > $file5.chr10.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_11 -hist > $file5.chr11.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_12 -hist > $file5.chr12.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_13 -hist > $file5.chr13.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_14 -hist > $file5.chr14.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_15 -hist > $file5.chr15.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_16 -hist > $file5.chr16.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_17 -hist > $file5.chr17.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_18 -hist > $file5.chr18.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_19 -hist > $file5.chr19.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_20 -hist > $file5.chr20.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_21 -hist > $file5.chr21.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_22 -hist > $file5.chr22.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_X -hist > $file5.chrX.covered`;
		`$bedtools/coverageBed -abam $file5 -b $bed_Y -hist > $file5.chrY.covered`;
		
		
		
