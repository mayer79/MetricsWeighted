#=====================================================================================
# BUILD THE PACKAGE
#=====================================================================================

library(usethis)
library(devtools)

# Create a new package -------------------------------------------------
pkg <- file.path("release", "MetricsWeighted")

create_package(
  path,
  fields = list(
    Title = "Weighted Metrics and performance measures for Machine Learning",
    Type = "Package",
    Version = "0.1.0",
    Date = Sys.Date(),
    Description = "Provides weighted versions of several metrics and performance measures used in machine learning, including Tweedie, Poisson, and Gamma deviance as well as generalized R-squared.",

    `Authors@R` = "person('Michael', 'Mayer', email = 'mayermichael79@gmail.com', role = c('aut', 'cre', 'cph'))",
    Depends = "R (>= 3.5.0)",
    Imports = list("stats"),
    Suggests = list("dplyr"),
    License = "GPL(>= 3)",
    Author = "Michael Mayer [aut, cre, cph]",
    Maintainer = "Michael Mayer <mayermichael79@gmail.com>"))

use_namespace()

# Set up various packages ---------------------------------------------
use_roxygen_md()

# Set up other files -------------------------------------------------
# use_readme_md()
# use_news_md()
# use_cran_comments()
# use_vignette(name = "MetricsWeighted", title = "MetricsWeighted")

# Copy stuff to pkg
file.copy(c(".Rbuildignore", "NEWS.md", "README.md", "cran-comments.md"), pkg, overwrite = TRUE)
file.copy(list.files("R", full.names = TRUE), file.path(pkg, "R"), overwrite = TRUE)
devtools::document(pkg)
devtools::build_vignettes(pkg)

# Install the package (locally)
build(pkg)
install(pkg) # tar

# modify .Rbuildignore in build project to ignore the proj file.

check_win_devel(pkg)

check_rhub(pkg)

setwd(pkg)

devtools::release(pkg)
