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


20 neutral loci
```
SUPER_9 634537-634759
SUPER_9 1266047-1266219
SUPER_18 3988862-3989061
SUPER_18 14067023-14067330
SUPER_19 10294254-10294480

SUPER_Z 40939066-40939186
SUPER_Z 30091723-30091796

SUPER_2 7688027-7688146
SUPER_3 3617871-3617958
SUPER_3 11125804-11126031

SUPER_10 594536-594596
SUPER_10 1020514-1020624
SUPER_10  14105766-14105962 
SUPER_11 2265943-2266021
SUPER_11 5910423-5910508
SUPER_11 17281597-17281757
SUPER_12 2363714-2363804
SUPER_12 4828453-4828688
SUPER_13 1406702-1406841
SUPER_13 6798543-6798615
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


## Automate for full dataset (outliers and Neutral)

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




### 2. Phase all indivs with WhatsHap


#### 2.1 Subset the full vcf file to include only the outlier loci and a second file with only neutral loci
```
vcftools --vcf AAgestis.251_FINAL.newnames.vcf --bed outliers_toremove.bed --recode --recode-INFO-all --out AA251.outliers

vcftools --vcf ../FINAL_VCF/AAgestis.251_FINAL.newnames.vcf --bed neutral_toremove.bed --recode --recode-INFO-all --out AA251.neutral
```

#### 2.2 Split file into individuals before we phase. This will help the script run much faster, and vcf can have problems with combining phased and unphased data in one file. 
```
module load apps/bcftools-1.8
#Outlier
bcftools query -l AA251.outliers.recode.vcf > indivnames
split -l 100 indivnames indivnames

#Neutral
bcftools query -l AA251.neutral.recode.vcf > neutral.indivnames
split -l 100 neutral.indivnames neutral.indivnames
```

Use the [SplitVCF.sh](https://github.com/alexjvr1/AriciaAgestis_PopGenMS/blob/master/SplitVCF.sh) script


Remove all missing data
```
for i in $(ls *split.recode.vcf); do vcftools --vcf $i --max-missing 1 --recode --recode-INFO-all --out $i.nomiss; done
```

#### 2.3 Phase each indiv

Use the [WhatsHap.sh](https://github.com/alexjvr1/AriciaAgestis_PopGenMS/blob/master/WhatsHap.sh) script and modify all variables. 

Split files into batches of 100 as before. 

This creates a separate vcf file with a different sample phased for each vcf file.

If run for the whole vcf file this can take a very long time. 

But we can extract the outlier loci and a random set of neutral loci

Runs for ~20sec-2min per sample. ~30min when all samples are submitted. 


#### 2.4 Remove missing and unphased variants

WhatsHap only phases the hets, so we need to change the notation of the homozygous sites
```
for i in $(ls *phased.vcf); do sed -i 's:1/1:1|1:g' $i; done
for i in $(ls *phased.vcf); do sed -i 's:0/0:0|0:g' $i; done

#remove any unphased sites

for i in $(ls *phased.vcf); do vcftools --vcf $i --max-missing 1 --phased --recode --recode-INFO-all --out $i.nomiss; done
```


### 3. Split into different loci

We currently have a vcf file for each sample, but we need independent vcf files for each locus which contain all the samples. 

We'll concatenate all the vcf files together, then split by locus. 

```
module load apps/bcftools-1.8
module load apps/vcftools-0.1.17.2
module load apps/samtools-1.9.1
module load apps/tabix-0.2.6

for i in $(ls *RG*nomiss*vcf); do  bgzip $i; done
for i in $(ls *RG*nomiss*vcf.gz); do tabix $i; done

ls *nomiss*.vcf.gz > phased_vcf.names

bcftools merge --file-list phased_vcf.names -O v -o AA251_phased_outliers.vcf 
vcftools --vcf AA251_phased_outliers.vcf

VCFtools - 0.1.17
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf AA251_phased_outliers.vcf

After filtering, kept 250 out of 250 Individuals
After filtering, kept 332 out of a possible 332 Sites
Run Time = 0.00 seconds

##FOR_7_2014 is mis-indexing (I think) but I can't figure out why. We see two FOR_7_2014 samples in the file after indexing, but I can't physically see them in the file with bcftools query -l or less. I've removed this sample to proceed. 




bcftools merge --file-list phased_vcf.names -O v -o AA251_phased_neutral.vcf 
vcftools --vcf AA251_phased_neutral.vcf

VCFtools - 0.1.17
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf AA251_phased_neutral.vcf

