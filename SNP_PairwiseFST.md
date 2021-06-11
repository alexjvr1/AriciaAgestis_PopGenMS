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
#I initiall used the vcf with no MAF filter
scp bluecp3:/newhome/aj18951/1a_Aricia_agestis_PopGenomics/FINAL_VCF/AA251_FINAL.noMT.recode.vcf .

vcftools --vcf AA251_FINAL.noMT.recode.vcf 

VCFtools - 0.1.17
(C) Adam Auton and Anthony Marcketta 2009

After filtering, kept 251 out of 251 Individuals
After filtering, kept 136613 out of a possible 136613 Sites

Run Time = 2.00 seconds



#But the outlier analysis (Bayescan) was run on the vcf with 5% MAF filter, so final figures based on that: 


vcftools --vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf


VCFtools - 0.1.17
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf

After filtering, kept 251 out of 251 Individuals
After filtering, kept 35462 out of a possible 35462 Sites
Run Time = 3.00 seconds




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
vcftools --vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf  --weir-fst-pop RR.names --weir-fst-pop Ger.names --out RR.vs.Ger

Parameters as interpreted:
	--vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf
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




##ColHist

#create a file for each population 
grep new popnames |awk '{print $1,$2}' >> New.names
grep old popnames |awk '{print $1,$2}' >> Est.names

#Estimate per locus W&C Fst
vcftools --vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf  --weir-fst-pop New.names --weir-fst-pop Est.names --out New.vs.Est

Parameters as interpreted:
	--vcf AAgestis.251.MAF0.05.missing0.5perpop.noMT.vcf
	--weir-fst-pop New.names
	--weir-fst-pop Est.names
	--keep New.names
	--keep Est.names
	--out New.vs.Est

Keeping individuals in 'keep' list
After filtering, kept 251 out of 251 Individuals
Outputting Weir and Cockerham Fst estimates.

Weir and Cockerham mean Fst estimate: 0.026095
Weir and Cockerham weighted Fst estimate: 0.029627
After filtering, kept 35462 out of a possible 35462 Sites
Run Time = 5.00 seconds



```
5 seconds for 137k loci!


## 2. Fst Plot

We're using Manhattan plot from qqman. See docs [here](https://www.rdocumentation.org/packages/qqman/versions/0.1.2/topics/manhattan)

### 1. We need to change the chromosome names to numbers

```
##HostPlant
sed 's:SUPER_::g' RR.vs.Ger.weir.fst > Fst.results.RRvsGer
sed 's:Z:50:g' Fst.results.RRvsGer > Fst.results.RRvsGer2
rm Fst.results.RRvsGer && mv Fst.results.RRvsGer2 Fst.results.RRvsGer

##ColHist
sed 's:SUPER_::g' New.vs.Est.weir.fst > Fst.results.NewvsEst
sed 's:Z:50:g' Fst.results.NewvsEst > Fst.results2.NewvsEst
rm Fst.results.NewvsEst && mv Fst.results2.NewvsEst Fst.results.NewvsEst

