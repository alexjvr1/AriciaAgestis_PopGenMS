#!/bin/bash
# Modified from Laurent Excoffier's script at https://github.com/vsousa/EG_cE3c/blob/master/CustomScripts/Fastsimcoal_Runs/runFsc.sh
# The script will launch several runs of fastsimcoal as an array job
# to estimate the demographic parameters from the SFS using a
# conditional maximization (CM) of the parameter likelihood

# It assumes the following structure of the observed sfs files:
#	scriptDir
#   	|
#   	|- - - *.est file
#   	|- - - *.tpl file
#   	|- - - *.sh scripts
#   	|- - - fastsimcoal
#   	|- - - targetDir

# It requires the following arguments
# - poptag: tag of the populations analysed
# - tplEstTag: tag of the model, i.e. tag of the EST and TPL file 
#   NOTE: the resulting folders and file will be named tplEstTag
# - obsSFSfileTag: tag of the name of the file with the observed SFS 
#                  This can be anything, it does not need to be in the name format required by fastsimcoal2)
#                  NOTE: if you have multiple pairwise 2D SFS files, they are required to have 1_0, 2_0, 2_1, etc. indicating the pairwise comparison
# - obsFileEnding: tag for the ending of the SFS file according to fastsimcoal2 requirements:
#                  "DSFS.obs" for multiSFS derived allele
#                  "MSFS.obs" for multiSFS MAF
#                  "jointDAFpop1_0.obs" for 2D derived allele
#                  "jointMAFpop1_0.obs" for 2D MAF
#                  "DAFpop0.obs" for 1D derived allele
#                  "MAFpop0.obs" for 1D MAF

#PBS -N FULL.Model1.BM.ARRAY  ##job name
#PBS -l nodes=1:ppn=1  #nr of nodes and processors per node
#PBS -l mem=16gb #RAM
#PBS -l walltime=10:00:00 ##wall time.  
#PBS -j oe  #concatenates error and output files (with prefix job1)
#PBS -t 1-100 #Number of ArrayJobs


#run job in working directory
cd $PBS_O_WORKDIR 
pwd

# Read arguments from command line
poptag=$1 
tplEstTag=$2
obsSFSfile=$3
obsFileEnding=$4
numRuns=$5

# Name of fastsimcoal executable
FSC=/newhome/aj18951/1a_Aricia_agestis_PopGenomics/FastSimCoal/fsc26
echo "Fastsimcoal version ${fsc}" >> fsc.log

##--- Name of folder where the error and output log files will be saved
msgs=conOutput
echo "Error and log files saved in folder ${msgs}"

##--- Number of runs (this can be use to keep adding runs for each model)
#runBase=1   # initial run number
#numRuns=100

##--- Fastsimcoal related parameters
# -n option
maxNumSims=100000	
#maxNumSims=10
# -L option
maxNumLoopsInBrentOptimization=50
#maxNumLoopsInBrentOptimization=10
# -C option
minValidSFSEntry=1
# -c option (Number of cores)
numCores=1  

#--Derived allele frequency sprectrum or Minor allele frequency spectrum?
# For minor allele frequency spectrum use "-m", 
# For derived allele frequency spectrum use "-d"
#SFStype="-m"
SFStype="-d"

#-- Monomorphic sites?
#useMonoSites=""    #Uncomment this line to use monomorphic sites
useMonoSites="-0" #Uncomment this line NOT to use monomorphic sites
quiet="-q" #-q option
	
#--multiSFS?
#multiSFS="" # Uncomment this line and comment next if you do not use the --multiSFS option
multiSFS="--multiSFS" #--multiSFS


###########################################
# CREATE FOLDERS TO RUN             
# This will re-name the observed SFS
# according to the tplEsttag
###########################################

# create a folder with the name of pops and tag of model
dirname=${poptag}-${tplEstTag} 
# if the folder with name dirname does not exist, create the folder
if [ ! -d "${dirname}" ]; 
then
	# mkdir stands for make directory
	mkdir ${dirname}	
