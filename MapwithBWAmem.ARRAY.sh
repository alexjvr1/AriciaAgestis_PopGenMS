#!/bin/bash
#PBS -N AagBWA2  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.  
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-48

#run job in working directory
cd $PBS_O_WORKDIR 
pwd
#cd WPA #uncomment when running locally
#pwd

#Load modules
module load apps/bwa-0.7.15
module load apps/samtools-1.8

#Define variables
RefSeq=GCA_905147365.1_ilAriAges1.1_genomic.fna
total_files=`find demultiplexed.ipyrad_lib1.6/ -name '*.fastq.gz' | wc -l`

#Create the input files listing all forward and reverse reads
ls demultiplexed.ipyrad_lib1.6/*R1*fastq.gz >> R1.names
sed -i s:demultiplexed.ipyrad_lib1.6/::g R1.names
ls demultiplexed.ipyrad_lib1.6/*R2*fastq.gz >> R2.names
sed -i s:demultiplexed.ipyrad_lib1.6/::g R2.names


#Set up array
NAME1=$(sed "${PBS_ARRAYID}q;d" R1.namesaa)
NAME2=$(sed "${PBS_ARRAYID}q;d" R2.namesaa)


#Initiate log file
echo "mapping started" >> map.log
echo "---------------" >> map.log

##Check if Ref Genome is indexed by bwa
if [[ ! RefGenome/$RefSeq.fai ]]
then 
	echo $RefSeq" not indexed. Indexing now"
	bwa index RefGenome/$RefSeq
else
	echo $RefSeq" indexed"
fi


##Map with BWA MEM and output sorted bam file

sample_name=`echo ${NAME1} | awk -F "_R1" '{print $1}'`
echo "[mapping running for] $sample_name"
printf "\n"
echo "time bwa mem RefGenome/$RefSeq demultiplexed.ipyrad_lib1.6/${NAME1} demultiplexed.ipyrad_lib1.6/${NAME2} | samtools sort -o mapped/${NAME1}.bam" >> map.log
time bwa mem RefGenome/$RefSeq demultiplexed.ipyrad_lib1.6/${NAME1} demultiplexed.ipyrad_lib1.6/${NAME2} | samtools sort -o mapped/${NAME1}.bam
