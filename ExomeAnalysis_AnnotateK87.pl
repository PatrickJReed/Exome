#!/usr/bin/perl -w
use strict;
use warnings;


# Globals:
my $annovar		= "/glusterfs/users/preed/annovar/";
my $Input		= "./K87_NEW_7.Exome_hg19.vcf.Filtered";


`$annovar/convert2annovar.pl -format vcf4 --includeinfo --allallele --withzyg $Input > ./$Input.avinput`;

`$annovar/summarize_annovar.pl --buildver hg19 --remove --verdbsnp 137 --ver1000g 1000g2012apr --veresp 6500si $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype tfbs -regionanno $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype cg69 -filter $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype gerp++gt2 -regionanno $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype gwasCatalog -regionanno $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype dgv -regionanno $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype phastCons46way -regionanno $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype evofold -regionanno $Input.avinput $annovar/humandb/`;

`$annovar/annotate_variation.pl --buildver hg19 -dbtype wgRna -regionanno $Input.avinput $annovar/humandb/`;
	

	
	
	 