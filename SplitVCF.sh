#!/bin/bash
###########################################
# (c) Alexandra Jansen van Rensburg
# last modified 12/07/2019 05:49 
###########################################

## Split vcf into individuals

#PBS -N SplitVCF_a  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-100

#run job in working directory
cd $PBS_O_WORKDIR

#load modules

module load apps/vcftools-0.1.17.2

##Set up Array
#Where indivnames is the list of sample names from the vcf file
#We can only submit 100 samples per array, so we need to set up 3 scripts for ~250 samples
#bcftools query -l AA.phased.vcf > indivnames

NAME=$(sed "${PBS_ARRAYID}q;d" indivnamesaa)
VCF=name.vcf

##Run script
echo "Extracting ${NAME} from $VCF"
printf "\n"

echo "vcftools --vcf $VCF --indv ${NAME} --recode --recode-INFO-all --out ${NAME}.split"
time vcftools --vcf $VCF --indv ${NAME} --recode --recode-INFO-all --out ${NAME}.split
