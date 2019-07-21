#=====================================================================================
# BUILD THE PACKAGE "MetricsWeighted"
#=====================================================================================

library(usethis)

pkg <- "MetricsWeighted"

# Create a new package -------------------------------------------------
path <- file.path(tempdir(), "pkg")
create_package(
  path,
  fields = list(
    Title = "Weighted Metrics for Machine Learning",
    Type = "Package",
    Version = "0.1.0",
    Date = Sys.Date(),
    Description = "Provides weighted versions of several metrics used in machine learning, including relevant metrics in actuarial science like Tweedie, Poisson, and Gamma deviance.",

    `Authors@R` = "person('Michael', 'Mayer', email = 'mayermichael79@gmail.com', role = c('aut', 'cre', 'cph'))",
    Depends = "R (>= 3.5.0)",
    Imports = list("stats"),
    License = "GPL(>= 3)",
    Author = "Michael Mayer [aut, cre, cph]",
    Maintainer = "Michael Mayer <mayermichael79@gmail.com>"))

proj_activate(path)

# Set up various packages ---------------------------------------------
use_roxygen_md()

# Set up other files -------------------------------------------------
use_readme_md()
use_news_md()
#> ✔ Writing 'NEWS.md'

# Use git ------------------------------------------------------------
use_git()
