#!/bin/bash
#Script to extract haplotypes for listed input vcf files
##################
#AJvR 
#Last modified 13 Jan 2020
##################
#PBS -N ExtractHaplotypes  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.  
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-20

#run job in working directory
cd $PBS_O_WORKDIR 

#load modules
module load apps/bcftools-1.8

#Define variables
NAME=$(sed "${PBS_ARRAYID}q;d" contig.files.neutral20.names)

#Allele 1 
for i in $(bcftools query -l $NAME); do printf '>'${i}'\n'; bcftools query -s ${i} -f '[%TGT]' \
$NAME | awk -F"|" '{print substr($1,1,1)substr($2,2,2)substr($3,2,2)substr($4,2,2)substr($5,2,2)substr($6,2,2)substr($7,2,2)substr($8,2,2)substr($9,2,2)substr($10,2,2)substr($11,2,2)}'; printf '\n'; done > \
$NAME.loc1.allele1

##Add ".1" to all the names
sed -E -i 's:^>.+:&.1:g' $NAME.loc1.allele1


#Allele 2
for i in $(bcftools query -l $NAME); do printf '>'${i}'\n'; bcftools query -s ${i} -f '[%TGT]' \
$NAME | awk -F"|" '{print substr($2,1,1)substr($3,1,1)substr($4,1,1)substr($5,1,1)substr($6,1,1)substr($7,1,1)substr($8,1,1)substr($9,1,1)substr($10,1,1)substr($11,1,1)}'; printf '\n'; done >\
 $NAME.loc1.allele2

##Add ".2" to all the names
sed -E -i 's:^>.+:&.2:g' $NAME.loc1.allele2

##create one file. And remove all white spaces

cat $NAME.loc1.allele1 $NAME.loc1.allele2 > $NAME.loc1.haplotypes
sed -i '/^$/d' $NAME.loc1.haplotypes 