fi

# Copy observed SFS file and rename it according to model
if [ ! -f "${dirname}/${dirname}_${obsFileEnding}" ]; 
then
	if [ -f "${obsSFSfile}" ];
	then
		cp ${obsSFSfile} ${dirname}/${dirname}_${obsFileEnding};
	fi
fi

# create a folder to put all the error and warning messages
mkdir ${msgs}_${dirname} 2>/dev/null


#Define Array names
#seq $baseRuns $numRuns >> numRunsSeq
#sed 's/^/Run/g' numRunsSeq >> numRunsSeq2
NAME=$(sed "${PBS_ARRAYID}q;d" numRunsSeq2)


echo "Launching Fastsimcoal2 analyses for ${obsSFSfile} for model ${tplEstTag}" >> fsc.log
echo "Output saved in folder ${poptag}-${tplEstTag}" >> fsc.log


## Run model
#time $FSC -t BaseModel.tpl -n100000 -N100000 -m -e BaseModel.est -M 0.001 -l 10 -L 40 



	runDir="${NAME}"
	echo "Performing run: ${NAME} of model ${dirname}"
	mkdir $runDir
	
	cd $runDir
	# Copying necessary files
	cp ../${tplEstTag}.tpl . # copy TPL
	cp ../${tplEstTag}.est . # copy EST
	cp ../${dirname}_${obsFileEnding} . # copy OBS
	#Renaming files for consistency
	mv ${tplEstTag}.tpl ${dirname}.tpl
	mv ${tplEstTag}.est ${dirname}.est

	# Run fastsimcoal
	$FSC -t ${dirname}.tpl -e ${dirname}.est -L$maxNumLoopsInBrentOptimization -n$maxNumSims $SFStype -M  $quiet ${useMonoSites} -C${minValidSFSEntry} ${multiSFS} -c${numCores} -B${numCores} > ../${msgs}_${dirname}/run_${runDir}.out 2> ../${msgs}_${dirname}/run_${runDir}.err
	# Pring command line to the screen
	echo "$FSC -t ${dirname}.tpl -e ${dirname}.est -L$maxNumLoopsInBrentOptimization -n$maxNumSims $SFStype -M  $quiet ${useMonoSites} -C${minValidSFSEntry} ${multiSFS} -c${numCores} -B${numCores}" | tee -a ../$msgs_${dirname}/run_${runDir}.out
	
	# Go to parent folder 
	cd .. 

####################################
# COLLECT RESULTS 
####################################

#summaryfile="${dirname}_ALL.param";
#numFiles=1;
		
   #runDir=${NAME}
 #  if [ -d "$runDir" ];	
  # then
#	echo "---------------------------"
#	echo "Getting results from: ${dirname}/${runDir}"
#	echo ""		
#	cd $runDir
#	# if folder exists
#	if [ -d ${dirname} ]; 
#	then
#		cd ${dirname}
#		#Processing best likelihood file
#		bestlhoodFile=${dirname}.bestlhoods
#		echo "NumFiles=${numFiles}"
#		# if file exists				
#		if [ -f $bestlhoodFile ];
#		then
#			echo "File $bestlhoodFile exists."
#			if [ $numFiles -lt 2 ]; 	
#			then
#				header=$(sed '1!d'  $bestlhoodFile)
#				echo -e "File\t$header" > ../../${summaryfile}					
#			fi
#
#			#Extract second line
#			wantedParameters=$(sed '2!d'  $bestlhoodFile)
#			echo -e "${dirname}/${runDir}\t$wantedParameters" >> ../../${summaryfile}
#			# increase the number of files read
#			let numFiles=numFiles+1
#		else
#		   echo "File $bestlhoodFile does not exist for run ${runDir}."
#		fi				
 #               # out of bestlhood folder
#		cd ..				  				
#	fi
#	# out of run folder
#	cd ..
#
 #  fi

