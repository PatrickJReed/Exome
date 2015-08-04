#!/usr/bin/perl -w
use strict;
use warnings;


# Globals:
my $ref_fa 		= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa";
my $ref_index 	= "/glusterfs/SEQreference/hg19/hg19_Ordered.fa.fai";
my $samtools	= "/usr/local/tools/samtools-0.1.18/samtools";
my $bcftools 	= "/usr/local/tools/samtools-0.1.18/bcftools/bcftools";
my $vcfutils 	= "/usr/local/tools/samtools-0.1.18/bcftools/vcfutils.pl";
my $ID			= "K60_Final";
my $bcf 		= $ID.".raw.bcf";
my $vcf			= $ID.".Exome_hg19.vcf";

	
	
	#create input file with kindred data, IDs, and pedigree information, type of disease….
	
	
	 