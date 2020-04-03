#!/bin/bash
#PBS -N BA.sfs.FOR.ARRAY  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=20:00:00 ##wall time.  
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-18 #array job

#Set filters
MININD="18"
MINMAF="0.05"
MINQ="20"
minMAPQ="20"


#run job in working directory
cd $PBS_O_WORKDIR 

#load modules
module load languages/gcc-6.1
angsd=~/bin/angsd/angsd

#Define variables
REGIONFILE=$(sed "${PBS_ARRAYID}q;d" regionsALL.names)


#estimate SFS for modern expanding population using ANGSD

time $angsd -b popFOR.list -checkBamHeaders 1 -minQ $MINQ -minMapQ $minMAPQ -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -rf ${REGIONFILE} -GL 1 -minInd $MININD -out BA.FOR.${REGIONFILE} -doSaf 1 -ref ../RefGenome/A*.fasta -anc ../RefGenome/Aricia*.fasta -rmTriallelic 1 -doCounts 1 -dumpCounts 2 -doMajorMinor 4 -doMaf 1 -doGeno 8 -doPost 1

