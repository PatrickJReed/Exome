#!/usr/bin/perl -w
use strict;
use warnings;


# Globals:
my $annovar		= "/glusterfs/users/preed/annovar/";
my kggseq		= "/glusterfs/users/preed/kggseq/";
my $Input		= "./SleepApnea.Exome_hg19.vcf.Filtered";


`$annovar/convert2annovar.pl -format vcf4 --includeinfo --allallele --withzyg $Input > ./$Input.avinput`;

`$annovar/summarize_annovar.pl --buildver hg19 --remove --verdbsnp 137 --ver1000g 1000g2012apr --veresp 6500 $Input.avinput humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 --dbtype refgene --exonsplicing $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype tfbs -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype cg69 -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype cosmic63 -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype esp6500si_all -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype gerp++gt2 -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype gwasCatalog -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype dgv -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype phastCons46way -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype evofold -regionanno $Input.avinput humandb/`;

`annotate_variation.pl --buildver hg19 -dbtype wgRna -regionanno $Input.avinput humandb/`;
	

	
	
	 