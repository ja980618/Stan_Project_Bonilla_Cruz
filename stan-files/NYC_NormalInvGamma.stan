// Mean Fare Model 1
// Normal Model with Normal and Inverse Gamma Priors (Fixed Parameters)

data {
  int<lower=0> N; // total number of trips
  int<lower=0> K; // number of clusters
  int<lower=1,upper=K> x[N]; // cluster indicator column
  vector[N] y; // price data
}

parameters {
  vector[K] mu; // group means
  vector<lower=0>[K] sigma; // group stds
}

model {
  mu ~ normal(15, 86); // population prior for mu
  sigma ~ inv_gamma(5, 56); // population prior for sigma
  y ~ normal(mu[x], sigma[x]);
}
