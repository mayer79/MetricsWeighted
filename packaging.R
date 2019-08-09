#=====================================================================================
# BUILD THE PACKAGE
#=====================================================================================

lapply(list.files("R", full.names = TRUE), source)

library(usethis)
library(devtools)

# Create a new package
dir.create(file.path("release"))
pkg <- file.path("release", "MetricsWeighted")

create_package(
  pkg,
  fields = list(
    Title = "Weighted Metrics, Scoring Functions and Performance Measures for Machine Learning",
    Type = "Package",
    Version = "0.1.1",
    Date = Sys.Date(),
    Description = "Provides weighted versions of several metrics, scoring functions and performance measures used in machine learning, including average unit deviances of the Bernoulli, Tweedie, Poisson, and Gamma distributions, see Jorgensen B. (1997, ISBN: 978-0412997112). The package also contains a weighted version of generalized R-squared, see e.g. Cohen, J. et al. (2002, ISBN: 978-0805822236). Furthermore, 'dplyr' chains are supported.",

    `Authors@R` = "c(person('Michael', 'Mayer', email = 'mayermichael79@gmail.com', role = c('aut', 'cre', 'cph')),
       person('Christian', 'Lorentzen', email = 'lorentzen.ch@googlemail.com', role = c('rev')))",
    Depends = "R (>= 3.5.0)",
    VignetteBuilder = "knitr",
    License = "GPL(>= 2)",
  #  Author = "Michael Mayer [aut, cre, cph]",
    Maintainer = "Michael Mayer <mayermichael79@gmail.com>"))


# Use package has no option to look for pkg, so we first copy description from pkg, modify it and move back
use_package("stats", "Imports")
use_package("dplyr", "Suggests")
use_package("knitr", "Suggests")

# Set up other files -------------------------------------------------
# use_readme_md()
# use_news_md()
# use_cran_comments()

# Copy readme etc.
file.copy(c(".Rbuildignore", "NEWS.md", "README.md", "cran-comments.md", "DESCRIPTION"), pkg, overwrite = TRUE)

# Copy R scripts and document them
dir.create(file.path(pkg, "R"))
file.copy(list.files("R", full.names = TRUE), file.path(pkg, "R"), overwrite = TRUE)
devtools::document(pkg)

# Copy vignette
# use_vignette(name = "MetricsWeighted", title = "MetricsWeighted")
dir.create(file.path(pkg, "vignettes"))
dir.create(file.path(pkg, "doc"))
dir.create(file.path(pkg, "Meta"))
file.copy(list.files("vignettes", full.names = TRUE), file.path(pkg, "vignettes"), overwrite = TRUE)

devtools::build_vignettes(pkg)

# Check
check(pkg, manual = TRUE)

# Create
build(pkg)

# Install
install(pkg)

# modify .Rbuildignore in build project to ignore the proj file.

check_win_devel(pkg)

check_rhub(pkg)

devtools::release(pkg)
