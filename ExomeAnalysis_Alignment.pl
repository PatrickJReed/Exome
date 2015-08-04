#!/usr/bin/perl -w
use strict;
use warnings;



my $bwa			= "/usr/local/tools/bwa-0.5.9/bwa";
my $samtools	= "/usr/local/tools/samtools-0.1.12a/samtools";
my $bedtools	= "/usr/local/tools/BEDTools-Version-2.13.1/bin";
my $picard		= "/usr/local/tools/picard-tools-1.52";
my $seqprep     = "/usr/local/tools/jstjohn-SeqPrep-8719a15/SeqPrep";
my $ref_fa		= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $maxMem		= 8000000000;
my $dir			= "/glusterfs/users/preed/K60/";
my $sample1_1 	= "2013-14_130222_M00834_0004_000000000-A24RP_1_1_sequence.txt.gz";
my $sample1_2 	= "2013-14_130222_M00834_0004_000000000-A24RP_1_2_sequence.txt.gz";
my $ID = "2013-14";


#prep PE reads, merge and clip

   		`$seqprep -6 -f $dir$sample1_1 -r $dir$sample1_2 -1 $ID.1_1.clip.fq.gz -2 $ID.1_2.clip.fq.gz -s $ID.1.mrg.fq.gz >& $ID.1.sp.log`;

  		   		
		# Run bwa alignment on clipped reads
		`$bwa aln -q 15 -t 8 -f $ID.1_1.clip.sai $ref_fa $ID.1_1.clip.fq.gz >& $ID.1_1.aln.log`;
		`$bwa aln -q 15 -t 8 -f $ID.1_2.clip.sai $ref_fa $ID.1_2.clip.fq.gz >& $ID.1_2.aln.log`;
	
	# Pair bwa alignments, convert to BAM, throw out unaligned reads, sort output by coords
		`$bwa sampe -n 10 $ref_fa $ID.1_1.clip.sai $ID.1_2.clip.sai $ID.1_1.clip.fq.gz $ID.1_2.clip.fq.gz | 
		$samtools view -F 4 -bS - > $ID.1.clip.bam`; 
		
		`$samtools sort -m $maxMem $ID.1.clip.bam $ID.1.clip.srt`;
		
		`samtools rmdup $ID.1.clip.srt.bam $ID.clip.srt.rmdup.bam`;	
		
			
	# Run Bwa on merged sequence file

       	# -I removed for clipped seqs
		`$bwa aln -q 15 -t 8 $ref_fa $ID.1.mrg.fq.gz | $bwa samse -n 10 $ref_fa - $ID.1.mrg.fq.gz | $samtools view -F 4 -bS - > $ID.1.mrg.bam`; 
		
		`$samtools sort -m $maxMem $ID.1.mrg.bam $ID.1.mrg.srt`;
		
		`samtools rmdup -s $ID.1.mrg.srt.bam $ID.mrg.srt.rmdup.bam`;		


	# Merge clipped and merged alignments
	
	`java -Xmx8g -jar $picard/MergeSamFiles.jar I=$ID.mrg.srt.rmdup.bam I=$ID.clip.srt.rmdup.bam O=$ID.srt.rmdup.bam SO=coordinate AS=true USE_THREADING=true`;
	
	#Add read group to bam header
	
	`java -Xmx8g -jar $picard/AddOrReplaceReadGroups.jar I=$ID.srt.rmdup.bam O=$ID.srtrg.rmdup.bam RGID=All RGLB=K60 RGPL=Illumina RGPU=HISEQ2000 RGSM=$ID`;
	
	
	