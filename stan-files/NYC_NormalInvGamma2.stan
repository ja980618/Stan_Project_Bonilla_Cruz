// Normal Model 2
// Hierarchical Normal Model with Normal and Inverse Gamma Priors (Unknown Parameters)
// Based on models by Aki Vehtari and Markus Paasiniemi (2018)
// http://avehtari.github.io/BDA_R_demos/demos_rstan/rstan_demo.html

data {
  int<lower=0> N; // total number of trips
  int<lower=0> K; // number of clusters
  int<lower=1,upper=K> x[N]; // cluster indicator column
  vector[N] y; // price data
}

parameters {
  real mu0; // prior mean
  real<lower=0> musigma0; // prior std > 0
  vector[K] mu; // group means
  real<lower=0> alpha; // prior alpha > 0
  real<lower=0> beta; // prior beta > 0
  vector<lower=0>[K] sigma; // group stds
}

model {
  mu0 ~ normal(15, 10); // weakly informative: taxis are about $15, right?
  musigma0 ~ inv_gamma(0.1,0.1);  // weakly informative
  mu ~ normal(mu0, musigma0); // population prior for mu with unknown parameters
  alpha ~ normal(0,10); // weakly informative (half-normal)
  beta ~ normal(0,10);  // weakly informative (half-normal)
  sigma ~ inv_gamma(alpha, beta); // population prior for sigma2 with unknown parameters
  y ~ normal(mu[x], sigma[x]);
}
