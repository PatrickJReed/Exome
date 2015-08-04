#!/bin/sh
#PBS -N K87-Variants-chrY
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o K87.$PBS_JOBID.out
cd /glusterfs/users/preed/K87/HG19_Analysis/
perl ./Exome_Analysis_Variants.chrY.K87.pl $PBS_JOBID
