#!/bin/bash

#work in current directory
#cd $PBS_O_WORKDIR 
pwd

#Define variables
poptag="BA"
tplEstTag="BaseModel"
numRuns=100

dirname=${poptag}-${tplEstTag}
runBase=1



####################################
# COLLECT RESULTS 
####################################

summaryfile="${dirname}_ALL.param";
echo "summaryfile="${dirname}_ALL.param"" >> CollectResults.log
#echo "name of summary file is "${summaryfile} > ${summaryfile}
numFiles=1;
#for (( runsDone=1; runsDone<=$numRuns; runsDone++ ))
for (( 1; runsDone<=100; runsDone++ ))
do		
   runDir="Run$runsDone"
   if [ -d "$runDir" ];	
   then
	echo "---------------------------" >> CollectResults.log
	echo "Getting results from: ${runDir}/${dirname}" >> CollectResults.log
	echo ""		>> CollectResults.log
	#cd $runDir
	# if folder exists
	if [ -d ${runDir} ]; 
	then
		#cd ${runDir}
		#Processing best likelihood file
		bestlhoodFile=${runDir}/${dirname}.bestlhoods
		echo "NumFiles=${numFiles}" >> CollectResults.log
		# if file exists				
		if [ -f $bestlhoodFile ];
		then
			echo "File $bestlhoodFile exists." >> CollectResults.log
			if [ $numFiles -lt 2 ]; 	
			then
				header=$(sed '1!d'  $bestlhoodFile)
				echo -e "File\t$header" >> CollectResults.log > ${summaryfile}				
			fi

			#Extract second line
			wantedParameters=$(sed '2!d'  $bestlhoodFile)
			echo -e "${dirname}/${runDir}\t$wantedParameters"  >> CollectResults.log >> ${summaryfile}
			# increase the number of files read
			let numFiles=numFiles+1
		else
		   echo "File $bestlhoodFile does not exist for run ${runDir}."
		fi				
                # out of bestlhood folder
#		cd ..				  				
	fi
	# out of run folder
#	cd ..
	
   fi
done
