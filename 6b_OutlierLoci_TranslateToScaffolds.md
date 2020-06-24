# Converting bayescan results to scaffolds


Summary of the output from each run: 

## Loci
```
###Host Plant (7 loci)

#Locus1
2072  m_scaff_962_19860

#Locus2
10676 contig_11951_10614

#Locus3 **Also found in  Col Hist +++Final Loci in Host Plant Jackknife test
11041 * +++   contig_5345_510
11042 +++     contig_5345_511
11050 * +++   contig_5345_587


#Locus4
12108  contig_17378_3882

#Locus5
16942 contig_5407_5785

#Locus6
17001 contig_19343_4711

#Locus7 **Also found in  Col Hist
21375 *  contig_3838_3376
21377    contig_3838_3378
21378 *  contig_3838_3382
21379    contig_3838_3408

###ColHist (9 loci)

#Locus8
10847    contig_4712_1181

#Locus3 **Also found in  HostPlant (Not in ColHist Jackknife test)
11041 *   contig_5345_510
11050 *   contig_5345_587

#Locus9
12957     contig_16912_5538

#Locus10
13829     contig_3360_2654
13830     contig_3360_2666

#Locus11
17567     contig_59667_912

#Locus7 **Also found in  HostPlant
21375 *   contig_3838_3376
21378 *   contig_3838_3382

#Locus12
27882     contig_18281_3083

#Locus13
28329     contig_1883_23537

#Locus14
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
