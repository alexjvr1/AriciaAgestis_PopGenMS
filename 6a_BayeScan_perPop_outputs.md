# Bayescan Jackknife check

Goal: check if a single population has an effect on the final outliers identified. 

### Inputs: 

/Users/alexjvr/2018.postdoc/BrownArgus_2018/201902_DataAnalysis/Bayescan/

I generated input files for each of the ColHist and HostPlant input files which excludes a single population. 

Bayescan inputs were generated using pgdSpider and modifying an ond spidfile. ¨

Marker type = SNP. 

Choose modified population file in each case. 

### Run Analysis

All input files were copied onto the server and analyses were run here: 

```
bluecp3:/newhome/aj18951/1a_Aricia_agestis_PopGenomics/Bayescan
```

### Analyse output files. 

All output files were copied back to the mac location above and checked for convergence using R.

Below is the basic script and then I show the output for each of the runs. 

```
source("plot_R.r")
library(coda)

chain <- read.table("AA216.HostPlantPop.baye.sel", header=T)
chain <- mcmc(chain, thin=10)

plot(chain)  ##check for convergence
summary(chain)

autocorr.diag(chain) ## check correlation between the chains. Make sure the chains didn't get stuck

effectiveSize(chain) ##check that this is close to the sample size (here 5000). If there is correlation (chain got stuck) the sample size will be much smaller than the input

geweke.diag(chain, frac1=0.1, frac2=0.5)  ##The diagnostic reports the z-scores for each parameter. For example, with α = 0.05, the critical values of z are – 1.96 and +1.96. We reject H0 (equality of means => convergence) if z < -1.96 or z > +1.96.

heidel.diag(chain, eps=0.1, pvalue=0.05) ##another test whether the chains have reached stationarity. 
```


### Check for Convergence: Col Hist



### Check for Convergence: Host Plant


## Identify Outliers

### Outliers: Col Hist


### Outliers: Host Plant
