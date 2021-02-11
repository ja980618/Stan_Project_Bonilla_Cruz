// Big Tippers Model 1
// Beta(1.41,4.28) population prior

data {
  int<lower=0> K; // number of clusters (row number) nuúmero de renglones
  int<lower=0> n[K]; // total number of trips (by row number)  número de viajes de viajes
  int<lower=0> y[K]; // number of heavy tippers (by row number) número de viajes que tuvieron una buena propina
}

parameters {
  real<lower=0,upper=1> theta[K];// thetha al ser una propabilidad sólo puede estar entre (0,1)
}

model {
  theta ~ beta(1.41,4.28);
  y ~ binomial(n,theta);
}
