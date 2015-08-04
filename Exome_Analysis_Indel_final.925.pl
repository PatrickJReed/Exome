#!/usr/bin/perl -w
use strict;
use warnings;

my $ID 				= "K87-925_final";
my $samtools		= "/usr/local/tools/samtools-0.1.18/samtools";
my $picard			= "/glusterfs/users/preed/picard-tools-1.102";
my $gatk 			= "/glusterfs/users/preed/GenomeAnalysisTK-2.1-13/GenomeAnalysisTK.jar";
my $ref_fa			= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $dbsnp_vcf   	= "/glusterfs/SEQreference/hg19/dbsnp138/dbsnp_138_hg19_Ordered.vcf";
my $intervals_out 	= $ID.".intervals";
my $bam_real 		= $ID.".real.bam"; 
my $bam_sort 		= $ID.".srt.real";
my $log1 			= $ID.".intervals.log.txt";
my $log2 			= $ID.".indelrealign.log.txt";

		
	`samtools index $ID.srtrg.bam`;
			

########## Correct for Indels ##############


	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T RealignerTargetCreator -I $ID.srtrg.bam -o $intervals_out -known $dbsnp_vcf -maxInterval 1000 -log $log1`;
		
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T IndelRealigner -LOD 1 -maxPosMove 400 -maxConsensuses 100 -greedy 1000 --maxReadsForRealignment 100000 -targetIntervals $intervals_out -known $dbsnp_vcf -I $ID.srtrg.bam -o $ID.real.bam -log $log2`;
		
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/SortSam.jar I=$ID.real.bam O=$ID.srt.real.bam SO=coordinate`;
		
	`$samtools index $ID.srt.real.bam`;

	






