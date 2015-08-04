#!/usr/bin/perl -w
use strict;
use warnings;

my $ID 				= "K87-929_final";
my $samtools		= "/usr/local/tools/samtools-0.1.18/samtools";
my $picard			= "/glusterfs/users/preed/picard-tools-1.102";
my $gatk 			= "/glusterfs/users/preed/GenomeAnalysisTK-2.1-13/GenomeAnalysisTK.jar";
my $ref_fa			= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $dbsnp_vcf   	= "/glusterfs/SEQreference/hg19/dbsnp138/dbsnp_138_hg19_Ordered.vcf";
my $bam_FINAL		= $ID.".recalibrated_final.bam";
my $recal_file  	= $ID.".recal_data.grp";
my $recal1_log   	= $ID.".recal1.log";
my $recal2_log   	= $ID.".recal2.log";

	
########## Base Recalibration ##############
	`$samtools index $ID.srt.real.bam`;
	
	
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T BaseRecalibrator -log $recal1_log -dfrac 0.1 --knownSites $dbsnp_vcf -I $ID.srt.real.bam --out $recal_file`;
	
			
 
 	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T PrintReads -I $ID.srt.real.bam -log $recal2_log --out $bam_FINAL -BQSR $recal_file`;

	
	




