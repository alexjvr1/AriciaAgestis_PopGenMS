#!/bin/bash
###########################################
# (c) Alexandra Jansen van Rensburg
# last modified 12/07/2019 05:49 
###########################################

## Phase vcf file using all bam files

#PBS -N WhatsHapa  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-100

#run job in working directory
cd $PBS_O_WORKDIR

#load modules

module load languages/python-3.8.5

##Define Variables
WHATSHAP=/newhome/aj18951/.local/bin/whatshap
REF=/newhome/aj18951/1a_Aricia_agestis_GWASdata/RefGenome/ilAriAges1.1.primary.fa
OUTFILE=phased.vcf
VCF=AA251.FINAL.MAF0.01.missing0.5perpop.vcf
BAMPATH=/newhome/aj18951/1a_Aricia_agestis_GWASdata/mapped_ddRAD

##Set up Array
#Where BAMLISTRG is the list of Bam files with RG added
#We can only submit 100 samples per array, so we need to set up 3 scripts for ~250 samples
#ls *RG.bam > BAMLISTRG
NAME=$(sed "${PBS_ARRAYID}q;d" BAMLISTRGaa)

##Run script
echo "Phasing $VCF for ${NAME}"
printf "\n"

echo "$WHATSHAP phase -o ${NAME}.$OUTFILE --reference $REF $VCF $BAMPATH/${NAME}"

time $WHATSHAP phase -o ${NAME}.$OUTFILE --reference $REF $VCF $BAMPATH/${NAME}
