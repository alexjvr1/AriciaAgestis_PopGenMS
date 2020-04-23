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

