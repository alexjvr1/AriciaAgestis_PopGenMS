# SFS from VCF file with missing data

The BA dataset has a large proportion of non-overlapping loci genotyped across indidviduals. Thus if I exclude missing data and filter for linkage (1 SNP per RAD tag) we end up with only ~3500 loci. 
I tried to use ANGSD to generate the SFS for fastSimCoal by allowing a minimum of 2x coverage per individual per locus. However the intersecting datasets between populations still removed most of the loci. We end up with ~5000 loci in the merged HOD and FOR dataset. 
This is sure to decrease if we add SOUTH and NEW. 

Here I use [Vitor Sousa's scripts](https://github.com/vsousa/EG_cE3c/tree/master/CustomScripts/Fastsimcoal_VCFtoSFS/Scripts_VCFtoSFS) to resample individuals and create the SFS inputs for fastSimCoal. 


```
pwd
/newhome/aj18951/1a_Aricia_agestis_PopGenomics/FastSimCoal/GENERATE_INPUT

bcftools query -l ../../FINAL_VCF/AA261.0.5miss.9popsMerged.vcf >>  indnames
bcftools query -l ../../FINAL_VCF/AA261.0.5miss.9popsMerged.vcf | awk -F "_" '{print $1}' >>popnames

sed -i 's/BCH/SOUTH/g' popnames 
sed -i 's/SWD/SOUTH/g' popnames 
sed -i 's/LYD/SOUTH/g' popnames 

sed -i 's/BRO/NEW/g' popnames 
sed -i 's/WIS/NEW/g' popnames 
sed -i 's/MOF/NEW/g' popnames 
sed -i 's/BAR/NEW/g' popnames 

paste indnames popnames >> indpopinfo.txt

grep HOD indpopinfo.txt |wc -l
30
grep FOR indpopinfo.txt |wc -l
20
grep SOUTH indpopinfo.txt |wc -l
98
grep NEW indpopinfo.txt |wc -l
113

```




