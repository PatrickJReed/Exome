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

	
########## Call Variants ##############

	
	
#	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T UnifiedGenotyper -log $ID.var_log --dbsnp $dbsnp_vcf -glm BOTH -gt_mode DISCOVERY -out_mode EMIT_VARIANTS_ONLY -maxAltAlleles 10 -I $K87_450 -I $K87_452 -I $K87_925 -I $K87_926 -I $K87_927 -I $K87_929 -I $K87_930 -o $ID.both.vcf`;
	
#		`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T VariantRecalibrator -log $ID.var_log2 -resource:hapmap,known=false,training=true,truth=true,prior=15.0 $hapmap -resource:OMNI,known=false,training=true,truth=false,prior=12.0 $OMNI -resource:dbsnp,known=true,training=false,truth=false,prior=6.0 $dbsnp_vcf --input $ID.both.vcf --mode BOTH --percentBadVariants 0.05 --maxGaussians 4 -recalFile $ID.recal -tranchesFile $ID.tranches -an QD -an HaplotypeScore -an MQRankSum -an ReadPosRankSum -an FS -an MQ`;
	
#	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T ApplyRecalibration -log $ID.var_log3 --input $ID.both.vcf --mode BOTH -recalFile $ID.recal -tranchesFile $ID.tranches -o $ID.recal_Both.vcf`;
	
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $gatk -R $ref_fa -T HaplotypeCaller -A DepthPerAlleleBySample -L chr3 -log $ID.hap_chr3_log --dbsnp $dbsnp_vcf -I $K87_450 -I $K87_452 -I $K87_925 -I $K87_926 -I $K87_927 -I $K87_929 -I $K87_930 -o $ID.chr3.haplotypes.vcf -maxAltAlleles 8`;



