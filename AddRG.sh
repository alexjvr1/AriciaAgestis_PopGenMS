#!/bin/bash
###########################################
# (c) Alexandra Jansen van Rensburg
# last modified 12/07/2019 05:49 
###########################################

## Add RG and index all bam files listed in BAMLIST

#PBS -N AddRG_a  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-100

#run job in working directory
cd $PBS_O_WORKDIR


#load modules

module load apps/picard-2.20.0  
module load apps/samtools-1.9.1

PICARD=/cm/shared/apps/Picard-2.20.0/picard.jar


##Set up array
#Where BAMLIST is a list of all bamfiles in the directory
#And RG is a list of all the RG names (i.e. sample names)
#ls *bam > BAMLIST
#awk -F '.' '{print $1}' BAMLIST > RG

NAME=$(sed "${PBS_ARRAYID}q;d" BAMLISTa)
RG=$(sed "${PBS_ARRAYID}q;d" RGa)

##Run script
echo "Add RG to ${NAME}"
printf "\n"

echo "java -jar /cm/shared/apps/Picard-2.20.0/picard.jar AddOrReplaceReadGroups \
I=BAR_10_2013.bam \
O=BAR_10_2013.RG.bam \
RGID=1 \
RGLB=lib1 \
RGPL=Illumina \
RGPU=unit1 \
RGSM=BAR_10_2013" >> ${NAME}.addRG.log

time java -jar $PICARD AddOrReplaceReadGroups \
I=${NAME} \
O=${RG}.RG.bam \
RGID=1 \
RGLB=lib1 \
RGPL=Illumina \
RGPU=unit1 \
RGSM=${RG}


echo "samtools index ${RG}.RG.bam" >> ${NAME}.addRG.log
time samtools index ${RG}.RG.bam
