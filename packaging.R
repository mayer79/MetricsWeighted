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

# Install the package (locally)
build(pkg)
install(pkg) # tar

# modify .Rbuildignore in build project to ignore the proj file.

check_win_devel(pkg)

check_rhub(pkg)

setwd(pkg)

devtools::release(pkg)
