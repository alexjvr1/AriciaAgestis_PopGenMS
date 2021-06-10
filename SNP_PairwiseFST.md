# Manhattan plots 

Aim: Draw manhattan plots for Host Plant and Col Hist variants. 

1. Calculate per variant Fst for all loci based on a) Host Plant, and b) Col Hist

2. Plot Fst across the genome

3. Highlight Bayescan outliers.

4. Size proportional to Bayescan output. 



## 1. Pairwise fst across all loci

We can calculate W&C Fst using vcftools


On mac
```
/Users/alexjvr/2018.postdoc/BrownArgus_2018/201902_DataAnalysis/ManHattanPlot
#Use the vcf with no MAF filter

scp bluecp3:/newhome/aj18951/1a_Aricia_agestis_PopGenomics/FINAL_VCF/AA251_FINAL.noMT.recode.vcf .

vcftools --vcf AA251_FINAL.noMT.recode.vcf 

VCFtools - 0.1.17
(C) Adam Auton and Anthony Marcketta 2009

After filtering, kept 251 out of 251 Individuals
After filtering, kept 136613 out of a possible 136613 Sites

Run Time = 2.00 seconds


head popnames

Indiv	pop	HostPlant	ColHist	HaplotypeGroup
BAR_10_2013	BAR	Rockrose	new	newRR
BAR_11_2014	BAR	Rockrose	new	newRR
BAR_12_2013	BAR	Rockrose	new	newRR
BAR_13_2014	BAR	Rockrose	new	newRR
BAR_14_2013	BAR	Rockrose	new	newRR
BAR_14_2014	BAR	Rockrose	new	newRR
BAR_15_2014	BAR	Rockrose	new	newRR
BAR_17_2014	BAR	Rockrose	new	newRR
BAR_18_2014	BAR	Rockrose	new	newRR


#Create a file for each population
grep Rockrose popnames |awk '{print $1,$2}' >> RR.names
grep Geranium popnames |awk '{print $1,$2}' >> Ger.names


#Estimate per locus W&C Fst
vcftools --vcf AA251_FINAL.noMT.recode.vcf  --weir-fst-pop RR.names --weir-fst-pop Ger.names --out RR.vs.Ger

Parameters as interpreted:
	--vcf AA251_FINAL.noMT.recode.vcf
	--weir-fst-pop RR.names
	--weir-fst-pop Ger.names
	--keep RR.names
	--keep Ger.names
	--out RR.vs.Ger

Keeping individuals in 'keep' list
After filtering, kept 251 out of 251 Individuals
Outputting Weir and Cockerham Fst estimates.
Weir and Cockerham mean Fst estimate: 0.016332
Weir and Cockerham weighted Fst estimate: 0.018222
After filtering, kept 35462 out of a possible 35462 Sites
Run Time = 5.00 seconds

```
5 seconds for 35k loci!



