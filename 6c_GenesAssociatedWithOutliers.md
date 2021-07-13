# Genes associated with outliers

### Goal: 

1. Find genes linked to outlier loci

2. GO enrichment analysis to test for functional enrichment


### Method


1. Find genes associated with outlier loci using [snpEff](https://pcingola.github.io/SnpEff/)

2. GO enrichment analysis following the method [here](http://geneontology.org/docs/go-enrichment-analysis/) 



## snpEff

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



