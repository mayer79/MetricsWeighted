# MetricsWeighted <a href='https://github.com/mayer79/MetricsWeighted'><img src='man/figures/logo.png' align="right" height="138.5"/></a>

[![CRAN version](http://www.r-pkg.org/badges/version/MetricsWeighted)](https://cran.r-project.org/package=MetricsWeighted) [![](https://cranlogs.r-pkg.org/badges/MetricsWeighted)](https://cran.r-project.org/package=MetricsWeighted) [![](https://cranlogs.r-pkg.org/badges/grand-total/MetricsWeighted?color=orange)](https://cran.r-project.org/package=MetricsWeighted)

The goal of this package is to provide weighted versions of metrics, scoring functions and performance measures for machine learning.

## Installation

You can install the released version of MetricsWeighted from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("MetricsWeighted")
```

To get the bleeding edge version, you can run
``` r
library(devtools)
install_github("mayer79/MetricsWeighted", subdir = "release/MetricsWeighted")
```

## Application

There are two ways to apply the package. We will go through them in the following examples. Please have a look at the vignette on CRAN for further information and examples. 

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
performance(dat, actual = "y", predicted = "pred",
            metrics = list(deviance = deviance_gamma, pseudo_r2 = r_squared_gamma))

```

