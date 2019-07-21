#=====================================================================================
# BUILD THE PACKAGE "MetricsWeighted"
#=====================================================================================

library(usethis)
library(devtools)

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
# use_readme_md()
# use_news_md()

use_package_doc()
use_cran_comments(path)

# Copy stuff to path
file.copy(file.path("R", list.files("R")), file.path(path, "R"))
dir.create(file.path(path, "man"))
file.copy(file.path("man", list.files("man")), file.path(path, "man"))
file.copy(c("DESCRIPTION", "NAMESPACE",
            "NEWS.md", "README.md", "cran-comments.md"), path, overwrite = TRUE)
file.copy(".Rbuildignore", path, overwrite = TRUE)

# Install the package (locally)
install(path) # tar

# modify .Rbuildignore in build project to ignore the proj file.

check_win_devel(path)

check_rhub(path)

setwd(file.path("C:/projects/missRanger", pkg))

devtools::release(path)
