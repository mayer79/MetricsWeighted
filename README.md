# MetricsWeighted

The goal of this package is to provide weighted versions of metrics for machine learning.

## Installation

You can install the released version of MetricsWeighted from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("MetricsWeighted")
```

To get the bleeding edge version, you can run
``` r
library(devtools)
install_github("mayer79/MetricsWeighted")
```

## Application

There are two ways to apply the package. We will go through them in the following examples. 

## Example 1: Directly apply the metrics

``` r
library(MetricsWeighted)

y <- 1:10
pred <- c(2:10, 14)

rmse(y, pred)
rmse(y, pred, w = 1:10)

r_squared(y, pred)
r_squared(y, pred, deviance_function = deviance_gamma)

```

## Example 2: Call the metrics through a common function that can be used within a `dplyr` chain

``` r
dat <- data.frame(y = y, pred = pred)

performance(dat, actual = "y", predicted = "pred")
performance(dat, actual = "y", predicted = "pred", metrics = r_squared)
performance(dat, actual = "y", predicted = "pred", 
            metrics = list(rmse = rmse, `R-squared` = r_squared))

```

