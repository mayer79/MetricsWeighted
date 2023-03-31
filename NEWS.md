# MetricsWeighted 0.5.6

## Maintenance

- Reorganization of code.

# MetricsWeighted 0.5.5

## Maintenance

- Use github workflows
- Add github pages
- Better README

## Dependencies

- Removed {dplyr} from suggested packages.

# MetricsWeighted 0.5.4

This is a maintainance update without any code change.

- Fixed problematic unit tests.
- Internal restructuring how package content is being generated.

# MetricsWeighted 0.5.3

- Added unit tests
- Added option `reference_mean` to `r_squared()` functions. This allows clean out-of-sample applications.
- Added Murphy diagrams

# MetricsWeighted 0.5.2

Maintainance release. `rmarkdown` is now an explicit "Suggested" package.

# MetricsWeighted 0.5.1

## New function

- `weighted_cor` to calculate weighted correlation between actual and observed values.

- `prop_within` to calculate weighted proportion of predictions within a tolerance around actual values.

## Requirements

- Reduced minimal R version from 3.5 to 3.1.

## Documentation

- Clarified that R-squared is calculated with respect to the null model calculated from the actual values.

# MetricsWeighted 0.5.0

## New functions

- Elementary scoring functions for expectiles and quantiles.

- `multi_metric`: A way to create a named list of performance measures parametrized by a parameter.

# MetricsWeighted 0.4.0

## New functions

Added the following convenience wrappers to `r_squared`.

- `r_squared_poisson`

- `r_squared_gamma`

- `r_squared_bernoulli`

# MetricsWeighted 0.3.0

## New function

Added function `weighted_var` to calculate variance weighted by sampling weights.

# MetricsWeighted 0.2.0

- Improvement of documentation and examples. 

- Better handling of Tweedie special cases.

- More strict error handling.

- Added median absolute error (and weighted_median, weighted_quantile)

# MetricsWeighted 0.1.0

Initial release.
