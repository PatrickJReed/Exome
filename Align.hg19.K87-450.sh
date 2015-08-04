#!/bin/sh
#PBS -N K87-450
#PBS -l nodes=1:ppn=8
#PBS -j oe
#PBS -o K87-450.$PBS_JOBID.out
cd /glusterfs/users/preed/K87/HG19_Analysis/
#perl ./Exome_Analysis_Alignment_final.450.pl $PBS_JOBID
perl ./Exome_Analysis_Indel_final.450.pl $PBS_JOBID 
perl ./Exome_Analysis_Recalibrate_final.450.pl $PBS_JOBID 