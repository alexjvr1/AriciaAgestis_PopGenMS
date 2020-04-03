#!/bin/bash

# (c) Victor Soria-Carrasco
# victor.soria.carrasco@gmail.com
# Last modified: 23/04/2018 23:01:10
# Modified by Alexandra Jansen van Rensburg to run on Blue Crystal p3 (UoB)
# Last modified 03/04/2020

# Description:
# Modification of previous script (03a_call_SNVs_bluecp3.sh) to split the reference in multiple regions to be used for ANGSD 

VERSION='1.1.0-2020.04.03'

#Define module versions to be loaded
MODULE1='apps/samtools-1.8'
MODULE2='apps/bcftools-1.8'
MODULE3='languages/perl-5.14.2'
MODULE4='languages/java-jdk-1.8.0-66'

SAMTOOLS='samtools'

# Default values for optional variables
REGIONS=''
CALLMODE='c'
VARONLY='1'
INDELS='0'
MINMQS=20
PVAR='0.05'
EMAIL=''
HRS=24
MEM=16
NJOBS=100
MAXNREGSPERJOB=50
JOBNAME='callREGIONS'

# Show author
# -----------------------------------------------------------------------------
function author {
	echo
	echo "#########################################"
	echo "  $(basename $0)"
	echo "  version $VERSION"
	echo "  (c) Victor Soria-Carrasco"
	echo "  victor.soria.carrasco@gmail.com"
	echo "#########################################"
	echo
}
# -----------------------------------------------------------------------------

# Show usage
# -----------------------------------------------------------------------------
function usage {
	echo
	echo "Usage:"
	echo "  $(basename $0)"
	#echo "      -i <input directory>  => Directory with BAM files (one file per sample/individual)"
	echo "      -r <fasta file>       => Reference sequence used for alignment"
	echo "      -o <output directory> => Output folder"
	#echo "      -regs <regions file>  => Regions file (optional, use scaffolds/chromosomes grouped for up to $NJOBS jobs otherwise)"
	#echo "      -c <c|m>              => bcftools caller; c=consensus, m=multi-allelic (optional, default=$CALLMODE)"
	#echo "      -v <0|1>              => call only variants (optional, default=$VARONLY)"
	#echo "      -d <0|1>              => call also indels (optional, default=$INDELS)"
	#echo "      -s <quality score>    => minimum phred quality score for alignments to be used for calling (optional, default=$MINMQS)"
	#echo "      -p <float 0-1>        => prob. of data under the hypothesis that locus is invariant (optional, default=$PVAR)"
	echo "      -t <allocated time>   => Allocated time (in hours) for the analysis (optional: default=$HRS)"
	echo "      -m <allocated memory> => Allocated memory (in gigabytes) for each analysis (optional: default=$MEM)"
	#echo "      -q <queue>            => SGE queue: iceberg | popgenom | molecol (optional: default=iceberg)"
	echo "      -e <email>            => Notification email address (default=none)"
	echo "      -module1 <ModuleName> => Name of module to load"
	echo "      -module2 <ModuleName> => Name of module to load" 
	echo "      -module3 <ModuleName> => Name of module to load"
	echo "      -module4 <ModuleName> => Name of module to load"
	echo "      -job <name of job>    => Name of current job"
	echo "      -h                    => show this help"
	echo ""
	echo "  Example:"
	echo "      $(basename $0) -r reference"
	echo ""
	echo ""
	exit 0
}
# -----------------------------------------------------------------------------

author

