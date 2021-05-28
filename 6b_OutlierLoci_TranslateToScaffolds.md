# Converting bayescan results to Loci


ddRAD loci were sequenced from 300-450bp insert sizes with 150bp PE reads. So we can definitely reconstruct haplotypes with 300-450bp sequences. 

But can we create longer haplotypes? 


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
SUPER_9	13873479		x	HPCH1
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
SUPER_18	2919538		x	a
SUPER_18	5119475		x	CH9
SUPER_18	5319989		x	CH9
SUPER_18	7568053	x		HP6
SUPER_18	7568063	x		HP6
SUPER_18	7568229	x		HP6
SUPER_18	7677559		x	CH10
SUPER_18	7677561		x	CH10
SUPER_18	7677568		x	CH10
SUPER_18	7677579		x	CH10
SUPER_18	7677642		x	CH10
SUPER_19	7875759		x	CH11
SUPER_19	11604518	x		HP7
SUPER_20	8466280		x	CH12
SUPER_20	8466283		x	CH12
SUPER_20	8466285		x	CH12
SUPER_22	3379804	x		HP8
SUPER_Z	9249052	x	x	HPCH2
SUPER_Z	22737603		x	CH13
SUPER_Z	28513286		x	CH14
SUPER_Z	39688189	x		HPCH3
SUPER_Z	39688283		x	HPCH3![image](https://user-images.githubusercontent.com/12142475/119566606-3ca99e00-bda3-11eb-9e4c-e27ff620070b.png)






```











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
