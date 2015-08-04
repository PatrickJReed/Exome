#!/usr/bin/perl -w
use strict;
use warnings;

my $ID				= "K87_final";
my $samtools		= "/usr/local/tools/samtools-0.1.12a/samtools";
my $gatk 			= "/glusterfs/users/preed/GenomeAnalysisTK-2.1-13/GenomeAnalysisTK.jar";
my $ref_fa			= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $dbsnp_vcf   	= "/glusterfs/SEQreference/hg19/dbsnp138/dbsnp_138_hg19_Ordered.vcf";
my $OMNI   			= "/glusterfs/SEQreference/hg19/1000G_omni2.5.hg19.sites.Ordered.vcf";
my $hapmap   		= "/glusterfs/SEQreference/hg19/hapmap_3.3.hg19.sites.Ordered.vcf";
my $Dir 			= "/glusterfs/users/preed/K87/HG19_Analysis/";
my $bam_FINAL		= $ID.".recalibrated_final.bam";
my $K87_450			= "K87-450_final.recalibrated_final.bam";  
my $K87_452			= "K87-452_final.recalibrated_final.bam";
my $K87_925			= "K87-925_final.recalibrated_final.bam";  
my $K87_926			= "K87-926_final.recalibrated_final.bam";
my $K87_927			= "K87-927_final.recalibrated_final.bam";   
my $K87_929			= "K87-929_final.recalibrated_final.bam";
my $K87_930			= "K87-930_final.recalibrated_final.bam";
my $BED				="/glusterfs/users/preed/SeqCap_EZ_Exome_hg19.bed";

	
########## Call Variants ##############

	
	
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T DepthOfCoverage -L $BED -o $ID -I $K87_450 -I $K87_452 -I $K87_925 -I $K87_926 -I $K87_927 -I $K87_929 -I $K87_930`;
		
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_450 -summary $K87_450.summary -o $K87_450.bed`;
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_452 -summary $K87_452.summary -o $K87_452.bed`;
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_925 -summary $K87_925.summary -o $K87_925.bed`;
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_926 -summary $K87_926.summary -o $K87_926.bed`;
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_927 -summary $K87_927.summary -o $K87_927.bed`;
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_929 -summary $K87_929.summary -o $K87_929.bed`;
	#`java -Xmx4g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T CallableLoci -L $BED -I $K87_930 -summary $K87_930.summary -o $K87_930.bed`;
	




