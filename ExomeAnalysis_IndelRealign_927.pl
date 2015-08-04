#!/usr/bin/perl -w
use strict;
use warnings;

my $ID				= "K87-927";
my $samtools		= "/usr/local/tools/samtools-0.1.12a/samtools";
my $gatk 			= "/glusterfs/users/preed/GenomeAnalysisTK-2.1-13/GenomeAnalysisTK.jar";
my $ref_fa			= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $intervals_out 	= $ID.".intervals";
my $bam_real 		= $ID.".real.bam"; 
my $bam_sort 		= $ID.".srt.real";
my $log1 			= $ID.".intervals.log.txt";
my $log2 			= $ID.".indelrealign.log.txt";

		
	`samtools index $ID.srtrg.rmdup.bam`;
			

########## Correct for Indels ##############


	`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T RealignerTargetCreator -I $ID.srtrg.rmdup.bam -o $intervals_out -log $log1`;
		
	`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T IndelRealigner -targetIntervals $intervals_out -o $bam_real -I $ID.srtrg.rmdup.bam -log $log2`;
		
	`$samtools sort -m 8000000000 $bam_real $bam_sort`;
		
	`$samtools index $bam_sort`;
	






