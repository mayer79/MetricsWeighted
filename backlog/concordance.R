library(survival)
n <- 100
y <- sample(0:1, n, T)
p <- runif(n)
w <- runif(n)

MetricsWeighted::AUC(y, p)
MetricsWeighted::AUC(y, p, w)

AUC2 <- function (y, prob, w) {
  if (missing(w))
    concordance(y ~ prob)$concordance
  else concordance(y ~ prob, weights = w)$concordance
}

AUC2(y, p)
AUC2(y, p, w)

library(microbenchmark)
microbenchmark(AUC2(y, p), AUC(y, p), times = 10)

# AUC: y binary and default timewt
# Harrell's c-statistic: y survival
# (Somers' d + 1) / 2: y continuous
# var: somer / 4

microbenchmark(concordance(y ~ p), times = 1000)

