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


#### Convergence in HostPlant runs
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
logL -2.168e+05 2.290e+02 3.239e+00      6.919e+00
Fst1  1.425e-02 3.486e-04 4.930e-06      1.144e-05
Fst2  3.224e-02 4.222e-04 5.971e-06      9.350e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.172e+05 -2.169e+05 -2.168e+05 -2.166e+05 -2.164e+05
Fst1  1.358e-02  1.402e-02  1.425e-02  1.448e-02  1.496e-02
Fst2  3.143e-02  3.195e-02  3.223e-02  3.252e-02  3.306e-02


[[2]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.008e+05 2.643e+02 3.739e+00      1.095e+01
Fst1  5.762e-03 2.477e-04 3.504e-06      1.122e-05
Fst2  2.194e-02 3.036e-04 4.295e-06      7.621e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.013e+05 -2.010e+05 -2.008e+05 -2.007e+05 -2.003e+05
Fst1  5.266e-03  5.599e-03  5.766e-03  5.927e-03  6.243e-03
Fst2  2.133e-02  2.173e-02  2.194e-02  2.214e-02  2.252e-02


[[3]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.094e+05 2.928e+02 4.141e+00      1.286e+01
Fst1  7.119e-03 2.606e-04 3.685e-06      1.233e-05
Fst2  2.743e-02 3.542e-04 5.009e-06      8.022e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.100e+05 -2.096e+05 -2.094e+05 -2.092e+05 -2.088e+05
Fst1  6.603e-03  6.947e-03  7.121e-03  7.293e-03  7.635e-03
Fst2  2.673e-02  2.719e-02  2.743e-02  2.766e-02  2.811e-02


[[4]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.156e+05 2.478e+02 3.505e+00      1.020e+01
Fst1  1.071e-02 2.983e-04 4.218e-06      1.171e-05
Fst2  3.026e-02 3.911e-04 5.532e-06      8.740e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.161e+05 -2.158e+05 -2.156e+05 -2.155e+05 -2.152e+05
Fst1  1.014e-02  1.051e-02  1.071e-02  1.091e-02  1.131e-02
Fst2  2.950e-02  3.000e-02  3.027e-02  3.053e-02  3.101e-02


[[5]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.066e+05 3.785e+02 5.353e+00      2.129e+01
Fst1  6.740e-03 3.107e-04 4.394e-06      1.788e-05
Fst2  3.852e-02 4.296e-04 6.076e-06      8.032e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.073e+05 -2.068e+05 -2.066e+05 -2.063e+05 -2.057e+05
Fst1  6.080e-03  6.544e-03  6.753e-03  6.949e-03  7.314e-03
Fst2  3.767e-02  3.823e-02  3.852e-02  3.881e-02  3.937e-02


[[6]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.093e+05 2.554e+02 3.612e+00      1.005e+01
Fst1  7.862e-03 2.659e-04 3.761e-06      1.171e-05
Fst2  2.470e-02 3.430e-04 4.851e-06      8.245e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.098e+05 -2.095e+05 -2.093e+05 -2.091e+05 -2.088e+05
Fst1  7.341e-03  7.686e-03  7.863e-03  8.043e-03  8.381e-03
Fst2  2.402e-02  2.447e-02  2.470e-02  2.493e-02  2.538e-02


[[7]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.060e+05 2.921e+02 4.131e+00      1.357e+01
Fst1  6.903e-03 2.592e-04 3.665e-06      1.326e-05
Fst2  2.586e-02 3.433e-04 4.856e-06      7.616e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.065e+05 -2.062e+05 -2.060e+05 -2.058e+05 -2.054e+05
Fst1  6.393e-03  6.726e-03  6.900e-03  7.076e-03  7.412e-03
Fst2  2.519e-02  2.563e-02  2.587e-02  2.610e-02  2.651e-02


[[8]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -2.032e+05 2.414e+02 3.415e+00      8.522e+00
Fst1  7.210e-03 2.537e-04 3.588e-06      9.632e-06
Fst2  2.292e-02 3.176e-04 4.491e-06      7.183e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -2.037e+05 -2.034e+05 -2.032e+05 -2.031e+05 -2.028e+05
Fst1  6.701e-03  7.036e-03  7.212e-03  7.383e-03  7.698e-03
Fst2  2.230e-02  2.271e-02  2.292e-02  2.314e-02  2.355e-02


[[9]]

Iterations = 1:49981
Thinning interval = 10 
Number of chains = 1 
Sample size per chain = 4999 

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

           Mean        SD  Naive SE Time-series SE
logL -1.986e+05 3.067e+02 4.338e+00      1.464e+01
Fst1  6.674e-03 2.607e-04 3.688e-06      1.294e-05
Fst2  2.385e-02 3.519e-04 4.977e-06      7.272e-06

2. Quantiles for each variable:

           2.5%        25%        50%        75%      97.5%
logL -1.992e+05 -1.988e+05 -1.986e+05 -1.984e+05 -1.980e+05
Fst1  6.160e-03  6.503e-03  6.676e-03  6.847e-03  7.185e-03
Fst2  2.318e-02  2.362e-02  2.386e-02  2.409e-02  2.455e-02




lapply(chain.list2, FUN=autocorr.diag) ## check correlation between the chains. Make sure the chains didn't get stuck

[[1]]
              logL        Fst1        Fst2
Lag 0   1.00000000  1.00000000 1.000000000
Lag 10  0.56800955  0.67590491 0.394071573
Lag 50  0.12720325  0.14820342 0.014677900
Lag 100 0.02159118  0.02354217 0.012449969
Lag 500 0.01773224 -0.01976560 0.004944996

[[2]]
              logL        Fst1       Fst2
Lag 0    1.0000000  1.00000000 1.00000000
Lag 10   0.6936183  0.79870670 0.37481666
Lag 50   0.3177420  0.39017426 0.07753509
Lag 100  0.1067440  0.12036158 0.02844436
Lag 500 -0.0460013 -0.02283632 0.01330113

[[3]]
              logL       Fst1        Fst2
Lag 0   1.00000000 1.00000000 1.000000000
Lag 10  0.74707053 0.81280349 0.342853161
Lag 50  0.35019147 0.40601093 0.049979821
Lag 100 0.15226780 0.17802480 0.023412738
Lag 500 0.04120643 0.03539824 0.007047709

[[4]]
              logL        Fst1         Fst2
Lag 0   1.00000000 1.000000000  1.000000000
Lag 10  0.64799350 0.742070542  0.352212163
Lag 50  0.28462854 0.298925328  0.020806084
Lag 100 0.15465155 0.131561137  0.004264198
Lag 500 0.05216104 0.008475711 -0.017339171

[[5]]
             logL        Fst1        Fst2
Lag 0   1.0000000  1.00000000 1.000000000
Lag 10  0.8462657  0.87507095 0.240413108
Lag 50  0.5193292  0.53451868 0.007650818
Lag 100 0.2817936  0.28072436 0.016306999
Lag 500 0.0019667 -0.01011113 0.003277941

[[6]]
              logL       Fst1         Fst2
Lag 0   1.00000000 1.00000000  1.000000000
Lag 10  0.67389573 0.77823832  0.376241083
Lag 50  0.29606666 0.33904165  0.076996034
Lag 100 0.10348853 0.09034977  0.030847739
Lag 500 0.03234373 0.03458971 -0.007191973

[[7]]
              logL        Fst1          Fst2
Lag 0   1.00000000 1.000000000  1.0000000000
Lag 10  0.75146247 0.831401698  0.3050945606
Lag 50  0.38828864 0.459328537  0.0321693396
Lag 100 0.19187169 0.234681480  0.0127852193
Lag 500 0.01176107 0.003212293 -0.0005214924

[[8]]
              logL          Fst1       Fst2
Lag 0   1.00000000  1.0000000000 1.00000000
Lag 10  0.62698911  0.7358283663 0.35166875
Lag 50  0.20982609  0.2535272640 0.01279134
Lag 100 0.04147760  0.0225803018 0.01705611
Lag 500 0.02464307 -0.0006297397 0.01551634

[[9]]
              logL        Fst1       Fst2
Lag 0   1.00000000 1.000000000 1.00000000
Lag 10  0.76887794 0.833592962 0.33341760
Lag 50  0.40645595 0.433200379 0.03637108
Lag 100 0.20727402 0.187595237 0.03869517
Lag 500 0.01360352 0.001494199 0.00856358



lapply(chain.list2, FUN=effectiveSize) ##check that this is close to the sample size (here 5000). If there is correlation (chain got stuck) the sample size will be much smaller than the input

[[1]]
     logL      Fst1      Fst2 
1095.3806  928.5767 2038.6205 

[[2]]
     logL      Fst1      Fst2 
 583.1613  487.2996 1587.5580 

[[3]]
     logL      Fst1      Fst2 
 518.8199  446.4715 1949.1681 

[[4]]
     logL      Fst1      Fst2 
 589.7287  648.2361 2002.4008 

[[5]]
     logL      Fst1      Fst2 
 316.0541  301.8809 2861.3097 

[[6]]
     logL      Fst1      Fst2 
 646.0583  515.5124 1730.7753 

[[7]]
     logL      Fst1      Fst2 
 463.0152  382.1190 2032.0718 

[[8]]
     logL      Fst1      Fst2 
 802.6942  693.8763 1954.3704 

[[9]]
     logL      Fst1      Fst2 
 439.1987  406.0481 2341.0720 


lapply(chain.list2, FUN=geweke.diag, frac1=0.1, frac2=0.5)  ##The diagnostic reports the z-scores for each parameter. For example, with α = 0.05, the critical values of z are – 1.96 and +1.96. We reject H0 (equality of means => convergence) if z < -1.96 or z > +1.96.

[[1]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

  logL   Fst1   Fst2 
 2.237 -2.068 -0.055 


[[2]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
-1.7218  1.3774 -0.7938 


[[3]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2 
 0.14037 -0.01837 -0.03359 


[[4]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2 
-0.44444  0.04872 -0.16142 


[[5]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
 0.1287 -0.3102  1.7096 


[[6]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2 
-1.03023  0.99671 -0.06885 


[[7]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

    logL     Fst1     Fst2 
-0.40669  0.42772 -0.02636 


[[8]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
-2.0594  1.3487 -0.7512 


[[9]]

Fraction in 1st window = 0.1
Fraction in 2nd window = 0.5 

   logL    Fst1    Fst2 
-0.9685  0.2358  0.5333 


lapply(chain.list2, FUN=heidel.diag, eps=0.1, pvalue=0.05) ##another test whether the chains have reached stationarity. 

[[1]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed         1       0.0543 
Fst1 passed       501       0.2424 
Fst2 passed         1       0.3285 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.17e+05 1.36e+01 
Fst1 passed     1.43e-02 2.28e-05 
Fst2 passed     3.22e-02 1.83e-05 

[[2]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.58   
Fst1 passed       1         0.59   
Fst2 passed       1         0.93   
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.01e+05 2.15e+01 
Fst1 passed     5.76e-03 2.20e-05 
Fst2 passed     2.19e-02 1.49e-05 

[[3]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.530  
Fst1 passed       1         0.851  
Fst2 passed       1         0.374  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.09e+05 2.52e+01 
Fst1 passed     7.12e-03 2.42e-05 
Fst2 passed     2.74e-02 1.57e-05 

[[4]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.298  
Fst1 passed       1         0.824  
Fst2 passed       1         0.762  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.16e+05 2.00e+01 
Fst1 passed     1.07e-02 2.30e-05 
Fst2 passed     3.03e-02 1.71e-05 

[[5]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed          1      0.6609 
Fst1 passed          1      0.4933 
Fst2 passed       1001      0.0702 
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.07e+05 4.17e+01 
Fst1 passed     6.74e-03 3.50e-05 
Fst2 passed     3.85e-02 1.76e-05 

[[6]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.210  
Fst1 passed       1         0.269  
Fst2 passed       1         0.704  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.09e+05 1.97e+01 
Fst1 passed     7.86e-03 2.30e-05 
Fst2 passed     2.47e-02 1.62e-05 

[[7]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.253  
Fst1 passed       1         0.303  
Fst2 passed       1         0.756  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.06e+05 2.66e+01 
Fst1 passed     6.90e-03 2.60e-05 
Fst2 passed     2.59e-02 1.49e-05 

[[8]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.282  
Fst1 passed       1         0.724  
Fst2 passed       1         0.937  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -2.03e+05 1.67e+01 
Fst1 passed     7.21e-03 1.89e-05 
Fst2 passed     2.29e-02 1.41e-05 

[[9]]
                                   
     Stationarity start     p-value
     test         iteration        
logL passed       1         0.806  
Fst1 passed       1         0.705  
Fst2 passed       1         0.854  
                                  
     Halfwidth Mean      Halfwidth
     test                         
logL passed    -1.99e+05 2.87e+01 
Fst1 passed     6.67e-03 2.54e-05 
Fst2 passed     2.39e-02 1.43e-05 

```


#### Check for Convergence: Col Hist

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

```
temp <- list.files(pattern="*fst.txt")
HostPlant.Results <- lapply(temp, FUN=read.table, header=T)
summary(HostPlant.Results)
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
##First strict FDR: 0.01
pdf("HostPlant.JAKKNIFE.outliers.pdf")
HostPlant.outliers <- lapply(HostPlant.Results, FUN=plot_bayescan, FDR=0.01, add_text=T)
dev.off()

ls <- vector("list", 9)
for (i in 1:9) ls[[i]] <- (HostPlant.outliers[[i]]$outlier)
Reduce(intersect, ls)

ls

[[1]]
[1] 11041 11042 11050 17001

[[2]]
[1] 11041 11042 11050 12108 16942 17001

[[3]]
[1] 11041 11042 11050 12108 16942 16943 17001 23187

[[4]]
[1] 11041 11042 11050 13357 13359 17001 21378

[[5]]
[1] 11041 11042 11050 13829 17001 28329

[[6]]
[1] 11041 11042 11050 12108 17001

[[7]]
[1]  4004 11041 11042 11050 12108 17001

[[8]]
[1] 11041 11042 11050 17001 17077

[[9]]
[1]  2072 10676 12108


>integer(0) ##I found no overlap between outliers when single populations are removed. 

## FDR: 0.05
HostPlant.outliers <- lapply(HostPlant.Results, FUN=plot_bayescan, FDR=0.05, add_text=T)
ls <- vector("list", 9)
for (i in 1:9) ls[[i]] <- HostPlant.outliers[[i]]$outliers


[[1]]
 [1] 11041 11042 11050 17001 21375 21377 21378 21379 22361 28329 28726

[[2]]
 [1]  2072 11041 11042 11050 12108 16942 16943 17001 21375 21377 21378 29430

[[3]]
 [1]  2072 11041 11042 11050 12108 13625 13829 16942 16943 17001 21378 23187
[13] 24054 28329

[[4]]
 [1]  2072 11041 11042 11050 12108 13357 13359 13829 17001 21375 21377 21378
[13] 21379 23185 26646

[[5]]
 [1]  4992  9287 11041 11042 11050 13357 13359 13829 17001 17082 22361 24468
[13] 28329 28726 28728

[[6]]
 [1]  4992 11041 11042 11050 12108 16942 16943 17001 17082 21378 26646

[[7]]
[1]  4004 11041 11042 11050 12108 17001 21377 21378

[[8]]
[1] 11041 11042 11050 17001 17077 17085 24054 28329 29431

[[9]]
 [1]  2072  7500 10676 11041 11042 11050 11766 12108 15940 26622

> Reduce(intersect, ls)
[1] 11041 11042 11050

```