```


### 2. Add in a column with names of the outlier loci we want to highlight

We can use dplyr to add info into the SNP column using the case_when function. See [here](https://www.marsja.se/r-add-column-to-dataframe-based-on-other-columns-conditions-dplyr/) and [here](https://www.r-bloggers.com/2020/05/r-how-to-assign-values-based-on-multiple-conditions-of-different-columns/) for useful dplyr notes. And these links for a [dplyr cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf), and other [useful cheatsheets](https://www.rstudio.com/resources/cheatsheets/). 

We get the outlier positions from table S2 from the BA Pop Gen MS. I've copied them here for ease of use: 
```
Outlier Locus name	Association	Chr	Start bp	End bp	Length (bp)	nr SNPs
CH1	ColHist	CHR 2	19346580	19346640	60	5
CH10	ColHist	CHR 18	5319947	5320001	54	7
CH11	ColHist	CHR 18	7677546	7677682	136	19
CH12	ColHist	CHR 19	7875580	7875833	253	19
CH13	ColHist	CHR 20	8466072	8466312	240	18
CH14	ColHist	CHR Z	22737599	22737787	188	17
CH15	ColHist	CHR Z	28513286	28513300	14	2
CH2	ColHist	CHR 3	13157714	13158002	288	19
CH3	ColHist	CHR 5	1546360	1546529	169	17
CH4	ColHist	CHR 7	10650285	10650289	4	1
CH5	ColHist	CHR 9	15951709	15951875	166	6
CH6	ColHist	CHR 10	14888691	14888843	152	22
CH7	ColHist	CHR 17	1198584	1198741	157	16
CH8	ColHist	CHR 18	2919521	2919551	30	6
CH9	ColHist	CHR 18	5119217	5119475	258	23
HP1	HostPlant	CHR 5	2534002	2534121	119	1
HP2	HostPlant	CHR 8	3986655	3986867	212	13
HP3	HostPlant	CHR 9	8813929	8814131	202	30
HP4	HostPlant	CHR 16	1044290	1044346	56	6
HP5	HostPlant	CHR 16	13191349	13191435	86	14
HP6	HostPlant	CHR 18	7568031	7568229	198	16
HP7	HostPlant	CHR 19	11604518	11604613	95	7
HP8	HostPlant	CHR 22	3379790	3379920	130	8
HPCH1	Both	CHR 9	13750697	13750872	175	20
HPCH2	ColHist	CHR 9	13873437	13873517	80	9
HPCH3	Both	CHR Z	9249052	9249052	1	1
HPCH4	Both	CHR Z	39688177	39688352	175	12![image](https://user-images.githubusercontent.com/12142475/121661297-f8551800-ca9b-11eb-8b76-fc9ecdfd6529.png)



```


We've renamed the chromosomes to be numbers (1-22, Z=50) using awk
```
R


#Read in data and remove NAs
Fst.HP <- read.table("Fst.results.RRvsGer", header=T)
Fst.HP.nomiss <- na.exclude(Fst.HP)

Fst.CH <- read.table("Fst.results.NewvsEst", header=T)
Fst.CH.nomiss <- na.exclude(Fst.CH)


library(dplyr)
Fst.HP.nomiss <- Fst.HP.nomiss %>% mutate(SNP=case_when(
CHROM==5 & POS>2534001 & POS<2534122 ~"HP1",
CHROM==8 & POS>3986654 & POS<3986868 ~"HP2",
CHROM==9 & POS>8813928 & POS<8814132 ~"HP3", 
CHROM==16 & POS>1044289 & POS<1044347 ~"HP4", 
CHROM==16 & POS>13191348 & POS<13191436 ~"HP5", 
CHROM==18 & POS>7568030 & POS<7568230 ~"HP6", 
CHROM==19 & POS>11604517 & POS<11604614 ~"HP7",
CHROM==22 & POS>3379789 & POS<3379919 ~"HP8",
CHROM==9 & POS>13750696 & POS<13750873 ~"HPCH1",
CHROM==9 & POS>13873436 & POS<13873518 ~"HPCH2",
CHROM==50 & POS>9249051 & POS<9249053 ~"HPCH3",
CHROM==50 & POS>39688176 & POS<39688353 ~"HPCH4"
))

Fst.CH.nomiss <- Fst.CH.nomiss %>% mutate(SNP=case_when(
CHROM==2 & POS>19346579 & POS<19346641 ~"CH1",
CHROM==18 & POS>5319946& POS<5320002 ~"CH10",
CHROM==18 & POS>7677545 & POS<7677683 ~"CH11",
CHROM==19 & POS>7875579 & POS<7875834 ~"CH12",
CHROM==20 & POS>8466071 & POS<8466313 ~"CH13",
CHROM==50 & POS>22737598 & POS<22737788 ~"CH14",
CHROM==50 & POS>28513285 & POS<28513301 ~"CH15",
CHROM==3 & POS>13157713 & POS<13158003 ~"CH2",
CHROM==5 & POS>1546359 & POS<1546530 ~"CH3",
CHROM==7 & POS>10650284 & POS<10650290 ~"CH4",
CHROM==9 & POS>15951708 & POS<15951876 ~"CH5",
CHROM==10 & POS>14888690 & POS<14888844 ~"CH6",
CHROM==17 & POS>1198583 & POS<1198742 ~"CH7",
CHROM==18 & POS>2919520 & POS<2919552 ~"CH8",
CHROM==18 & POS>5119216 & POS<5119476 ~"CH9",
CHROM==9 & POS>13750696 & POS<13750873 ~"HPCH1",
CHROM==9 & POS>13873436 & POS<13873518 ~"HPCH2",
CHROM==50 & POS>9249051 & POS<9249053 ~"HPCH3",
CHROM==50 & POS>39688176 & POS<39688353 ~"HPCH4"
))

#Create a vector of all the loci to highlight: 
HIGHLIGHT_HPSNPS <- as.character(c("HP1", "HP2", "HP3", "HP4", "HP5", "HP6", "HP7", "HP7", "HP8", "HPCH1", "HPCH2", "HPCH3", "HPCH4"))
HIGHLIGHT_CHSNPS <- as.character(c("CH1", "CH2", "CH3", "CH4", "CH5", "CH6", "CH7", "CH8", "CH9", "CH10", "CH11", "CH12", "CH13", "CH14", "CH15", "HPCH1", "HPCH2", "HPCH3", "HPCH4"))
```

Draw manhattan plot. 

Export to pdf for quick view, and .eps to open in Adobe Illustrator (had trouble opening the pdf). 
```
library(qqman)

pdf("HP.manhattan.pdf")
manhattan(Fst.HP.nomiss, chr="CHROM", bp="POS", p="WEIR_AND_COCKERHAM_FST", snp="SNP", col=c("gray10", "gray60"), chrlabs=c(1:22, "Z"), highlight=HIGHLIGHT_HPSNPS, logp=F, suggestiveline=F, genomewideline=F)
dev.off()

setEPS()
postscript("HP.manhattan.eps")
manhattan(Fst.HP.nomiss, chr="CHROM", bp="POS", p="WEIR_AND_COCKERHAM_FST", snp="SNP", col=c("gray10", "gray60"), chrlabs=c(1:22, "Z"), highlight=HIGHLIGHT_HPSNPS, logp=F, suggestiveline=F, genomewideline=F)
dev.off()


pdf("CH.manhattan.pdf")
manhattan(Fst.CH.nomiss, chr="CHROM", bp="POS", p="WEIR_AND_COCKERHAM_FST", snp="SNP", col=c("gray10", "gray60"), chrlabs=c(1:22, "Z"), highlight=HIGHLIGHT_CHSNPS, logp=F, suggestiveline=F, genomewideline=F)
dev.off()

setEPS()
postscript("CH.manhattan.eps")
manhattan(Fst.CH.nomiss, chr="CHROM", bp="POS", p="WEIR_AND_COCKERHAM_FST", snp="SNP", col=c("gray10", "gray60"), chrlabs=c(1:22, "Z"), highlight=HIGHLIGHT_CHSNPS, logp=F, suggestiveline=F, genomewideline=F)
dev.off()

