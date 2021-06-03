# Converting bayescan results to Loci


ddRAD loci were sequenced from 300-450bp insert sizes with 150bp PE reads. So we can definitely reconstruct haplotypes with 300-450bp sequences. 

But can we create longer haplotypes? 


## Variant positions

How many SNPs within 300bp for the outlier loci

```
#create a list of all the variant positions

vcftools --vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf --site-mean-depth


```


```
HP1 - SUPER_5 2534121-2534002
HP2 - SUPER_8 3986867- 3986655 (DP30-40x)
HP3 - SUPER_9 8814131-8813929
HP4 - SUPER_16 1044290-1044346
HP5 - SUPER_16 13191435-13191349
HP6 - SUPER_18 7568229-7568031
HP7 - SUPER_19 11604613-11604518
HP8 - SUPER_22 3379920-3379790

HPCH1 - SUPER_9 13750872-13750697
HPCH2 - SUPER_9 13873517-13873437
HPCH3 - SUPER_Z only one variant
HPCH4 - SUPER_Z 39688352- 39688177

CH1 - SUPER_2 19346640-19346580
CH2 - SUPER_3 13158002-13157714
CH3 - SUPER_5 1546529-1546360
CH4 - SUPER_7 10650289-10650285
CH5 - SUPER_9 15951875-15951709
CH6 - SUPER_10 14888843-14888691
CH7 - SUPER_17 1198741-1198584
CH8 - SUPER_18 2919551-2919521
CH9 - SUPER_18 5119475-5119217
CH10 - SUPER_18 5320001-5319947
CH11 - SUPER_18 7677682-7677546
CH12 - SUPER_19 7875833-7875580
CH13 - SUPER_20 8466312-8466072   (DP 60-70x)
CH14 - SUPER_Z 22737787-22737599
CH15 - SUPER_Z 28513300 -28513286
```


5 neutral loci
```
SUPER_9 634759-634537
SUPER_9 1266219-1266047
SUPER_18 3989061-3988862
SUPER_18 14067330-14067023
SUPER_19 10294480-10294254

SUPER_Z 40939186-40939066
SUPER_Z 30091796-30091723

SUPER_2 7688146-7688027
SUPER_3 3617958-3617871
SUPER_3 11126031-11125804

```


## Phase using WhatsHap

WhatsHap uses read information from the bam file to phase variants within a given vcf file. This will resolve the phasing of each of the loci of interest plus all the other variants using the prvided bam files. 

