# Bayescan Jackknife check

Goal: check if a single population has an effect on the final outliers identified. 

### Inputs:

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

temp <- list.files(pattern="*sel")
chain.list <- lapply(temp, FUN=read.table, header=T)
chain.list2 <- lapply(chain.list, FUN=mcmc, thin=10)

##Check convergence
pdf("HostPlant.convergence.pdf")
lapply(chain.list2, FUN=plot)
dev.off()

lapply(chain.list2, FUN=summary)

[[1]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.833e+05 1.742e+02 2.463e+00      4.648e+00
Fst1  2.000e-02 2.981e-04 4.216e-06      6.999e-06
Fst2  2.024e-02 3.168e-04 4.481e-06      7.645e-06
Fst3  2.354e-02 4.903e-04 6.934e-06      9.587e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.836e+05 -2.834e+05 -2.833e+05 -2.832e+05 -2.830e+05
Fst1  1.942e-02  1.979e-02  2.000e-02  2.020e-02  2.057e-02
Fst2  1.964e-02  2.002e-02  2.024e-02  2.046e-02  2.087e-02
Fst3  2.258e-02  2.321e-02  2.352e-02  2.386e-02  2.450e-02


[[2]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.788e+05 2.810e+02 3.975e+00      1.171e+01
Fst1  1.936e-03 1.571e-04 2.221e-06      6.541e-06
Fst2  2.577e-02 2.850e-04 4.031e-06      5.098e-06
Fst3  3.280e-02 4.276e-04 6.048e-06      7.000e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.794e+05 -2.790e+05 -2.788e+05 -2.787e+05 -2.783e+05
Fst1  1.633e-03  1.827e-03  1.932e-03  2.046e-03  2.240e-03
Fst2  2.521e-02  2.557e-02  2.577e-02  2.596e-02  2.631e-02
Fst3  3.197e-02  3.251e-02  3.280e-02  3.309e-02  3.367e-02


[[3]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.687e+05 1.870e+02 2.645e+00      4.990e+00
Fst1  1.221e-02 2.503e-04 3.540e-06      7.939e-06
Fst2  1.999e-02 3.118e-04 4.410e-06      7.794e-06
Fst3  4.650e-02 8.292e-04 1.173e-05      1.373e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.691e+05 -2.688e+05 -2.687e+05 -2.686e+05 -2.683e+05
Fst1  1.172e-02  1.204e-02  1.221e-02  1.238e-02  1.270e-02
Fst2  1.937e-02  1.978e-02  1.999e-02  2.020e-02  2.060e-02
Fst3  4.488e-02  4.594e-02  4.649e-02  4.705e-02  4.813e-02


[[4]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.749e+05 1.961e+02 2.773e+00      8.232e+00
Fst1  1.568e-02 2.756e-04 3.899e-06      7.408e-06
Fst2  2.187e-02 3.282e-04 4.641e-06      7.805e-06
Fst3  4.050e-02 7.626e-04 1.079e-05      1.379e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.753e+05 -2.750e+05 -2.749e+05 -2.748e+05 -2.745e+05
Fst1  1.516e-02  1.550e-02  1.567e-02  1.587e-02  1.623e-02
Fst2  2.122e-02  2.165e-02  2.186e-02  2.209e-02  2.250e-02
Fst3  3.903e-02  3.997e-02  4.050e-02  4.101e-02  4.198e-02


[[5]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.814e+05 2.085e+02 2.949e+00      6.342e+00
Fst1  9.561e-03 2.312e-04 3.270e-06      7.597e-06
Fst2  3.525e-02 4.045e-04 5.721e-06      7.428e-06
Fst3  3.195e-02 4.988e-04 7.055e-06      8.814e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.819e+05 -2.816e+05 -2.814e+05 -2.813e+05 -2.810e+05
Fst1  9.107e-03  9.404e-03  9.563e-03  9.718e-03  1.001e-02
Fst2  3.445e-02  3.498e-02  3.525e-02  3.552e-02  3.604e-02
Fst3  3.098e-02  3.161e-02  3.194e-02  3.229e-02  3.293e-02


[[6]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -6.340e+05 1.597e+02 2.259e+00      5.358e+00
Fst1  2.319e-02 4.249e-04 6.010e-06      7.174e-06
Fst2  3.854e-02 4.655e-04 6.584e-06      7.549e-06
Fst3  4.274e-02 7.396e-04 1.046e-05      1.179e-05
Fst4  3.726e-02 6.733e-04 9.523e-06      1.027e-05
Fst5  3.167e-02 4.626e-04 6.543e-06      6.904e-06
Fst6  3.016e-02 5.233e-04 7.402e-06      9.156e-06
Fst7  3.015e-02 4.051e-04 5.729e-06      6.548e-06
Fst8  2.915e-02 4.103e-04 5.803e-06      7.587e-06
Fst9  4.382e-02 6.342e-04 8.970e-06      1.007e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -6.343e+05 -6.341e+05 -6.340e+05 -6.339e+05 -6.337e+05
Fst1  2.238e-02  2.291e-02  2.319e-02  2.347e-02  2.402e-02
Fst2  3.764e-02  3.822e-02  3.852e-02  3.885e-02  3.946e-02
Fst3  4.132e-02  4.224e-02  4.273e-02  4.323e-02  4.421e-02
Fst4  3.595e-02  3.679e-02  3.726e-02  3.770e-02  3.859e-02
Fst5  3.075e-02  3.137e-02  3.167e-02  3.199e-02  3.259e-02
Fst6  2.911e-02  2.981e-02  3.017e-02  3.052e-02  3.117e-02
Fst7  2.936e-02  2.987e-02  3.015e-02  3.042e-02  3.093e-02
Fst8  2.835e-02  2.889e-02  2.915e-02  2.942e-02  2.998e-02
Fst9  4.258e-02  4.340e-02  4.382e-02  4.423e-02  4.509e-02


[[7]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.796e+05 2.404e+02 3.399e+00      9.307e+00
Fst1  3.169e-03 1.652e-04 2.337e-06      6.216e-06
Fst2  2.681e-02 2.959e-04 4.185e-06      5.371e-06
Fst3  2.434e-02 3.630e-04 5.134e-06      6.190e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.801e+05 -2.797e+05 -2.796e+05 -2.794e+05 -2.791e+05
Fst1  2.848e-03  3.059e-03  3.165e-03  3.280e-03  3.496e-03
Fst2  2.624e-02  2.661e-02  2.681e-02  2.701e-02  2.739e-02
Fst3  2.362e-02  2.410e-02  2.434e-02  2.458e-02  2.505e-02


[[8]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.796e+05 2.421e+02 3.423e+00      8.676e+00
Fst1  3.171e-03 1.634e-04 2.312e-06      6.105e-06
Fst2  2.681e-02 3.008e-04 4.255e-06      5.363e-06
Fst3  2.435e-02 3.588e-04 5.074e-06      6.024e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.800e+05 -2.797e+05 -2.796e+05 -2.794e+05 -2.791e+05
Fst1  2.844e-03  3.063e-03  3.170e-03  3.280e-03  3.488e-03
Fst2  2.623e-02  2.661e-02  2.681e-02  2.701e-02  2.740e-02
Fst3  2.363e-02  2.411e-02  2.435e-02  2.458e-02  2.505e-02


[[9]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.798e+05 1.810e+02 2.560e+00      6.634e+00
Fst1  1.539e-02 2.372e-04 3.355e-06      6.229e-06
Fst2  1.111e-02 2.574e-04 3.641e-06      7.315e-06
Fst3  2.831e-02 4.430e-04 6.266e-06      9.277e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.801e+05 -2.799e+05 -2.798e+05 -2.796e+05 -2.794e+05
Fst1  1.493e-02  1.523e-02  1.539e-02  1.555e-02  1.585e-02
Fst2  1.062e-02  1.094e-02  1.111e-02  1.129e-02  1.163e-02
Fst3  2.746e-02  2.802e-02  2.830e-02  2.860e-02  2.919e-02


lapply(chain.list2, FUN=autocorr.diag) ## check correlation between the chains. Make sure the chains didn't get stuck

[[1]]
              logL         Fst1          Fst2         Fst3
Lag 0   1.00000000  1.000000000  1.0000000000  1.000000000
Lag 10  0.35879059  0.439258636  0.4242972940  0.262232919
Lag 50  0.05682607  0.006679864  0.0256075076 -0.006724698
Lag 100 0.05947839  0.010046353 -0.0009297211 -0.023233594
Lag 500 0.01048752 -0.017819082 -0.0210263390 -0.001227658

[[2]]
               logL       Fst1        Fst2         Fst3
Lag 0    1.00000000  1.0000000  1.00000000  1.000000000
Lag 10   0.71855202  0.7675045  0.20975756  0.145075690
Lag 50   0.31740046  0.3288519  0.01258458  0.016225844
Lag 100  0.13600598  0.1117953 -0.01110589  0.001941376
Lag 500 -0.01913684 -0.0464415 -0.01686811 -0.004592267

[[3]]
              logL        Fst1         Fst2         Fst3
Lag 0   1.00000000  1.00000000  1.000000000  1.000000000
Lag 10  0.43870812  0.64665404  0.415211032  0.156317962
Lag 50  0.08466230  0.12428070  0.071746556  0.003899578
Lag 100 0.04768748  0.02117960 -0.002528637  0.011028265
Lag 500 0.01661087 -0.01103629  0.004492814 -0.011816068

[[4]]
               logL        Fst1        Fst2          Fst3
Lag 0    1.00000000  1.00000000  1.00000000  1.0000000000
Lag 10   0.47982627  0.53563242  0.44046736  0.1782257675
Lag 50   0.19267085  0.03187660  0.02889982  0.0063904340
Lag 100  0.14690201  0.02796076 -0.04444465 -0.0284574725
Lag 500 -0.01932353 -0.03363773  0.02311577 -0.0006837062

[[5]]
                 logL        Fst1         Fst2         Fst3
Lag 0    1.0000000000 1.000000000  1.000000000  1.000000000
Lag 10   0.5318801061 0.680466030  0.230483966  0.198954135
Lag 50   0.1421256128 0.160037012 -0.027610951 -0.007210034
Lag 100 -0.0005721923 0.012659763  0.004435264 -0.014841260
Lag 500  0.0346055049 0.002205722  0.021311940 -0.006750357

[[6]]
               logL         Fst1         Fst2         Fst3         Fst4
Lag 0    1.00000000  1.000000000  1.000000000  1.000000000  1.000000000
Lag 10   0.30754007  0.175157107  0.135820405  0.119240412  0.075509832
Lag 50   0.15120007 -0.015946765  0.008361981 -0.012077166 -0.004939028
Lag 100  0.08945832  0.002803845 -0.012485848 -0.004798796  0.002304917
Lag 500 -0.05606252  0.006162458  0.007084026 -0.018229900  0.017125582
                Fst5          Fst6         Fst7        Fst8         Fst9
Lag 0    1.000000000  1.0000000000  1.000000000  1.00000000  1.000000000
Lag 10   0.123286754  0.1825444281  0.132620270  0.22225171  0.114669674
Lag 50  -0.006582791  0.0050387041 -0.001697224  0.01890867  0.001457232
Lag 100 -0.022383204 -0.0242565885 -0.023987708 -0.01452887  0.010347987
Lag 500 -0.024263474  0.0002368038 -0.024605579 -0.00483573 -0.002126659

[[7]]
               logL        Fst1        Fst2         Fst3
Lag 0    1.00000000  1.00000000  1.00000000  1.000000000
Lag 10   0.63809822  0.71929436  0.21938783  0.184705269
Lag 50   0.24184818  0.26349204  0.01653101 -0.007923912
Lag 100  0.09412674  0.09105792  0.01764915 -0.002725584
Lag 500 -0.01792671 -0.01773352 -0.01943419 -0.001414307

[[8]]
               logL         Fst1          Fst2        Fst3
Lag 0   1.000000000  1.000000000  1.0000000000  1.00000000
Lag 10  0.647906769  0.719837948  0.2274409141  0.16993596
Lag 50  0.217223717  0.229768075  0.0136407874 -0.00271750
Lag 100 0.024359055  0.025138742  0.0005699158  0.01821014
Lag 500 0.007870321 -0.009631092 -0.0092647520  0.01163720

[[9]]
              logL         Fst1        Fst2        Fst3
Lag 0   1.00000000  1.000000000  1.00000000  1.00000000
Lag 10  0.40248298  0.476002400  0.47349169  0.28723403
Lag 50  0.13284058  0.086379959  0.07755878  0.02912931
Lag 100 0.08276119 -0.001562839  0.04936645  0.01777984
Lag 500 0.02070514 -0.044046591 -0.05338927 -0.01229990


effectiveSize(chain) ##check that this is close to the sample size (here 5000). If there is correlation (chain got stuck) the sample size will be much smaller than the input

geweke.diag(chain, frac1=0.1, frac2=0.5)  ##The diagnostic reports the z-scores for each parameter. For example, with α = 0.05, the critical values of z are – 1.96 and +1.96. We reject H0 (equality of means => convergence) if z < -1.96 or z > +1.96.

heidel.diag(chain, eps=0.1, pvalue=0.05) ##another test whether the chains have reached stationarity. 
```


### Check for Convergence: Col Hist

```
source("plot_R.r")
library(coda)

temp <- list.files(pattern="*sel")
chain.list <- lapply(temp, FUN=read.table, header=T)
chain.list2 <- lapply(chain.list, FUN=mcmc, thin=10)


##Check convergence
pdf("ColHist.convergence.pdf")
lapply(chain.list2, FUN=plot)
dev.off()

lapply(chain.list2, FUN=summary)
[[1]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.174e+05 2.854e+02 4.036e+00      1.175e+01
Fst1  1.238e-02 3.743e-04 5.293e-06      1.596e-05
Fst2  4.306e-02 4.758e-04 6.729e-06      9.147e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.179e+05 -2.176e+05 -2.174e+05 -2.172e+05 -2.168e+05
Fst1  1.165e-02  1.213e-02  1.237e-02  1.262e-02  1.313e-02
Fst2  4.214e-02  4.274e-02  4.306e-02  4.338e-02  4.399e-02


[[2]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.115e+05 2.383e+02 3.370e+00      8.191e+00
Fst1  3.401e-02 4.185e-04 5.920e-06      8.772e-06
Fst2  1.180e-02 3.463e-04 4.897e-06      1.265e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.120e+05 -2.116e+05 -2.115e+05 -2.113e+05 -2.110e+05
Fst1  3.323e-02  3.373e-02  3.401e-02  3.429e-02  3.485e-02
Fst2  1.113e-02  1.156e-02  1.180e-02  1.203e-02  1.248e-02


[[3]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

          Mean        SD  Naive SE Time-series SE
logL -2.19e+05 2.634e+02 3.725e+00      1.021e+01
Fst1  3.73e-02 4.324e-04 6.116e-06      8.907e-06
Fst2  1.17e-02 3.396e-04 4.803e-06      1.401e-05

2. Quantiles for each variable:

           2.5%        25%       50%        75%      97.5%
logL -2.195e+05 -2.192e+05 -2.19e+05 -2.188e+05 -2.185e+05
Fst1  3.648e-02  3.700e-02  3.73e-02  3.760e-02  3.814e-02
Fst2  1.102e-02  1.147e-02  1.17e-02  1.192e-02  1.239e-02


[[4]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.157e+05 2.467e+02 3.489e+00      9.557e+00
Fst1  1.072e-02 3.143e-04 4.446e-06      1.326e-05
Fst2  3.025e-02 3.814e-04 5.394e-06      8.342e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.161e+05 -2.158e+05 -2.157e+05 -2.155e+05 -2.152e+05
Fst1  1.013e-02  1.051e-02  1.072e-02  1.093e-02  1.136e-02
Fst2  2.948e-02  2.999e-02  3.025e-02  3.051e-02  3.100e-02


[[5]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.234e+05 2.170e+02 3.069e+00      6.358e+00
Fst1  4.246e-02 5.268e-04 7.451e-06      1.185e-05
Fst2  2.327e-02 4.753e-04 6.723e-06      1.485e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.239e+05 -2.236e+05 -2.234e+05 -2.233e+05 -2.230e+05
Fst1  4.142e-02  4.211e-02  4.247e-02  4.282e-02  4.351e-02
Fst2  2.236e-02  2.295e-02  2.328e-02  2.359e-02  2.421e-02


[[6]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.188e+05 2.373e+02 3.356e+00      7.775e+00
Fst1  3.609e-02 4.167e-04 5.894e-06      8.717e-06
Fst2  1.327e-02 3.456e-04 4.888e-06      1.256e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.192e+05 -2.189e+05 -2.188e+05 -2.186e+05 -2.183e+05
Fst1  3.529e-02  3.582e-02  3.610e-02  3.638e-02  3.690e-02
Fst2  1.261e-02  1.304e-02  1.327e-02  1.349e-02  1.397e-02


[[7]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.161e+05 2.658e+02 3.759e+00      1.075e+01
Fst1  3.639e-02 4.352e-04 6.155e-06      9.133e-06
Fst2  1.152e-02 3.327e-04 4.706e-06      1.405e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.166e+05 -2.163e+05 -2.161e+05 -2.160e+05 -2.156e+05
Fst1  3.555e-02  3.609e-02  3.638e-02  3.668e-02  3.727e-02
Fst2  1.086e-02  1.129e-02  1.152e-02  1.174e-02  1.216e-02


[[8]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.143e+05 2.221e+02 3.141e+00      6.926e+00
Fst1  3.569e-02 4.505e-04 6.372e-06      9.547e-06
Fst2  1.487e-02 3.774e-04 5.338e-06      1.278e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.147e+05 -2.144e+05 -2.143e+05 -2.141e+05 -2.138e+05
Fst1  3.482e-02  3.538e-02  3.569e-02  3.598e-02  3.657e-02
Fst2  1.414e-02  1.461e-02  1.486e-02  1.512e-02  1.560e-02


[[9]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.096e+05 2.658e+02 3.759e+00      1.076e+01
Fst1  3.442e-02 4.257e-04 6.021e-06      8.911e-06
Fst2  1.100e-02 3.315e-04 4.688e-06      1.425e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.101e+05 -2.098e+05 -2.096e+05 -2.094e+05 -2.091e+05
Fst1  3.358e-02  3.412e-02  3.442e-02  3.470e-02  3.525e-02
Fst2  1.038e-02  1.078e-02  1.100e-02  1.123e-02  1.166e-02


lapply(chain.list2, FUN=autocorr.diag)
[[1]]
               logL       Fst1         Fst2
Lag 0    1.00000000  1.0000000  1.000000000
Lag 10   0.71563142  0.7830025  0.297627170
Lag 50   0.30982220  0.3409337  0.012572514
Lag 100  0.11423602  0.1293022  0.003888899
Lag 500 -0.09780564 -0.1054079 -0.012846121

[[2]]
              logL        Fst1       Fst2
Lag 0   1.00000000  1.00000000 1.00000000
Lag 10  0.61564004  0.38612249 0.71076243
Lag 50  0.18736408  0.02743638 0.22297220
Lag 100 0.03127827 -0.01914601 0.02610308
Lag 500 0.06392317 -0.01299580 0.03264098

[[3]]
              logL         Fst1       Fst2
Lag 0   1.00000000  1.000000000 1.00000000
Lag 10  0.67698075  0.359025491 0.76709690
Lag 50  0.25743081  0.005685154 0.29018268
Lag 100 0.07045859 -0.041679020 0.07726744
Lag 500 0.04362776 -0.015925206 0.03996255

[[4]]
              logL       Fst1        Fst2
Lag 0   1.00000000 1.00000000 1.000000000
Lag 10  0.65142287 0.76955269 0.371060405
Lag 50  0.26523261 0.33348049 0.027693501
Lag 100 0.07817125 0.08366343 0.004587887
Lag 500 0.02013569 0.02673957 0.006707748

[[5]]
              logL         Fst1        Fst2
Lag 0   1.00000000  1.000000000 1.000000000
Lag 10  0.52518383  0.379388778 0.615215605
Lag 50  0.13840085  0.038474477 0.118885490
Lag 100 0.01228573 -0.002522034 0.008001083
Lag 500 0.04113934  0.029145651 0.001875841

[[6]]
              logL        Fst1        Fst2
Lag 0   1.00000000 1.000000000 1.000000000
Lag 10  0.60625058 0.343339464 0.717284946
Lag 50  0.19468770 0.004901118 0.215887723
Lag 100 0.07870156 0.017567867 0.043744323
Lag 500 0.02469923 0.003592067 0.001316504

[[7]]
                logL         Fst1        Fst2
Lag 0   1.0000000000  1.000000000  1.00000000
Lag 10  0.6903868857  0.326504126  0.76975188
Lag 50  0.2945653189  0.029815991  0.32498968
Lag 100 0.1229546239 -0.018193634  0.13367629
Lag 500 0.0009021429 -0.004254612 -0.03731018

[[8]]
               logL         Fst1        Fst2
Lag 0    1.00000000 1.0000000000  1.00000000
Lag 10   0.55765168 0.3835593702  0.68697362
Lag 50   0.15241264 0.0185614379  0.19003607
Lag 100  0.04202011 0.0006583457  0.01677437
Lag 500 -0.03704368 0.0165238296 -0.07256271

[[9]]
               logL         Fst1         Fst2
Lag 0   1.000000000  1.000000000 1.000000e+00
Lag 10  0.693269197  0.323860774 7.849535e-01
Lag 50  0.294089265  0.006623795 3.455345e-01
Lag 100 0.078271642 -0.027900752 9.295163e-02
Lag 500 0.008810695  0.004483270 1.711118e-06


##check that this is close to the sample size (here 5000). If there is correlation (chain got stuck) the sample size will be much smaller than the input
lapply(chain.list2, FUN=effectiveSize)

[[1]]
     logL      Fst1      Fst2 
 589.9124  550.1477 2705.2911 

[[2]]
     logL      Fst1      Fst2 
 846.0682 2276.3672  749.7850 

[[3]]
     logL      Fst1      Fst2 
 666.0261 2357.2703  587.1826 

[[4]]
     logL      Fst1      Fst2 
 666.2214  561.9699 2089.7175 

[[5]]
    logL     Fst1     Fst2 
1164.926 1974.704 1025.148 

[[6]]
     logL      Fst1      Fst2 
 931.3541 2285.3968  756.7335 

[[7]]
     logL      Fst1      Fst2 
 611.2726 2270.5040  561.0017 

[[8]]
     logL      Fst1      Fst2 
1027.8359 2226.8435  872.7436 

[[9]]
     logL      Fst1      Fst2 
 609.9347 2281.7540  540.8050 
 
 
lapply(chain.list2, FUN=geweke.diag, frac1=0.1, frac2=0.5)  ##The diagnostic reports the z-scores for each parameter. For example, with α = 0.05, the critical values of z are – 1.96 and +1.96. We reject H0 (equality of means => convergence) if z < -1.96 or z > +1.96.

[[1]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 0.9265 -1.0493  1.9070 


[[2]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 0.1572  0.6750 -0.3113 


[[3]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 0.7062  0.6045 -0.7941 


[[4]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 2.1259 -1.2492 -0.1581 


[[5]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 0.2701 -0.8516  0.6706 


[[6]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

     logL      Fst1      Fst2 
-0.106930 -0.005709 -0.049855 


[[7]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 0.9062  0.7918 -0.8626 


[[8]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2 
-1.53764 -0.02684  0.55386 


[[9]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2 
 0.02143 -2.00947 -0.23089  

##Only final Fst1 (9) over threshold. 


lapply(chain.list2, FUN=heidel.diag, eps=0.1, pvalue=0.05) ##another test whether the chains have reached stationarity. 
##Here all passed except a marginal fail for Fst1 for pop 5 (HOD)

[[1]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.799  
Fst1 passed       1         0.870  
Fst2 passed       1         0.224  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.17e+05 2.30e+01 
Fst1 passed     1.24e-02 3.13e-05 
Fst2 passed     4.31e-02 1.79e-05 

[[2]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.850  
Fst1 passed       1         0.121  
Fst2 passed       1         0.790  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.11e+05 1.61e+01 
Fst1 passed     3.40e-02 1.72e-05 
Fst2 passed     1.18e-02 2.48e-05 

[[3]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.556  
Fst1 passed       1         0.882  
Fst2 passed       1         0.899  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.19e+05 2.00e+01 
Fst1 passed     3.73e-02 1.75e-05 
Fst2 passed     1.17e-02 2.75e-05 

[[4]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.730  
Fst1 passed       1         0.732  
Fst2 passed       1         0.964  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.16e+05 1.87e+01 
Fst1 passed     1.07e-02 2.60e-05 
Fst2 passed     3.02e-02 1.64e-05 

[[5]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed        1        0.0847 
Fst1 failed       NA        0.0102 
Fst2 passed        1        0.6773 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.23e+05 1.25e+01 
Fst1 <NA>             NA       NA 
Fst2 passed     2.33e-02 2.91e-05 

[[6]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.0675 
Fst1 passed       1         0.6005 
Fst2 passed       1         0.1643 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.19e+05 1.52e+01 
Fst1 passed     3.61e-02 1.71e-05 
Fst2 passed     1.33e-02 2.46e-05 

[[7]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.906  
Fst1 passed       1         0.819  
Fst2 passed       1         0.797  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.16e+05 2.11e+01 
Fst1 passed     3.64e-02 1.79e-05 
Fst2 passed     1.15e-02 2.75e-05 

[[8]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.0698 
Fst1 passed       1         0.8374 
Fst2 passed       1         0.6585 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.14e+05 1.36e+01 
Fst1 passed     3.57e-02 1.87e-05 
Fst2 passed     1.49e-02 2.50e-05 

[[9]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.239  
Fst1 passed       1         0.531  
Fst2 passed       1         0.362  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.10e+05 2.11e+01 
Fst1 passed     3.44e-02 1.75e-05 
Fst2 passed     1.10e-02 2.79e-05 

```



### Check for Convergence: Host Plant




## Identify Outliers

#### ColHist

```
temp <- list.files(pattern="*fst.txt")
ColHist.Results <- lapply(temp, FUN=read.table)
summary(ColHist.Results)
      Length Class      Mode
 [1,] 5      data.frame list
 [2,] 5      data.frame list
 [3,] 5      data.frame list
 [4,] 5      data.frame list
 [5,] 5      data.frame list
 [6,] 5      data.frame list
 [7,] 5      data.frame list
 [8,] 5      data.frame list
 [9,] 5      data.frame list


##Find the intersection between all the outliers listed: 
pdf("ColHist.JAKKNIFE.outliers.pdf")
ColHist.outliers <- lapply(ColHist.Results, FUN=plot_bayescan, FDR=0.01, add_text=T)
dev.off()

ls <- vector("list", 9)
for (i in 1:9) ls[[i]] <- head(ColHist.outliers[[i]]$outlier,25)
Reduce(intersect, ls)

>integer(0) ##I found no overlap between outliers when single populations are removed. 


##Outliers for FDR 0.05
ColHist.outliers <- lapply(ColHist.Results, FUN=plot_bayescan, FDR=0.05, add_text=T)

ls <- vector("list", 9)
for (i in 1:9) ls[[i]] <- (ColHist.outliers[[i]]$outlier)

[[1]]
 [1]  3470  3474  3776  4992 10847 11041 11042 11050 13357 13359 13829 13830
[13] 17001 19271 21378 27882 28726 28728 28911

[[2]]
[1]  8878 13829 13830 21377 21378 21379 27882

[[3]]
 [1] 10847 13829 13830 17567 19271 21375 21377 21378 21379 24417 27882 28329
[13] 28726 28728

[[4]]
 [1]  2072 11041 11042 11050 12108 13357 13359 13829 17001 21375 21377 21378
[13] 21379 23185 26646

[[5]]
 [1]   462 10847 11041 11042 11050 13357 13359 13829 13830 17001 17567 21375
[13] 21377 21378 21379 28329 28726 28728

[[6]]
 [1]  4992 10847 12957 13829 13830 17435 21375 21377 21378 27882 28726 28728

[[7]]
 [1] 13829 13830 19731 21375 21377 21378 21379 27882 28726 28728 29074

[[8]]
 [1]  3389  3776 10095 12957 13829 13830 26931 27882 28329 28726 28728

[[9]]
[1]  3389 13830 19761 19762 21375 21377 21378 27882

> Reduce(intersect, ls)
integer(0)



##Outliers for FDR 0.01
ColHist.outliers <- lapply(ColHist.Results, FUN=plot_bayescan, FDR=0.01, add_text=T)
ls <- vector("list", 9)
for (i in 1:9) ls[[i]] <- (ColHist.outliers[[i]]$outlier)

[[1]]
[1] 13829 13830 27882

[[2]]
[1] 13830 27882

[[3]]
[1] 13829 13830

[[4]]
[1] 11041 11042 11050 13357 13359 17001 21378

[[5]]
integer(0)

[[6]]
[1] 13829 13830 27882

[[7]]
[1] 13830 28726

[[8]]
[1]  3389 13829

[[9]]
integer(0)

> Reduce(intersect, ls)
integer(0)
```



### Outliers: Host Plant


