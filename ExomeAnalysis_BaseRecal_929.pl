#!/usr/bin/perl -w
use strict;
use warnings;

my $ID				= "K87-929";
my $samtools		= "/usr/local/tools/samtools-0.1.12a/samtools";
my $gatk 			= "/glusterfs/users/preed/GenomeAnalysisTK-2.1-13/GenomeAnalysisTK.jar";
my $ref_fa			= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $dbsnp_vcf   	= "/glusterfs/SEQreference/hg19/dbsnp135_hg19_Ordered.vcf";
my $intervals_out 	= $ID.".intervals";
my $bam_FINAL		= $ID.".recalibrated_final.bam";
my $recal_file  	= $ID.".recal_data.grp";
my $recal1_log   	= $ID.".recal1.log";
my $recal2_log   	= $ID.".recal2.log";

	
########## Base Recalibration ##############
	
	`$samtools index $ID.srt.real.bam`;
	
	
	
	`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T BaseRecalibrator -log $recal1_log -dfrac 0.1 --knownSites $dbsnp_vcf -I $ID.srt.real.bam --out $recal_file`;
	
		
 
 	`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T PrintReads -I $ID.srt.real.bam -log $recal2_log --out $bam_FINAL -BQSR $recal_file`;