[WhatsHap](https://whatshap.readthedocs.io/en/latest/installation.html) instructions

Install in software folder. We need several modules loaded: 
```
languages/python-3.8.5
languages/yasm-1.3.0
tools/nasm-2.15.05
tools/autoconf-2.69

pip3 install --user whatshap
export PATH=$HOME/.local/bin:$PATH
whatshap --help
```

Now we can phase the vcf file for all indivs. Whatshap authors suggest that PE Illumina reads are not the best option for phasing haplotypes as PE reads don't overlap heterozygous sites. But we're interested in generating phased RAD tags for each individual, so we'll see how it works: 

Test with 3 indivs
```
#Make sure the indivs in the vcf file have the same name as in the bam folder 

/newhome/aj18951/1a_Aricia_agestis_PopGenomics/WhatsHap

module load apps/bcftools-1.8
bcftools query -l AA251.FINAL.MAF0.01.missing0.5perpop.vcf > indivnames
head indivnames

BAR_10_2013
BAR_11_2014
BAR_12_2013
BAR_13_2014
BAR_14_2013
BAR_14_2014
BAR_15_2014
BAR_17_2014
BAR_18_2014
BAR_20_2014

#Change bam file names if necessary (and remember to change the .bai index files too)
../../software/rename-master/rename 's:_R1_.fastq.gz::g' ../../1a_Aricia_agestis_GWASdata/mapped_ddRAD/*bam
../../software/rename-master/rename 's:_R1_.fastq.gz::g' ../../1a_Aricia_agestis_GWASdata/mapped_ddRAD/*bam.bai

#Check that the bam files have RG headers that list the same sample names
module load apps/samtools-1.9.1
samtools view ../../1a_Aricia_agestis_GWASdata/mapped_ddRAD/BAR_13_2014.bam  |head
```



#We have no RG information on our samples so we need to add this using [PicardTools](https://gatk.broadinstitute.org/hc/en-us/articles/360037226472-AddOrReplaceReadGroups-Picard-)

```
module load apps/picard-2.20.0  
java -jar /cm/shared/apps/Picard-2.20.0/picard.jar

java -jar /cm/shared/apps/Picard-2.20.0/picard.jar AddOrReplaceReadGroups \
I=BAR_10_2013.bam \
O=BAR_10_2013.RG.bam \
RGID=1 \
RGLB=lib1 \
RGPL=Illumina \
RGPU=unit1 \
RGSM=BAR_10_2013

#Index file and run Whatshap to test
module load apps/samtools-1.9.1
samtools index BAR_10_2013.RG.bam

cd /newhome/aj18951/1a_Aricia_agestis_PopGenomics/WhatsHap/

whatshap phase -o phased.vcf --reference=../../1a_Aricia_agestis_GWASdata/RefGenome/ilAriAges1.1.primary.fa AA251.FINAL.MAF0.01.missing0.5perpop.vcf ../../1a_Aricia_agestis_GWASdata/mapped_ddRAD/BAR_10_2013.RG.bam 
This is WhatsHap 1.1 running under Python 3.8.5


#Once this is done we can extract all the outlier regions from our vcf file using tabix
module load apps/tabix-0.2.6
bgzip phased.vcf
tabix -p vcf phased.vcf.gz 

#We created a bed file with all the outliers in before while generating FastSimCoal input files
head outliers_toremove.bed 
SUPER_5 2534002 2534121
SUPER_8 3986655 3986867
SUPER_9 8813929 8814131
SUPER_16 1044346 1044290
SUPER_16 13191349 13191435
SUPER_18 7568031 7568229
SUPER_19 11604518 11604613
SUPER_22 3379790 3379920
SUPER_9 13750697 13750872
SUPER_9 13873437 13873517

#Use this to extract each region from the vcf file. This creates a vcf with all the outlier regions (26)
tabix -R outliers_toremove.bed phased.vcf.gz > BAR_10_2013.outlier.vcf 

#Split each vcf into the different loci
#eg
vcftools --vcf BAR_10_2013.outlier.vcf --chr SUPER_16 --from-bp 13191349 --to-bp 13191435 --recode --recode-INFO-all --out HP5
```


Then we can convert this file to fasta sequences using [vcfx](http://www.castelli-lab.net/vcfx.html)

```
#This is downloaded on the mac and installed in my software folder
#add to PATH

export PATH=/software/bin/macos:$PATH

#We're working here
/Users/alexjvr/2018.postdoc/BrownArgus_2018/201902_DataAnalysis/WhatsHap

#Download the vcf file to be converted and the RefGenome
scp bluecp3:/newhome/aj18951/1a_Aricia_agestis_GWASdata/RefGenome/ilA*fa .
vcfx fasta input=HP5.recode.vcf reference=ilAriAges1.1.primary.fa
```


## Automate for full dataset

This works so we'll set up a scripts to automate the steps for all the individuals. After we complete the outliers we need to extract 30 neutral loci as well. 


### 1. Add RG to all bam files and index them after. 

Use the [AddRG.sh](https://github.com/alexjvr1/AriciaAgestis_PopGenMS/blob/master/AddRG.sh) script

We can multi-thread 100 samples max, so we need to split our files into sets of 100 and submit multiple scripts

Get the list of sample names from the final vcffile
```
module load apps/bcftools-1.8
bcftools query -l /newhome/aj18951/1a_Aricia_agestis_PopGenomics/WhatsHap/AA251.FINAL.MAF0.01.missing0.5perpop.vcf >> RG
#These names will be the names we add into the RG for each bam file
#Copy to BAMLIST to create a list of all the bamfiles
#cp RG BAMLIST
#add .bam at the end
sed -i 's:2013:2013.bam:g' BAMLIST
sed -i 's:2014:2014.bam:g' BAMLIST

#and split both files
split -l 100 BAMFILES BAMFILES
split -l 100 RG RG

#Edit the script to point to each set of files. You should end up with 3 scripts to submit to queue in this case
for i in $(ls *sh); do qsub $i; done


```




2. Phase all indivs with WhatsHap

Use the [WhatsHap.sh](https://github.com/alexjvr1/AriciaAgestis_PopGenMS/blob/master/WhatsHap.sh) script and modify all variables. 

Split files into batches of 100 as before. 

This creates a separate vcf file for each sample

If run for the whole vcf file this can take a very long time. 

But we can extract the outlier loci and a random set of neutral loci



3. Split into different loci

We currently have a vcf file for each sample, but we need independent vcf files for each locus which contain all the samples. 

We'll concatenate all the vcf files together, then split by locus. 

```


```

4. Copy to mac and convert to Fasta format
```


```


5. Draw haplotype network for each locus
```


```













# OLD


## Linked loci 

We're extracting 10kb around each SNP or SNP region identified as outliers to create independent loci for a haplotype network

```
Total Loci: 25
Host Plant: 8
Col History: 14
Shared: 3
 

                 HostPlant	ColHist	Locus
SUPER_2	19346581		x	CH1
SUPER_3	13157714		x	CH2
SUPER_5	1546360		x	CH3
SUPER_5	2534121	x		HP1
SUPER_7	10650289		x	CH4
SUPER_8	3986867	x		HP2
SUPER_9	8813929	x		HP3
SUPER_9	8813944	x		HP3
SUPER_9	8813959	x		HP3
SUPER_9	8813963	x		HP3
SUPER_9	8813971	x		HP3
SUPER_9	8813992	x		HP3
SUPER_9	13750697	x	x	HPCH1
SUPER_9	13750721	x	x	HPCH1
SUPER_9	13750800	x	x	HPCH1
SUPER_9	13873479		x	HPCH2
SUPER_9	15951750		x	CH5
SUPER_10	14888830		x	CH6
SUPER_16	1044290	x		HP4
SUPER_16	13191358	x		HP5
SUPER_16	13191434	x		HP5
SUPER_16	13191435	x		HP5
SUPER_17	1198584		x	CH7
SUPER_17	1198594		x	CH7
SUPER_17	1198741		x	CH7
SUPER_18	2919522		x	CH8
SUPER_18	2919538		x	CH8
SUPER_18	5119475		x	CH9
SUPER_18	5319989		x	CH10
SUPER_18	7568053	x		HP6
SUPER_18	7568063	x		HP6
SUPER_18	7568229	x		HP6
SUPER_18	7677559		x	CH11
SUPER_18	7677561		x	CH11
SUPER_18	7677568		x	CH11
SUPER_18	7677579		x	CH11
SUPER_18	7677642		x	CH11
SUPER_19	7875759		x	CH12
SUPER_19	11604518	x		HP7
SUPER_20	8466280		x	CH13
SUPER_20	8466283		x	CH13
SUPER_20	8466285		x	CH13
SUPER_22	3379804	x		HP8
SUPER_Z	9249052	x	x	HPCH3
SUPER_Z	22737603		x	CH14
SUPER_Z	28513286		x	CH15
SUPER_Z	39688189	x		HPCH4
SUPER_Z	39688283		x	HPCH4
```

![image](https://user-images.githubusercontent.com/12142475/119566606-3ca99e00-bda3-11eb-9e4c-e27ff620070b.png)





# We'll use shapeIt

ShapeIt2 has a sequence aware phasing module where individual bam files are used to phase sequences. 

Download and install ShapeIt2 using instructions from [here](https://odelaneau.github.io/shapeit4/#installation) and move to bluecrystal aj18951/Software

















## Previous method with draft genome ##

## Loci. 

Linkage groups as in H.melpomone
```
###Host Plant (7 loci)

#Locus1: LG 01
2072  m_scaff_962_19860 

#Locus2: LG NA
10676 contig_11951_10614  

#Locus3: LG NA **Also found in  Col Hist +++Final Loci in Host Plant Jackknife test
11041 * +++   contig_5345_510
11042 +++     contig_5345_511
11050 * +++   contig_5345_587


#Locus4: LG NA
12108  contig_17378_3882

#Locus5: LG NA
16942 contig_5407_5785

#Locus6: LG NA
17001 contig_19343_4711

#Locus7: LG NA **Also found in  Col Hist
21375 *  contig_3838_3376
21377    contig_3838_3378
21378 *  contig_3838_3382
21379    contig_3838_3408

###ColHist (9 loci)

#Locus8: LG NA
10847    contig_4712_1181

#Locus3: LG NA  **Also found in  HostPlant (Not in ColHist Jackknife test)
11041 *   contig_5345_510
11050 *   contig_5345_587

#Locus9: LG NA
12957     contig_16912_5538

#Locus10: LG NA
13829     contig_3360_2654
13830     contig_3360_2666

#Locus11: LG NA
17567     contig_59667_912

#Locus7: LG NA **Also found in  HostPlant
21375 *   contig_3838_3376
21378 *   contig_3838_3382

#Locus12: LG NA
27882     contig_18281_3083

#Locus13: LG NA
28329     contig_1883_23537

#Locus14: LG NA
28726     contig_19564_5748
28728     contig_19564_5815

```

Loci identified as outliers when FOR was classified as OLD, but dropped out when FOR was reclassified as NEW. 

These need to be removed from haplotype network analysis

```
8878 - contig_1784 pos_11597

17001 - contig_19343 pos_4711 **This locus is an outlier for HostPlant

18089 - contig_24918 pos_5337
```
