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
install_github("mayer79/MetricsWeighted")
```

## Application

There are two ways to apply the package. We will go through them in the following examples. Please have a look at the vignette on CRAN for further information and examples. 

### Example 1: Standard interface

``` r
library(MetricsWeighted)

y <- 1:10
pred <- c(2:10, 14)

rmse(y, pred)            # 1.58
rmse(y, pred, w = 1:10)  # 1.93

r_squared(y, pred)       # 0.70
r_squared(y, pred, deviance_function = deviance_gamma)  # 0.78

```

### Example 2: data.frame interface

Can e.g. be used in a `dplyr` chain.

``` r
dat <- data.frame(y = y, pred = pred)

performance(dat, actual = "y", predicted = "pred")

> metric    value
>   rmse 1.581139


performance(dat, actual = "y", predicted = "pred", 
            metrics = list(rmse = rmse, `R-squared` = r_squared))

>    metric     value
>      rmse 1.5811388
> R-squared 0.6969697

```