After filtering, kept 251 out of 251 Individuals
After filtering, kept 315 out of a possible 315 Sites
Run Time = 0.00 seconds

```


Split into a vcf file for every outlier locus using the [SplitHapVCF.sh](https://github.com/alexjvr1/AriciaAgestis_PopGenMS/blob/master/SplitHapVCF.sh) script

Create the input files by splitting the .bed file 

```
awk '{print $1}' outliers_toremove.bed > OUTLIERS.CHR
awk '{print $2}' outliers_toremove.bed > OUTLIERS.START
awk '{print $3}' outliers_toremove.bed > OUTLIERS.END
#and paste all HAP names to OUTLIERS.HAP


awk '{print $1}' neutral_toremove.bed > NEUTRAL.CHR
awk '{print $2}' neutral_toremove.bed > NEUTRAL.START
awk '{print $3}' neutral_toremove.bed > NEUTRAL.END
#Name Neutral Loci NEUT1-20 in NEUTRAL.HAP

```



### 4. Copy to mac and convert to Fasta format
```
/Users/alexjvr/2018.postdoc/BrownArgus_2018/201902_DataAnalysis/WhatsHap

scp bluecp3:/newhome/aj18951/1a_Aricia_agestis_PopGenomics/WhatsHap/*vcf .
```

Create a file with all indiv names, pop, hostPlant, and colHist

For 251 indivs see [Hap.popnames](https://github.com/alexjvr1/AriciaAgestis_PopGenMS/blob/master/Hap.popnames)

*I'm removing FOR_7_2014 because couldn't be merged with bcftools*


We need to remove all missing data from each file
```
for i in $(ls *vcf); do vcftools --vcf $i --missing-indv && mv out.imiss $i.imiss; done
for i in $(ls *imiss); do awk '$5>0' $i | awk '{print $1}' > $i.toremove; done
for i in $(ls *vcf); do vcftools --vcf $i --remove $i.imiss.toremove --recode --recode-INFO-all --out $i.nomiss; done
```

Keep only Loci with at least 2 variants, and data for 100 indivs

*HP1 drops out from loci being filtered out*

OUTLIER
```
HAP	nSamples	nSites
CH1	167		5
CH10	197		7
CH11	204		19
CH12	109		19  
CH13	193		18
CH14	105		17
CH15	191		2   
CH2	26		19  **
CH3	166		17
CH4	148		1   **
CH5	77		6   **
CH6	195		22
CH7	154		16
CH8	214		6
CH9	138		23
HP1	0		    **
HP2	162		13
HP3	153		30  
HP4	211		6
HP5	192		14
HP6	167		16
HP7	185		7
HP8	172		8
HPCH1	205		20
HPCH2	162		9
HPCH4	205		12
```

22 Loci remaining

NEUTRAL
```
HAP	nSamples	nSites
NEUT1	251		0   **
NEUT2	176		28
NEUT3	229		30
NEUT4	129		19
NEUT5	154		18
NEUT6	247		13
NEUT7	244		7
NEUT8	165		11
NEUT9	175		13
NEUT10	228		16
NEUT11	222		13
NEUT12	149		12
NEUT13	199		11
NEUT14	181		14
NEUT15	213		7
NEUT16	199		17
NEUT17	174		14
NEUT18	197		35
NEUT19	215		16
NEUT20	188		12

```
19 loci remaining


Run [VCFx](http://www.castelli-lab.net/vcfx.html)

See [here](https://stackoverflow.com/questions/32481877/what-are-nr-and-fnr-and-what-does-nr-fnr-imply) for awk keep and remove command explanation
```
#~/Software/bin/macos/vcfx 
#export PATH=~/Software/bin/macos:$PATH

for i in $(ls *nomiss.recode.vcf); do vcfx fasta input=$i reference=ilAriAges1.1.primary.fa; done

#modify the popnames file for each haplotype to include only non-missing samples
##If using .toremove file to remove names - I didn't use this method. 
awk 'NR==FNR {T[$1]; next} $1 in T {next} 1' HP4.recode.vcf.missing.toremove popnames > HP4.popnames

#If using .tokeep files to - I used this method. 
#Generate .tokeep files for each sample based on the indivs in the final VCF 
for i in $(ls *nomiss.recode.vcf); do bcftools query -l $i > $i.tokeep; done
for i in $(ls *tokeep); do awk 'NR==FNR {T[$1]; next} $1 in T {print}' $i popnames > $i.FINALpopnames; done

#Remove all intermediate files
#And rename final files 
#1. all final vcf files will be *.nomiss.vcf
rename 's:recode.vcf.nomiss.recode.vcf:nomiss.vcf:g' *vcf  
#2. remove other vcf files
rm *recode.vcf
#3. remove all full imiss files
rm *imiss
#4. rename files listing indivs to remove and keep
rename 's:recode.vcf.imiss.::g' *toremove
rename 's:recode.vcf.nomiss.recode.vcf.tokeep:nomiss.vcf.tokeep:g' *tokeep
#5. rename fas files
rename 's:recode.vcf.nomiss.recode.:nomiss.:g' *fas
#6.rename popnames
rename 's:recode.vcf.imiss.toremove.FINAL:nomiss.:' *FINALpopnames

#Each popnames file needs to have two lines per indiv, because each has two haplotpyes. 
#This script skips the first line (header) so we'll add headers when we read into R
awk 'NR>1{for(i=0;i<2;i++)print}' test.popnames 

for i in $(ls *FINALpopnames); do awk 'NR>0{for(i=0;i<2;i++)print}' $i > $i.HAP; done

```

Quick length check for all the haplotypes. We'll see more once they're in R
```
for i in $(ls *fas); do ls $i && awk '{print length}' $i |head -n 2; done
#Some of the sequences are really short, but we'll see what the haplotypes look like before deciding what to do
```



### 5. Draw haplotype network for each locus


On mac
```
/Users/alexjvr/2018.postdoc/BrownArgus_2018/201902_DataAnalysis/WhatsHap

R
library(pegas)
four.colours <- c("darkorchid4", "darkorchid", "gold1", "gold3")  ##for the groups Old.Ger.HOD, newGer, newRR, South.oldRR)
loc1.fa <- read.FASTA("HP4.nomiss.fas")
h <- haplotype(loc1.fa)
net <- haploNet(h)
plot(net)

loc1.popnames <- read.table("HP4.nomiss.vcf.tokeep.FINALpopnames.HAP", header=F)
colnames(loc1.popnames) <- c("Indiv", "pop", "HostPlant", "ColHist", "HaplotypeGroup")


head(loc1.popnames)
        Indiv pop HostPlant ColHist HaplotypeGroup
1 BAR_10_2013 BAR  Rockrose     new          newRR
2 BAR_10_2013 BAR  Rockrose     new          newRR
3 BAR_11_2014 BAR  Rockrose     new          newRR
4 BAR_11_2014 BAR  Rockrose     new          newRR
5 BAR_12_2013 BAR  Rockrose     new          newRR
6 BAR_12_2013 BAR  Rockrose     new          newRR

summary(loc1.popnames$HaplotypeGroup)
  HOD.oldGer      newGer       newRR South.oldRR 
         46         118          76         160 


##create a table to count haplotypes in each catagory
ind.hap<-with(stack(setNames(attr(h, "index"), rownames(h))), table(hap=ind, pop=loc1.popnames$HaplotypeGroup))    

     pop
hap   HOD.oldGer newGer newRR South.oldRR
  I           52    115    76         182
  II           0     11     0           0
  III          0      1     0           0
  IV           0      1     0           0
  
plot(net, scale.ratio = 2, cex = 0.8, pie=ind.hap, bg=four.colours)  
legend("topleft", colnames(ind.hap), col=four.colours, pch=20)

##To add info about HOD

three.colours <- c("gold1", "gold3", "darkorchid")
plot(net, scale.ratio = 2, cex = 0.8, pie=ind.hap, bg=three.colours)
legend("topleft", colnames(ind.hap), col=three.colours, pch=20)

```


And for the rest
```
HP4.fa <- read.FASTA("HP4.nomiss.fas")
h <- haplotype(HP4.fa)
net <- haploNet(h)
plot(net)

loc1.popnames <- read.table("HP4.nomiss.vcf.tokeep.FINALpopnames.HAP", header=F)
colnames(loc1.popnames) <- c("Indiv", "pop", "HostPlant", "ColHist", "HaplotypeGroup")
ind.hap<-with(stack(setNames(attr(h, "index"), rownames(h))), table(hap=ind, pop=loc1.popnames$HaplotypeGroup))    
	 
pdf("HP4.pdf")
plot(net, scale.ratio = 2, cex = 0.8, pie=ind.hap, bg=four.colours)  
legend("topleft", colnames(ind.hap), col=four.colours, pch=20)
dev.off()


pdf("HP2.pdf")

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
