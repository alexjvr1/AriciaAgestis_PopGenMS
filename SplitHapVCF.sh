#!/bin/bash
###########################################
# (c) Alexandra Jansen van Rensburg
# last modified 12/07/2019 05:49 
###########################################

## Phase vcf file using all bam files

#PBS -N SplitHAP_VCF  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-26

#run job in working directory
cd $PBS_O_WORKDIR

#load modules

module load apps/vcftools-0.1.17.2

#Define variables
VCF=AA251_phased_outliers.vcf

##Set up Array
#These variables were obtained by splitting the bed file containing all outlier positions
CHR=$(sed "${PBS_ARRAYID}q;d" OUTLIER.CHR)
START=$(sed "${PBS_ARRAYID}q;d" OUTLIER.START)
END=$(sed "${PBS_ARRAYID}q;d" OUTLIER.END)
HAP=$(sed "${PBS_ARRAYID}q;d" OUTLIER.HAP)

##Run script
echo "Extracting  for ${HAP}"
printf "\n"

echo "vcftools --vcf $VCF --chr ${CHR} --from-bp ${START} --to-bp ${END} --recode --recode-INFO-all --out ${HAP}"
time vcftools --vcf $VCF --chr ${CHR} --from-bp ${START} --to-bp ${END} --recode --recode-INFO-all --out ${HAP}

