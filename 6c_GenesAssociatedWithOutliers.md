# Genes associated with outliers

### Goal: 

1. Find genes linked to outlier loci

2. GO enrichment analysis to test for functional enrichment


### Method


1. Find genes associated with outlier loci using [snpEff](https://pcingola.github.io/SnpEff/)

2. GO enrichment analysis following the method [here](http://geneontology.org/docs/go-enrichment-analysis/) 



## snpEff

snpEff is installed in the local directory, and we run all analyses from there. 
```
pwd
/newhome/aj18951/snpEff

```


Aricia agestis was not in the default snpEff database, so we built a database using the reference genome and annotation available on NCBI. 

Download the genome
```
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/annotation_releases/91739/100/GCF_905147365.1_ilAriAges1.1/GCF_905147365.1_ilAriAges1.1_genomic.fna.gz 
```

Download the annotation
```
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/annotation_releases/91739/100/GCF_905147365.1_ilAriAges1.1/GCF_905147365.1_ilAriAges1.1_genomic.gtf.gz
```

And build the genome using the steps given [here](https://pcingola.github.io/SnpEff/se_buildingdb/)
```
module load languages/java-jdk-11.0.3

java -jar snpEff.jar build -gtf22 -v AriAges1.1
```

Once the database is built we can run snpEff to find the closest genes associated with each of the outlier SNPs
```
module load languages/java-jdk-11.0.3

java -jar snpEff.jar closest AriAges1.1 AA251_phased_outliers.vcf > testout.vcf
```

This writes 3 output files: 

1. testout.vcf = annotation added to each snp in the vcf. Because we specified "closest" these include the closest gene in the SNP does not fall inside a gene

2. snpEff_genes.txt - A list of all the gene and transcript names. 

3. snpEff_summary.html = a summary of the types of mutations and where they occur (introns, exons, upstream, regulator, etc)

