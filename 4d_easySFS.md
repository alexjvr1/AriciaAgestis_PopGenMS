# Resampled input files using easySFS

The ddRAD dataset is gappy - although the libraries have all been sequenced to a good depth, the insert size range did not exactly overlap between libraries.

The final filtered dataset comprises ~35k loci. If I filter for 1 SNP per RAD locus this decreases to ~3.5k. 

As we need at least 8000 loci (according to Vitor Sousa and Laurent Excoffier) for an accurate estimate of the SFS, I will downsample each locus using the [easySFS](https://github.com/isaacovercast/easySFS) script from Isaac Overcast. 

I'm doing this on the server, so make use of the installed packages rather than local installation: 
```
/newhome/aj18951/1a_Aricia_agestis_PopGenomics/FastSimCoal/GENERATE_INPUT

module load languages/python-anaconda3-2019.10

#configure the shell to use 'conda activate'

conda init bash

#restart the server

#activate the environment

conda activate easySFS

conda create -n easySFS 
conda activate easySFS
conda install -c bioconda dadi pandas

cd easySFS
chmod u+x easySFS.py
./easySFS.py

usage: easySFS.py [-h] [-a] -i VCF_NAME -p POPULATIONS [--proj PROJECTIONS]
                  [--preview] [-o OUTDIR] [--ploidy PLOIDY] [--prefix PREFIX]
                  [--unfolded] [--dtype DTYPE] [--GQ GQUAL] [-f] [-v]

optional arguments:
  -h, --help          show this help message and exit
  -a             .....
  ...
  
```

Create the input files: 

1. popfile

2. vcf filtered for minDP 10 and no MAF filter

```
head FOR.HOD.names.txt
FOR_11_2014	FOR
FOR_12_2014	FOR
FOR_13_2014	FOR
FOR_14_2014	FOR

```

And run easySFS in --preview to see the number of loci when projecting down. 

```
./easySFS.py -i ../Scripts_VCFtoSFS_VitorSousa/HOD.FOR.recode.vcf -p FOR.HOD.names.txt --preview
Processing 2 populations - odict_keys(['FOR', 'HOD'])
  Sampling one snp per locus

    Running preview mode. We will print out the results for # of segregating sites
    for multiple values of projecting down for each population. The dadi
    manual recommends maximizing the # of seg sites for projections, but also
    a balance must be struck between # of seg sites and sample size.

    For each population you should choose the value of the projection that looks
    best and then rerun easySFS with the `--proj` flag.
    
FOR
(2, 593.0)	(3, 890.0)	(4, 1090.0)	(5, 1241.0)	(6, 1362.0)	(7, 1463.0)	(8, 1549.0)	(9, 1624.0)	(10, 1690.0)	(11, 1748.0)	(12, 1800.0)	(13, 1848.0)	(14, 1890.0)	(15, 1930.0)	(16, 1966.0)	(17, 1999.0)	(18, 2029.0)	(19, 2057.0)	(20, 2084.0)	(21, 2036.0)	(22, 2059.0)	(23, 1971.0)	(24, 1990.0)	(25, 1903.0)	(26, 1919.0)	(27, 1817.0)	(28, 1830.0)	(29, 1706.0)	(30, 1717.0)	(31, 1542.0)	(32, 1552.0)	(33, 1365.0)	(34, 1373.0)	(35, 1148.0)	(36, 1153.0)	(37, 874.0)	(38, 878.0)	(39, 522.0)	(40, 525.0)	


HOD
(2, 605.0)	(3, 907.0)	(4, 1115.0)	(5, 1277.0)	(6, 1408.0)	(7, 1519.0)	(8, 1615.0)	(9, 1699.0)	(10, 1772.0)	(11, 1838.0)	(12, 1898.0)	(13, 1951.0)	(14, 2000.0)	(15, 2045.0)	(16, 2086.0)	(17, 2124.0)	(18, 2159.0)	(19, 2191.0)	(20, 2222.0)	(21, 2250.0)	(22, 2277.0)	(23, 2302.0)	(24, 2325.0)	(25, 2347.0)	(26, 2368.0)	(27, 2388.0)	(28, 2407.0)	(29, 2425.0)	(30, 2442.0)	(31, 2452.0)	(32, 2467.0)	(33, 2473.0)	(34, 2487.0)	(35, 2485.0)	(36, 2497.0)	(37, 2491.0)	(38, 2503.0)	(39, 2475.0)	(40, 2486.0)	(41, 2463.0)	(42, 2473.0)	(43, 2434.0)	(44, 2443.0)	(45, 2383.0)	(46, 2391.0)	(47, 2307.0)	(48, 2314.0)	(49, 2199.0)	(50, 2205.0)	(51, 2076.0)	(52, 2082.0)	(53, 1913.0)	(54, 1918.0)	(55, 1728.0)	(56, 1732.0)	(57, 1445.0)	(58, 1448.0)	(59, 1029.0)	(60, 1031.0)

```


Select the projection that's the best compromise between number of loci and number of individuals. 

```
./easySFS.py -i ../Scripts_VCFtoSFS_VitorSousa/HOD.FOR.recode.vcf -p FOR.HOD.names.txt --proj 22,38
Processing 2 populations - odict_keys(['FOR', 'HOD'])
  Sampling one snp per locus
Doing 1D sfs - FOR
Doing 1D sfs - HOD
Doing 2D sfs - ('FOR', 'HOD')
Doing multiSFS for all pops
```

### INPUT VCF

I'm using the final vcf file before the MAF 0.01 filter

```
vcftools --vcf AA261.recode.vcf --minQ 100 --min-meanDP 10 --max-meanDP 255 --max-alleles 2 --max-missing 0.5

VCFtools - v0.1.12b
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf AA261.recode.vcf
	--max-alleles 2
	--max-meanDP 255
	--min-meanDP 10
	--minQ 100
	--max-missing 0.5

After filtering, kept 261 out of 261 Individuals
After filtering, kept 58483 out of a possible 63054 Sites
Run Time = 7.00 seconds

vcftools --vcf AA261.FSCinput.recode.vcf --thin 600

VCFtools - v0.1.12b
(C) Adam Auton and Anthony Marcketta 2009

Parameters as interpreted:
	--vcf AA261.FSCinput.recode.vcf
	--thin 600

After filtering, kept 261 out of 261 Individuals
After filtering, kept 4860 out of a possible 58483 Sites
Run Time = 1.00 seconds

```

There seem to be a lot more independent loci in this dataset than before. I'm not using the --thin filter, but rather using easySFS to randomly sample a SNP per locus for the final SFS.  


### 1. Generate inputs for base model

We're first estimating the base model. i.e. what is the most likely colonisation scenario of the older populations (SOUTH, HOD, and FOR). 

Modify the pop file input and estimate the SFS for these three populations: 

```
bluecp3:/newhome/aj18951/1a_Aricia_agestis_PopGenomics/FastSimCoal/GENERATE_INPUT/easySFS/

popfile: noMAF.BaseModel.popinput
```

preview
```
module load languages/python-anaconda3-2019.10
conda activate easySFS

./easySFS.py -i AA.BaseModel.recode.vcf -p BaseModel.popinput --preview

Processing 3 populations - odict_keys(['SOUTH', 'FOR', 'HOD'])
  Sampling one snp per locus

    Running preview mode. We will print out the results for # of segregating sites
    for multiple values of projecting down for each population. The dadi
    manual recommends maximizing the # of seg sites for projections, but also
    a balance must be struck between # of seg sites and sample size.

    For each population you should choose the value of the projection that looks
    best and then rerun easySFS with the `--proj` flag.
    
SOUTH
(2, 516.0)	(3, 774.0)	(4, 955.0)	(5, 1098.0)	(6, 1217.0)	(7, 1319.0)	(8, 1409.0)	(9, 1489.0)	(10, 1562.0)	(11, 1627.0)	(12, 1688.0)	(13, 1744.0)	(14, 1796.0)	(15, 1844.0)	(16, 1889.0)	(17, 1932.0)	(18, 1972.0)	(19, 2010.0)	(20, 2046.0)	(21, 2080.0)	(22, 2113.0)	(23, 2144.0)	(24, 2174.0)	(25, 2203.0)	(26, 2230.0)	(27, 2257.0)	(28, 2282.0)	(29, 2307.0)	(30, 2330.0)	(31, 2353.0)	(32, 2375.0)	(33, 2397.0)	(34, 2418.0)	(35, 2438.0)	(36, 2457.0)	(37, 2476.0)	(38, 2495.0)	(39, 2512.0)	(40, 2530.0)	(41, 2547.0)	(42, 2563.0)	(43, 2580.0)	(44, 2595.0)	(45, 2611.0)	(46, 2626.0)	(47, 2640.0)	(48, 2655.0)	(49, 2669.0)	(50, 2682.0)	(51, 2696.0)	(52, 2709.0)	(53, 2722.0)	(54, 2734.0)	(55, 2747.0)	(56, 2759.0)	(57, 2770.0)	(58, 2782.0)	(59, 2794.0)	(60, 2805.0)	(61, 2816.0)	(62, 2826.0)	(63, 2837.0)	(64, 2847.0)	(65, 2857.0)	(66, 2867.0)	(67, 2877.0)	(68, 2886.0)	(69, 2896.0)	(70, 2905.0)	(71, 2914.0)	(72, 2923.0)	(73, 2931.0)	(74, 2940.0)	(75, 2947.0)	(76, 2955.0)	(77, 2964.0)	(78, 2972.0)	(79, 2975.0)	(80, 2983.0)	(81, 2989.0)	(82, 2997.0)	(83, 3002.0)	(84, 3010.0)	(85, 3014.0)	(86, 3022.0)	(87, 3026.0)	(88, 3033.0)	(89, 3032.0)	(90, 3039.0)	(91, 3039.0)	(92, 3046.0)	(93, 3045.0)	(94, 3052.0)	(95, 3047.0)	(96, 3054.0)	(97, 3047.0)	(98, 3053.0)	(99, 3046.0)	(100, 3052.0)	(101, 3040.0)	(102, 3046.0)	(103, 3037.0)	(104, 3042.0)	(105, 3034.0)	(106, 3039.0)	(107, 3030.0)	(108, 3035.0)	(109, 3022.0)	(110, 3028.0)	(111, 3020.0)	(112, 3025.0)	(113, 3001.0)	(114, 3006.0)	(115, 2995.0)	(116, 3000.0)	(117, 2971.0)	(118, 2976.0)	(119, 2956.0)	(120, 2961.0)	(121, 2940.0)	(122, 2945.0)	(123, 2918.0)	(124, 2922.0)	(125, 2905.0)	(126, 2909.0)	(127, 2884.0)	(128, 2888.0)	(129, 2866.0)	(130, 2870.0)	(131, 2845.0)	(132, 2849.0)	(133, 2828.0)	(134, 2832.0)	(135, 2805.0)	(136, 2808.0)	(137, 2785.0)	(138, 2789.0)	(139, 2760.0)	(140, 2764.0)	(141, 2742.0)	(142, 2745.0)	(143, 2720.0)	(144, 2723.0)	(145, 2704.0)	(146, 2708.0)	(147, 2676.0)	(148, 2679.0)	(149, 2641.0)	(150, 2645.0)	(151, 2603.0)	(152, 2606.0)	(153, 2571.0)	(154, 2574.0)	(155, 2538.0)	(156, 2541.0)	(157, 2504.0)	(158, 2507.0)	(159, 2468.0)	(160, 2471.0)	(161, 2432.0)	(162, 2435.0)	(163, 2389.0)	(164, 2392.0)	(165, 2349.0)	(166, 2352.0)	(167, 2300.0)	(168, 2303.0)	(169, 2261.0)	(170, 2264.0)	(171, 2217.0)	(172, 2219.0)	(173, 2170.0)	(174, 2172.0)	(175, 2104.0)	(176, 2106.0)	(177, 2022.0)	(178, 2024.0)	(179, 1939.0)	(180, 1941.0)	(181, 1848.0)	(182, 1850.0)	(183, 1757.0)	(184, 1759.0)	(185, 1644.0)	(186, 1645.0)	(187, 1498.0)	(188, 1499.0)	(189, 1336.0)	(190, 1337.0)	(191, 1124.0)	(192, 1125.0)	(193, 857.0)	(194, 858.0)	(195, 358.0)	(196, 358.0)	


FOR
(2, 487.0)	(3, 730.0)	(4, 893.0)	(5, 1016.0)	(6, 1114.0)	(7, 1193.0)	(8, 1262.0)	(9, 1318.0)	(10, 1371.0)	(11, 1402.0)	(12, 1444.0)	(13, 1460.0)	(14, 1495.0)	(15, 1494.0)	(16, 1524.0)	(17, 1490.0)	(18, 1514.0)	(19, 1470.0)	(20, 1491.0)	(21, 1419.0)	(22, 1436.0)	(23, 1351.0)	(24, 1366.0)	(25, 1277.0)	(26, 1289.0)	(27, 1202.0)	(28, 1212.0)	(29, 1111.0)	(30, 1119.0)	(31, 991.0)	(32, 998.0)	(33, 869.0)	(34, 875.0)	(35, 730.0)	(36, 734.0)	(37, 539.0)	(38, 541.0)	(39, 314.0)	(40, 315.0)	


HOD
(2, 499.0)	(3, 749.0)	(4, 920.0)	(5, 1053.0)	(6, 1162.0)	(7, 1254.0)	(8, 1334.0)	(9, 1404.0)	(10, 1467.0)	(11, 1523.0)	(12, 1574.0)	(13, 1620.0)	(14, 1663.0)	(15, 1701.0)	(16, 1738.0)	(17, 1769.0)	(18, 1801.0)	(19, 1826.0)	(20, 1853.0)	(21, 1876.0)	(22, 1900.0)	(23, 1914.0)	(24, 1936.0)	(25, 1939.0)	(26, 1958.0)	(27, 1959.0)	(28, 1977.0)	(29, 1968.0)	(30, 1984.0)	(31, 1965.0)	(32, 1979.0)	(33, 1949.0)	(34, 1962.0)	(35, 1926.0)	(36, 1938.0)	(37, 1892.0)	(38, 1902.0)	(39, 1853.0)	(40, 1863.0)	(41, 1805.0)	(42, 1814.0)	(43, 1744.0)	(44, 1752.0)	(45, 1676.0)	(46, 1683.0)	(47, 1590.0)	(48, 1596.0)	(49, 1492.0)	(50, 1498.0)	(51, 1393.0)	(52, 1399.0)	(53, 1255.0)	(54, 1259.0)	(55, 1126.0)	(56, 1130.0)	(57, 923.0)	(58, 926.0)	(59, 638.0)	(60, 640.0)
```


