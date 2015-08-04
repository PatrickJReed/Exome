#!/usr/bin/perl -w
use strict;
use warnings;


# Globals:
my $annovar		= "/glusterfs/users/preed/annovar/";
my $Input1		= "/glusterfs/users/preed/K87/HG19_Analysis/K87_FINAL.recal_Hap.SNP.vcf";
my $ExAC		= "ExAC.r0.1.sites.vep.vcf";

`$annovar/convert2annovar.pl -format vcf4old --includeinfo --withzyg $Input1 > $Input1.avinput`;

`$annovar/table_annovar.pl $Input1.avinput $annovar/humandb/ --buildver hg19 --remove --otherinfo --outfile $Input1 --protocol refGene,popfreq_all,esp6500si_all,1000g2012apr_all,snp138NonFlagged,clinvar_20140211,ljb26_all,caddgt10,OMIM_Regions,tfbs,gerp++gt2,gwasCatalog,wgRna,targetScanS,genomicSuperDups --operation g,f,f,f,f,f,f,f,r,r,f,r,r,r,r`;

`$annovar/annotate_variation.pl $Input1.avinput $annovar/humandb/ -filter -buildver hg19 -dbtype vcf -vcfdbfile $ExAC`

	 