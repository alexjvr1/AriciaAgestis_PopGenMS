#!/bin/bash
#PBS -N BA.sfs.SNPP.FINAL.FOR.ARRAY  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=20:00:00 ##wall time.  
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-100 #array job

#Set filters
MININD="17"
MINMAF=""
PVAL="1e-3"
MINQ="20"
minMAPQ="20"
minDP="2"
maxDP="30675"
POP="FOR"
POPLIST="popFOR.list"

#run job in working directory
cd $PBS_O_WORKDIR 

#load modules
module load languages/gcc-6.1
angsd=~/bin/angsd/angsd

#Define variables
REGIONFILE=$(sed "${PBS_ARRAYID}q;d" regionsALL.names)


#estimate SFS for modern expanding population using ANGSD

time $angsd -b $POPLIST -checkBamHeaders 1 -minQ $MINQ -minMapQ $minMAPQ -uniqueOnly 1 -remove_bads 1 \
-only_proper_pairs 1 -rf ${REGIONFILE} -GL 1 -minInd $MININD -out test_pval_nomaf/BA.$POP.${REGIONFILE} \
-doSaf 1 -ref ../RefGenome/A*.fasta -anc ../RefGenome/Aricia*.fasta -rmTriallelic 1 \
-doCounts 1 -dumpCounts 2 -doMajorMinor 4 -doMaf 1 -doGeno 8 -doPost 1\
 -setMinDepthInd $minDP -setMaxDepthInd $maxDP -SNP_pval $PVAL
