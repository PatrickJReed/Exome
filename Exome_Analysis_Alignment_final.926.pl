#!/usr/bin/perl -w
use strict;
use warnings;



my $bwa			= "/glusterfs/users/preed/bwa-0.6.2/bwa";
my $samtools	= "/usr/local/tools/samtools-0.1.18/samtools";
my $bedtools	= "/usr/local/tools/BEDTools-Version-2.13.1/bin";
my $picard		= "/glusterfs/users/preed/picard-tools-1.102";
my $seqprep     = "/glusterfs/users/preed/SeqPrep-0.1/SeqPrep";
my $ref_fa		= "/glusterfs/users/preed/hg19_Ordered.fa";
my $maxMem		= 8000000000;
my $dir			= "/glusterfs/users/preed/K87/HG19_Analysis/";
my $sample1_1 	= "2011-926_110823_SN484_0112_AC029KACXX_2_1_sequence.txt.gz";
my $sample1_2 	= "2011-926_110823_SN484_0112_AC029KACXX_2_2_sequence.txt.gz";
my $sample2_1	= "2011-926_120210_SN673_0131_AD0MHDACXX_2_1_sequence.txt.gz";
my $sample2_2	= "2011-926_120210_SN673_0131_AD0MHDACXX_2_2_sequence.txt.gz";


my $ID = "K87-926_final";

#prep PE reads, merge and clip

#`$seqprep -6 -f $dir$sample1_1 -r $dir$sample1_2 -1 $ID.1_1.txt.gz -2 $ID.1_2.txt.gz -s $ID.1.txt.gz`;
#`$seqprep -6 -f $dir$sample2_1 -r $dir$sample2_2 -1 $ID.2_1.txt.gz -2 $ID.2_2.txt.gz -s $ID.2.txt.gz`;


		# Run bwa alignment on clipped reads
#		`$bwa aln -t 8 -f $ID.1_1.sai $ref_fa $ID.1_1.txt.gz`;
#		`$bwa aln -t 8 -f $ID.1_2.sai $ref_fa $ID.1_2.txt.gz`;
		
#		`$bwa aln -t 8 -f $ID.2_1.sai $ref_fa $ID.2_1.txt.gz`;
#		`$bwa aln -t 8 -f $ID.2_2.sai $ref_fa $ID.2_2.txt.gz`;
	
	# Pair bwa alignments, convert to BAM, throw out unaligned reads, sort output by coords
#		`$bwa sampe -n 10 -a 1000 $ref_fa $ID.1_1.sai $ID.1_2.sai $ID.1_1.txt.gz $ID.1_2.txt.gz | 
#		 $samtools view -F 4 -bS - > $ID.1.PE.bam`;
		 
#		 `$bwa sampe -n 10 -a 1000 $ref_fa $ID.2_1.sai $ID.2_2.sai $ID.2_1.txt.gz $ID.2_2.txt.gz | 
#		 $samtools view -F 4 -bS - > $ID.2.PE.bam`; 
		  
#		`$bwa aln -t 8 $ref_fa $ID.1.txt.gz | $bwa samse -n 10 $ref_fa - $ID.1.txt.gz | 
#		 $samtools view -F 4 -bS - > $ID.1.SE.bam`;
		 
#		 `$bwa aln -t 8 $ref_fa $ID.2.txt.gz | $bwa samse -n 10 $ref_fa - $ID.2.txt.gz | 
#		 $samtools view -F 4 -bS - > $ID.2.SE.bam`;
		

		`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/SortSam.jar I=$ID.1.PE.bam O=$ID.1.PE.srt.bam SO=coordinate`;
		`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/SortSam.jar I=$ID.2.PE.bam O=$ID.2.PE.srt.bam SO=coordinate`;										
		`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/SortSam.jar I=$ID.1.SE.bam O=$ID.1.SE.srt.bam SO=coordinate`;	
		`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/SortSam.jar I=$ID.2.SE.bam O=$ID.2.SE.srt.bam SO=coordinate`;			
		
			
# Merge clipped and merged alignments
	
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/MergeSamFiles.jar I=$ID.1.PE.srt.bam I=$ID.2.PE.srt.bam I=$ID.1.SE.srt.bam I=$ID.2.SE.srt.bam O=$ID.srt.bam SO=coordinate AS=true USE_THREADING=true`;
	
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/MarkDuplicates.jar I=$ID.srt.bam O=$ID.srt.mkdup.bam M=$ID.MkDups.out AS=true`;
	
	#Add read group to bam header
	
	`java -Xmx8g -Djava.io.tmpdir=./tmp -jar $picard/AddOrReplaceReadGroups.jar I=$ID.srt.mkdup.bam O=$ID.srtrg.bam RGID=$ID RGLB=$ID RGPL=Illumina RGPU=HISEQ2000 RGSM=$ID`;