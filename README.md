# MetricsWeighted

The goal of MetricsWeighted is to provide weighted versions of metrics for machine learning

## Installation

You can install the released version of MetricsWeighted from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("MetricsWeighted")
```

## Example

``` r
library(MetricsWeighted)

y <- 1:10
pred <- sqrt(y)

rmse(y, pred)
rmse(y, pred, w = 1:10)

r_squared(y, pred, deviance_function = deviance_gamma)
```

