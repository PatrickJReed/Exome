#!/usr/bin/perl -w
use strict;
use warnings;



my $bwa			= "/glusterfs/users/preed/bwa-0.6.2/bwa";
my $samtools	= "/usr/local/tools/samtools-0.1.18/samtools";
my $bedtools	= "/usr/local/tools/BEDTools-Version-2.13.1/bin";
my $picard		= "/glusterfs/users/preed/picard-tools-1.102";
my $ref_fa		= "/glusterfs/users/preed/hg19_Ordered.fa";
my $maxMem		= 8000000000;
my $dir			= "/glusterfs/users/preed/K87/HG19_Analysis/";
my $sample		= "SLC22A9.fq";


my $ID = "SLC22A9_5UTR";

		  
	`$bwa aln -t 3 $ref_fa $sample | $bwa samse -n 10 $ref_fa - $sample | $samtools view -F 4 -bS - > $ID.bam`;		

	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/SortSam.jar I=$ID.bam O=$ID.srt.bam SO=coordinate`;													
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/MarkDuplicates.jar I=$ID.srt.bam O=$ID.srt.mkdup.bam M=$ID.MkDups.out AS=true`;
		
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/AddOrReplaceReadGroups.jar I=$ID.srt.mkdup.bam O=$ID.srtrg.bam RGID=$ID RGLB=$ID RGPL=Illumina RGPU=HISEQ2000 RGSM=$ID`;