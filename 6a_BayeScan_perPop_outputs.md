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
logL -2.859e+05 1.664e+02 2.354e+00      3.834e+00
Fst1  1.922e-02 3.063e-04 4.332e-06      7.600e-06
Fst2  2.881e-02 3.910e-04 5.530e-06      8.397e-06
Fst3  2.470e-02 5.194e-04 7.345e-06      1.002e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.862e+05 -2.860e+05 -2.859e+05 -2.858e+05 -2.856e+05
Fst1  1.863e-02  1.901e-02  1.921e-02  1.941e-02  1.983e-02
Fst2  2.804e-02  2.855e-02  2.880e-02  2.907e-02  2.957e-02
Fst3  2.366e-02  2.435e-02  2.470e-02  2.505e-02  2.571e-02


[[2]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.874e+05 2.230e+02 3.154e+00      7.105e+00
Fst1  3.747e-02 3.808e-04 5.386e-06      6.764e-06
Fst2  5.470e-03 2.094e-04 2.961e-06      6.981e-06
Fst3  2.937e-02 4.191e-04 5.927e-06      7.168e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.879e+05 -2.876e+05 -2.874e+05 -2.873e+05 -2.870e+05
Fst1  3.673e-02  3.720e-02  3.747e-02  3.772e-02  3.824e-02
Fst2  5.069e-03  5.327e-03  5.462e-03  5.607e-03  5.895e-03
Fst3  2.854e-02  2.907e-02  2.937e-02  2.965e-02  3.018e-02


[[3]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.773e+05 1.782e+02 2.520e+00      4.540e+00
Fst1  2.415e-02 3.752e-04 5.307e-06      9.831e-06
Fst2  1.973e-02 3.225e-04 4.561e-06      8.874e-06
Fst3  4.746e-02 8.910e-04 1.260e-05      1.594e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.777e+05 -2.775e+05 -2.773e+05 -2.772e+05 -2.770e+05
Fst1  2.344e-02  2.389e-02  2.414e-02  2.440e-02  2.490e-02
Fst2  1.912e-02  1.951e-02  1.973e-02  1.995e-02  2.036e-02
Fst3  4.573e-02  4.686e-02  4.746e-02  4.803e-02  4.925e-02


[[4]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.793e+05 1.781e+02 2.518e+00      4.158e+00
Fst1  2.904e-02 4.014e-04 5.677e-06      9.118e-06
Fst2  1.806e-02 3.205e-04 4.533e-06      8.615e-06
Fst3  4.213e-02 7.911e-04 1.119e-05      1.282e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.796e+05 -2.794e+05 -2.793e+05 -2.791e+05 -2.789e+05
Fst1  2.826e-02  2.877e-02  2.905e-02  2.932e-02  2.983e-02
Fst2  1.745e-02  1.784e-02  1.805e-02  1.827e-02  1.869e-02
Fst3  4.058e-02  4.159e-02  4.213e-02  4.267e-02  4.368e-02


[[5]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.934e+05 1.716e+02 2.426e+00      4.666e+00
Fst1  3.315e-02 4.120e-04 5.826e-06      8.756e-06
Fst2  2.419e-02 3.562e-04 5.039e-06      7.836e-06
Fst3  3.120e-02 5.333e-04 7.543e-06      9.577e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.938e+05 -2.936e+05 -2.934e+05 -2.933e+05 -2.931e+05
Fst1  3.236e-02  3.287e-02  3.314e-02  3.343e-02  3.397e-02
Fst2  2.350e-02  2.394e-02  2.419e-02  2.443e-02  2.490e-02
Fst3  3.018e-02  3.084e-02  3.119e-02  3.155e-02  3.227e-02


[[6]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.799e+05 2.169e+02 3.068e+00      7.106e+00
Fst1  3.795e-02 3.976e-04 5.623e-06      7.960e-06
Fst2  8.657e-03 2.402e-04 3.398e-06      8.319e-06
Fst3  3.661e-02 6.297e-04 8.906e-06      1.115e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.804e+05 -2.801e+05 -2.799e+05 -2.798e+05 -2.795e+05
Fst1  3.716e-02  3.768e-02  3.795e-02  3.821e-02  3.871e-02
Fst2  8.170e-03  8.503e-03  8.659e-03  8.812e-03  9.144e-03
Fst3  3.540e-02  3.620e-02  3.661e-02  3.705e-02  3.782e-02


[[7]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.815e+05 2.014e+02 2.849e+00      8.780e+00
Fst1  1.653e-02 3.214e-04 4.545e-06      9.209e-06
Fst2  2.337e-02 3.166e-04 4.478e-06      7.329e-06
Fst3  2.768e-02 5.777e-04 8.171e-06      1.299e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.819e+05 -2.817e+05 -2.815e+05 -2.814e+05 -2.811e+05
Fst1  1.589e-02  1.631e-02  1.653e-02  1.674e-02  1.717e-02
Fst2  2.275e-02  2.317e-02  2.337e-02  2.358e-02  2.401e-02
Fst3  2.659e-02  2.727e-02  2.767e-02  2.807e-02  2.880e-02


[[8]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.884e+05 1.946e+02 2.752e+00      5.770e+00
Fst1  3.810e-02 3.964e-04 5.607e-06      7.328e-06
Fst2  8.146e-03 2.195e-04 3.105e-06      6.522e-06
Fst3  2.145e-02 3.754e-04 5.309e-06      6.616e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.888e+05 -2.885e+05 -2.884e+05 -2.883e+05 -2.880e+05
Fst1  3.732e-02  3.783e-02  3.809e-02  3.836e-02  3.888e-02
Fst2  7.722e-03  7.998e-03  8.143e-03  8.290e-03  8.593e-03
Fst3  2.071e-02  2.119e-02  2.145e-02  2.170e-02  2.218e-02


[[9]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.868e+05 2.213e+02 3.129e+00      9.993e+00
Fst1  1.160e-02 2.792e-04 3.950e-06      8.095e-06
Fst2  2.456e-02 3.011e-04 4.259e-06      6.581e-06
Fst3  2.449e-02 4.410e-04 6.238e-06      1.040e-05

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.872e+05 -2.869e+05 -2.868e+05 -2.866e+05 -2.863e+05
Fst1  1.105e-02  1.142e-02  1.160e-02  1.179e-02  1.214e-02
Fst2  2.400e-02  2.436e-02  2.456e-02  2.476e-02  2.515e-02
Fst3  2.363e-02  2.419e-02  2.449e-02  2.478e-02  2.536e-02


lapply(chain.list2, FUN=autocorr.diag)
[[1]]
               logL         Fst1         Fst2        Fst3
Lag 0    1.00000000  1.000000000  1.000000000 1.000000000
Lag 10   0.31605601  0.512211938  0.390207822 0.274177105
Lag 50   0.05836835  0.026117952 -0.012521900 0.009746617
Lag 100  0.03700190  0.003253774 -0.002463569 0.024726129
Lag 500 -0.01127122 -0.003018379  0.001582132 0.012052388

[[2]]
               logL         Fst1         Fst2        Fst3
Lag 0    1.00000000  1.000000000  1.000000000 1.000000000
Lag 10   0.57866750  0.223775809  0.685965526 0.187695489
Lag 50   0.13799996 -0.014187977  0.164715551 0.004916128
Lag 100  0.04428856 -0.001732928  0.036409471 0.006610613
Lag 500 -0.01644444  0.018965067 -0.005625825 0.005281807

[[3]]
               logL         Fst1         Fst2         Fst3
Lag 0   1.000000000  1.000000000  1.000000000  1.000000000
Lag 10  0.352941303  0.491055093  0.523732348  0.230712862
Lag 50  0.069902490  0.078678547  0.081301725 -0.005020857
Lag 100 0.054938657  0.004264983  0.009090097 -0.014707424
Lag 500 0.007252977 -0.003940785 -0.008083903  0.005329918

[[4]]
               logL         Fst1         Fst2          Fst3
Lag 0    1.00000000  1.000000000  1.000000000  1.000000e+00
Lag 10   0.37573550  0.406059338  0.566264261  1.350272e-01
Lag 50   0.04668021  0.011818960  0.084610617  4.138761e-05
Lag 100  0.02043929 -0.004137281  0.005790473 -7.622212e-03
Lag 500 -0.01390922  0.004844593 -0.005579706 -5.887737e-03

[[5]]
              logL        Fst1        Fst2          Fst3
Lag 0   1.00000000 1.000000000 1.000000000  1.0000000000
Lag 10  0.33195708 0.346606257 0.397519034  0.2342836282
Lag 50  0.02237272 0.019616070 0.013688917 -0.0005324664
Lag 100 0.02264113 0.008558987 0.005790900 -0.0284821276
Lag 500 0.01215147 0.016779184 0.008311228 -0.0008816958

[[6]]
              logL         Fst1       Fst2        Fst3
Lag 0   1.00000000  1.000000000 1.00000000 1.000000000
Lag 10  0.55792144  0.286950913 0.68289787 0.170711055
Lag 50  0.18009159  0.012972603 0.17703809 0.008963558
Lag 100 0.04604976 -0.010513695 0.02473424 0.005936521
Lag 500 0.04498483  0.007505977 0.04288506 0.015032536

[[7]]
               logL        Fst1         Fst2          Fst3
Lag 0    1.00000000  1.00000000  1.000000000  1.000000e+00
Lag 10   0.51641309  0.57478001  0.431546652  3.192794e-01
Lag 50   0.20761302  0.10799198  0.005081329  6.192063e-02
Lag 100  0.14769020 -0.00616599 -0.010589643 -1.157382e-03
Lag 500 -0.06052672  0.01100756 -0.029599694  3.335875e-05

[[8]]
               logL        Fst1        Fst2         Fst3
Lag 0    1.00000000  1.00000000 1.000000000  1.000000000
Lag 10   0.46337988  0.26138022 0.577641202  0.216509841
Lag 50   0.12254040  0.03024599 0.131548835 -0.012274397
Lag 100  0.05030719  0.03031830 0.012341078  0.017094097
Lag 500 -0.01105059 -0.01005034 0.003819018  0.002042391

[[9]]
                logL       Fst1        Fst2        Fst3
Lag 0    1.000000000 1.00000000  1.00000000 1.000000000
Lag 10   0.576648087 0.56638415  0.37460464 0.399359918
Lag 50   0.267755720 0.12155348  0.02717061 0.050373392
Lag 100  0.187472572 0.05065766  0.01867783 0.001222277
Lag 500 -0.006747368 0.00402576 -0.03779770 0.004190425


##check that this is close to the sample size (here 5000). If there is correlation (chain got stuck) the sample size will be much smaller than the input
lapply(chain.list2, FUN=effectiveSize)

[[1]]
    logL     Fst1     Fst2     Fst3 
1884.174 1623.978 2167.991 2685.579 

[[2]]
     logL      Fst1      Fst2      Fst3 
 985.0034 3170.1626  899.4000 3418.2986 

[[3]]
    logL     Fst1     Fst2     Fst3 
1539.895 1456.671 1320.863 3124.122 

[[4]]
    logL     Fst1     Fst2     Fst3 
1833.344 1937.451 1384.065 3808.837 

[[5]]
    logL     Fst1     Fst2     Fst3 
1352.026 2213.317 2066.830 3100.625 

[[6]]
     logL      Fst1      Fst2      Fst3 
 931.6574 2495.2528  833.8881 3191.4566 

[[7]]
     logL      Fst1      Fst2      Fst3 
 526.1571 1217.7592 1866.2625 1977.4443 

[[8]]
    logL     Fst1     Fst2     Fst3 
1137.006 2926.652 1132.959 3218.949 

[[9]]
     logL      Fst1      Fst2      Fst3 
 490.1916 1189.9092 2093.7158 1796.5289 
 
 
lapply(chain.list2, FUN=geweke.diag, frac1=0.1, frac2=0.5)  ##The diagnostic reports the z-scores for each parameter. For example, with α = 0.05, the critical values of z are – 1.96 and +1.96. We reject H0 (equality of means => convergence) if z < -1.96 or z > +1.96.

[[1]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
-0.9164 -0.4679  1.5354  1.0283 


[[2]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
 0.7848  0.3629  0.7306 -1.0246 


[[3]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
-0.7856  0.6985  0.3501 -0.1445 


[[4]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
 0.2345 -0.6147 -0.6120 -1.1190 


[[5]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
 2.4428  0.2888 -1.5839 -0.6879 


[[6]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2     Fst3 
-1.21444 -1.14535  1.96585 -0.04608 


[[7]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
-2.2243 -1.7227  0.8707 -0.9165 


[[8]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2    Fst3 
-1.6067 -0.9674  0.2742  1.7189 


[[9]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2     Fst3 
 0.71383  0.54860 -0.15253 -0.03566 

##Two figures above/below critical values. But never more than one per dataset. 


lapply(chain.list2, FUN=heidel.diag, eps=0.1, pvalue=0.05) ##another test whether the chains have reached stationarity. 
##Here all passed except the final LogL (NoWIS) 

[[1]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1001      0.0616 
Fst1 passed          1      0.9226 
Fst2 passed          1      0.3779 
Fst3 passed       1501      0.0541 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.86e+05 8.54e+00 
Fst1 passed     1.92e-02 1.49e-05 
Fst2 passed     2.88e-02 1.65e-05 
Fst3 passed     2.47e-02 2.39e-05 

[[2]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.3982 
Fst1 passed       1         0.0632 
Fst2 passed       1         0.8001 
Fst3 passed       1         0.4543 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.87e+05 1.39e+01 
Fst1 passed     3.75e-02 1.33e-05 
Fst2 passed     5.47e-03 1.37e-05 
Fst3 passed     2.94e-02 1.40e-05 

[[3]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.512  
Fst1 passed       1         0.193  
Fst2 passed       1         0.562  
Fst3 passed       1         0.676  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.77e+05 8.90e+00 
Fst1 passed     2.42e-02 1.93e-05 
Fst2 passed     1.97e-02 1.74e-05 
Fst3 passed     4.75e-02 3.12e-05 

[[4]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.1531 
Fst1 passed       1         0.0605 
Fst2 passed       1         0.8506 
Fst3 passed       1         0.2252 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.79e+05 8.15e+00 
Fst1 passed     2.90e-02 1.79e-05 
Fst2 passed     1.81e-02 1.69e-05 
Fst3 passed     4.21e-02 2.51e-05 

[[5]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.053  
Fst1 passed       1         0.582  
Fst2 passed       1         0.287  
Fst3 passed       1         0.186  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.93e+05 9.14e+00 
Fst1 passed     3.32e-02 1.72e-05 
Fst2 passed     2.42e-02 1.54e-05 
Fst3 passed     3.12e-02 1.88e-05 

[[6]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.449  
Fst1 passed       1         0.556  
Fst2 passed       1         0.111  
Fst3 passed       1         0.914  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.80e+05 1.39e+01 
Fst1 passed     3.79e-02 1.56e-05 
Fst2 passed     8.66e-03 1.63e-05 
Fst3 passed     3.66e-02 2.18e-05 

[[7]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.0534 
Fst1 passed       1         0.3128 
Fst2 passed       1         0.8012 
Fst3 passed       1         0.4446 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.82e+05 1.72e+01 
Fst1 passed     1.65e-02 1.80e-05 
Fst2 passed     2.34e-02 1.44e-05 
Fst3 passed     2.77e-02 2.55e-05 

[[8]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.614  
Fst1 passed       1         0.492  
Fst2 passed       1         0.553  
Fst3 passed       1         0.411  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.88e+05 1.13e+01 
Fst1 passed     3.81e-02 1.44e-05 
Fst2 passed     8.15e-03 1.28e-05 
Fst3 passed     2.14e-02 1.30e-05 

[[9]]
                                   
     Stationarity start     p-value
     test         iteration        
logL failed       NA        0.00002
Fst1 passed        1        0.33495
Fst2 passed        1        0.85274
Fst3 passed        1        0.71359
                               
     Halfwidth Mean   Halfwidth
     test                      
logL <NA>          NA       NA 
Fst1 passed    0.0116 1.59e-05 
Fst2 passed    0.0246 1.29e-05 
Fst3 passed    0.0245 2.04e-05 

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
ColHist.outliers <- lapply(ColHist.Results, FUN=plot_bayescan, FDR=0.01, add_text=T)

ls <- vector("list", 9)
for (i in 1:9) ls[[i]] <- head(ColHist.outliers[[i]]$outlier,25)
Reduce(intersect, ls)

NULL

##I found no overlap between outliers when single populations are removed. 


##Outliers for FDR 0.05
ColHist.outliers <- lapply(ColHist.Results, FUN=plot_bayescan, FDR=0.05, add_text=T)

[[1]]
[[1]]$outliers
 [1]  1124  1240  2392  2394  2664  2670  3389  3776  3913  4992  6442  6444
[13]  6618  7358  8358  8878  9532  9549 10095 10225 10847 11041 11042 11050
[25] 12957 13357 13359 13394 13537 13829 13830 15644 15651 17001 17435 17567
[37] 17644 18086 18088 18089 19271 19715 19731 21087 21375 21377 21378 21379
[49] 22403 22412 24343 24417 24468 26117 27808 27812 27882 28329 28725 28726
[61] 28728 28911 30845

[[1]]$nb_outliers
[1] 63


[[2]]
[[2]]$outliers
 [1]   462  2755  2756  2945  3116  3389  3776  4992  8357  8358  8674  9231
[13]  9238  9558 10095 10847 11041 11042 11050 12957 13829 13830 17001 17435
[25] 17567 18305 18309 18899 20214 21375 21377 21378 21379 22403 22412 23208
[37] 23210 23851 24174 24180 24417 26646 27808 27882 28329 28726 28728 30845

[[2]]$nb_outliers
[1] 48


[[3]]
[[3]]$outliers
 [1]  1016  1240  2664  2670  3389  3771  3773  3776  3913  4992  5073  5077
[13]  5078  6437  6442  6444  8358  8388  9231  9238  9532 10095 10287 10288
[25] 10289 10847 11041 11042 11050 11853 11898 12241 12957 13125 13351 13357
[37] 13359 13829 13830 15585 15644 15651 17001 17567 17644 18899 19271 19696
[49] 19698 19703 19715 19731 20214 20226 20233 20236 21375 21377 21378 21379
[61] 22279 22361 22403 22412 22815 22818 24343 24417 24468 25035 25398 27808
[73] 27812 27882 28329 28725 28726 28728 29130

[[3]]$nb_outliers
[1] 79


[[4]]
[[4]]$outliers
 [1]  2482  2664  2670  3389  3776  3913  6442  6444  8358  8878 10095 10847
[13] 11041 11042 11050 12957 13357 13359 13829 13830 15093 15094 15095 15097
[25] 17001 17567 17644 18043 19271 19731 21158 21375 21377 21378 21379 21498
[37] 21716 22403 22412 24417 24482 25398 27294 27295 27299 27312 27882 28112
[49] 28329 28645 28726 28728 28911 28918 30064

[[4]]$nb_outliers
[1] 55


[[5]]
[[5]]$outliers
 [1]   462  1024  2072  3389  5362  9238 10399 10676 10847 11041 11042 11050
[13] 11642 11651 11652 12957 13357 13359 13625 13829 13830 17001 17178 17567
[25] 18436 18439 18687 18688 18698 18899 19731 21375 21377 21378 21379 23761
[37] 23951 26646 27882 28329 28726 28728 31120 31264 31267

[[5]]$nb_outliers
[1] 45


[[6]]
[[6]]$outliers
 [1]  4992 10847 11041 11042 11050 12108 12957 13357 13359 13829 13830 16625
[13] 17001 17435 17567 18086 18088 18089 18725 21375 21377 21378 21379 26646
[25] 27882 27964 28329 28561 28563 28564 28565 28726 28728 28768 28841

[[6]]$nb_outliers
[1] 35


[[7]]
[[7]]$outliers
  [1]   462  1016  1024  1025  1124  1240  2664  2670  3389  3621  3622  3776
 [13]  3913  4775  4776  4992  5073  5444  5445  6442  6444  7167  7168  7169
 [25]  7358  8175  8357  8358  8388  8878  9231  9238  9532  9684 10095 10463
 [37] 10847 11041 11042 11050 11853 12241 12948 12957 12963 13357 13359 13537
 [49] 13829 13830 14258 15094 15644 15651 16642 17001 17435 17567 17644 18043
 [61] 18046 18048 18086 18088 18089 18220 18627 19271 19387 19696 19698 19703
 [73] 19715 19731 20233 20518 20519 20521 21375 21377 21378 21379 21648 21716
 [85] 22361 22403 22404 22412 23598 23599 24174 24343 24417 24468 24480 24482
 [97] 24484 25035 25398 26117 26988 27086 27665 27673 27808 27812 27882 27991
[109] 28329 28725 28726 28728 28768 28841 28911 29130 30845 31175 31200

[[7]]$nb_outliers
[1] 119


[[8]]
[[8]]$outliers
 [1]  1031  3389  3776 10095 10847 11050 11902 12957 13357 13359 13829 13830
[13] 17435 17764 17774 18899 19210 21375 21377 21378 21379 23182 26931 27882
[25] 28329 28726 28728

[[8]]$nb_outliers
[1] 27


[[9]]
[[9]]$outliers
  [1]   455   462  1016  1024  1025  1124  1240  2392  2394  2482  2664  2670
 [13]  3213  3389  3436  3621  3622  3707  3776  3913  4004  4121  4992  5073
 [25]  5077  5078  5083  5085  5088  5134  6437  6442  6444  6636  7167  7358
 [37]  8357  8358  8388  8878  9009  9087  9231  9238  9532 10095 10463 10847
 [49] 10920 11041 11042 11050 11754 11853 11898 12241 12948 12957 12963 13357
 [61] 13359 13475 13476 13537 13829 13830 14258 14375 15097 15585 15644 15651
 [73] 16642 17001 17009 17011 17435 17567 17644 18043 18046 18048 18085 18086
 [85] 18088 18089 18627 18899 19271 19696 19698 19703 19715 19731 19786 20226
 [97] 20233 20236 20734 20735 21375 21377 21378 21379 21648 21716 22361 22403
[109] 22404 22412 23598 23599 23786 24258 24259 24260 24262 24343 24417 24468
[121] 24480 24482 24484 25035 25120 25398 26117 26988 27086 27665 27673 27808
[133] 27812 27882 27991 28329 28725 28726 28728 28768 28841 28842 29130 29601
[145] 29985 30845 31175 31177 31200

[[9]]$nb_outliers
[1] 149


##Outliers for FDR 0.01
ColHist.outliers <- lapply(ColHist.Results, FUN=plot_bayescan, FDR=0.01, add_text=T)

[[1]]
[[1]]$outliers
 [1]  2392  2394  3389  3776  6444 10225 10847 11041 11042 11050 12957 13357
[13] 13359 13394 13829 13830 17001 17567 19271 19731 21375 21378 22412 24343
[25] 24417 27882 28329 28726 28728

[[1]]$nb_outliers
[1] 29


[[2]]
[[2]]$outliers
 [1]  2755  2756  9558 10095 11050 13829 13830 17001 20214 22403 22412 27882
[13] 28329 28726 28728

[[2]]$nb_outliers
[1] 15


[[3]]
[[3]]$outliers
 [1]  3776  5073  6437  6442  6444 10847 11041 11042 11050 12241 12957 13125
[13] 13357 13359 13829 13830 15644 15651 17001 17567 17644 19696 19698 19703
[25] 19715 19731 20233 21378 22279 22412 24417 24468 27882 28329 28725 28726
[37] 28728

[[3]]$nb_outliers
[1] 37


[[4]]
[[4]]$outliers
 [1]  2664  2670  3389  3776  6444  8878 10847 12957 13357 13359 13829 13830
[13] 21378 22403 22412 24417 27294 27295 27299 27312 27882 28329 28645 28726
[25] 28728

[[4]]$nb_outliers
[1] 25


[[5]]
[[5]]$outliers
 [1]  5362 10676 11041 11042 11050 11652 13357 13625 13829 13830 17001 18698
[13] 21375 21377 21378 21379 28726

[[5]]$nb_outliers
[1] 17


[[6]]
[[6]]$outliers
 [1] 11041 11042 11050 13829 13830 18725 27882 28329 28561 28563 28564 28565
[13] 28726 28768 28841

[[6]]$nb_outliers
[1] 15


[[7]]
[[7]]$outliers
 [1]  1016  2664  2670  3389  3776  3913  4775  4776  5444  5445  6442  6444
[13]  8175  8358  8878  9231  9238  9532 10095 10847 11041 11042 11050 12241
[25] 12957 13357 13359 13829 13830 15094 15644 15651 17001 17435 17567 18220
[37] 19271 19387 19731 20233 20519 20521 22403 22412 24417 24468 25035 26117
[49] 27808 27882 28329 28726 28728 29130 31200

[[7]]$nb_outliers
[1] 55


[[8]]
[[8]]$outliers
[1]  3389 13357 13359 13829 13830 17764 21375 21378

[[8]]$nb_outliers
[1] 8


[[9]]
[[9]]$outliers
 [1]   455   462  1016  1024  1124  2664  2670  3389  3776  3913  4992  5085
[13]  6442  6444  6636  8358  8388  8878  9532 10095 10847 11041 11042 11050
[25] 12241 12957 13357 13359 13475 13476 13829 13830 14258 15644 15651 16642
[37] 17001 17435 17567 17644 18043 18046 18048 18086 18088 18089 19271 19696
[49] 19698 19703 19715 19731 20233 21648 22361 22403 22404 22412 23786 24343
[61] 24417 24468 25035 25398 26117 26988 27665 27673 27808 27812 27882 28329
[73] 28725 28726 28728 28768 28841 28842 29130 30845

[[9]]$nb_outliers
[1] 80

```



### Outliers: Host Plant