# Get options from the command line
# -----------------------------------------------------------------------------
if [ "$#" -ge "6" ]; # min 6 args: 2 for -i <input directory>, 2 for -r <fasta file>, 2 for -o <output directory>
then 
	while [ $# -gt 0 ]; do
		case "$1" in
			-h|-help) usage
					  ;;
			-r)	shift
				REFERENCE=$(readlink -f $1)
				;;
			-o)	shift
				OUTDIR=$(readlink -f $1)
				;;
			-regs)	shift
				REGIONS=$(readlink -f $1)
				;;
			-c)	shift
				CALLMODE=$1
				;;
			-v)	shift
				VARONLY=$1
				;;
			-d)	shift
				INDELS=$1
				;;
			-s)	shift
				MINMQS=$1
				;;
			-p)	shift
				PVAR=$1
				;;
			-t)	shift
				HRS=$1
				;;
			-m)	shift
				MEM=$1
				;;
			-q)	shift
				QUEUE=$1
				;;
			-module1)	shift
					MODULE1=$1
					;;
                        -module2)	shift
                                        MODULE2=$1
                                        ;;
                        -module3)	shift
                                        MODULE3=$1
                                        ;;
                        -module4)	shift
                                        MODULE4=$1
                                        ;;
			-job)	shift
				JOBNAME=$1
				;;
			-e)	shift
				EMAIL=$1
				;;	
			*)	echo 
				echo "ERROR - Invalid option: $1"
				echo
				usage
				;;
		esac
		shift
	done
else
	usage
fi
# -----------------------------------------------------------------------------

# Check $REFERENCE are defined
# -----------------------------------------------------------------------------
if [[ -z $REFERENCE ]]; then
	if [ -z $REFERENCE ]; then
		echo
		echo "ERROR: You must specify a reference file"
		echo
	fi
	usage
fi
# -----------------------------------------------------------------------------

# Check $REFERENCE exist
# -----------------------------------------------------------------------------
if [ ! -f $REFERENCE ]; then
	echo
	echo "ERROR: I can't find the reference file $REFERENCE"
	echo
	exit
fi
# -----------------------------------------------------------------------------


# Get all regions from reference if no file is given
# -----------------------------------------------------------------------------
if [[ $REGIONS == ''  ||  ! -f $REGIONS ]];
then
	REFSIZE=$(cat $REFERENCE.fai | awk '{SUM+=$2}END{print SUM}')
	JOBSIZE=$(perl -e 'print int(('$REFSIZE'/'$NJOBS')+1)')
	REGIONS=($(cat $REFERENCE.fai | sort -V | awk '{print $1}'))
	REGSIZES=($(cat $REFERENCE.fai | sort -V | awk '{print $2}'))	
	# echo "Generating regions file (splitting genome in ~$NJOBS regions of ~$JOBSIZE bp)..."
	echo "Generating regions file "
	echo "  splitting genome in chunks:"
	echo "    max size per job:  $JOBSIZE bp"
	echo "    max no regions per job: $MAXNREGSPERJOB"
	echo 

	CUMSIZE=0
	NREGS=0
	echo -n > regions
	RC=1
	# for I in $REGIONS;
	for ((i=0; i<${#REGSIZES[*]}; i++));
	do
		# REGSIZE=$(cat $REFERENCE.fai | awk '{if ($1=="'$REG'") print $2}')
		REG=${REGIONS[$i]}
		REGSIZE=${REGSIZES[$i]}
		CUMSIZE=$(($CUMSIZE + $REGSIZE))

		if [[ $CUMSIZE -gt $JOBSIZE || $NREGS -gt $MAXNREGSPERJOB ]];
		then
			echo "$REG" >> regions
			# echo "Set of regions size: $CUMSIZE"
			CUMSIZE=0
			NREGS=0
			echo -ne "  number of jobs: $RC\r"
			RC=$(($RC + 1))
		else
			echo -n "$REG," >> regions
			NREGS=$((NREGS + 1))
		fi
	done
	
	if [[ $CUMSIZE -gt 0 ]];
	then
		echo -e "  number of jobs: $RC\r"
		echo >> regions
	fi
	
	perl -pi -e 's/,$//g' regions
	echo
	echo
else
	cp $REGIONS regions
fi

REGIONS=regions

# number of regions
N=$(cat $REGIONS | wc -l)
