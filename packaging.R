# =============================================================================
# Put together the package
# =============================================================================

# WORKFLOW: UPDATE EXISTING PACKAGE
# 1) Modify package content and documentation.
# 2) Increase package number in "use_description" below.
# 3) Go through this script and carefully answer "no" if a "use_*" function
#    asks to overwrite the existing files. Don't skip that function call.
# devtools::load_all()

library(usethis)

# Sketch of description file
use_description(
  fields = list(
    Title = "Weighted Metrics and Performance Measures for Machine Learning",
    Version = "1.0.4",
    Description = "Provides weighted versions of several metrics and performance
    measures used in machine learning, including average unit deviances of the
    Bernoulli, Tweedie, Poisson, and Gamma distributions,
    see Jorgensen B. (1997, ISBN: 978-0412997112).
    The package also contains a weighted version of generalized R-squared,
    see e.g. Cohen, J. et al. (2002, ISBN: 978-0805822236).
    Furthermore, 'dplyr' chains are supported.",
    `Authors@R` =
      "c(person('Michael', 'Mayer', email = 'mayermichael79@gmail.com', role = c('aut', 'cre')),
       person('Christian', 'Lorentzen', email = 'lorentzen.ch@googlemail.com', role = 'ctb'))",
    Depends = "R (>= 3.1.0)",
    LazyData = NULL
  ),
  roxygen = TRUE
)

use_package("graphics", "Imports")
use_package("stats", "Imports")

use_gpl_license(2)

use_github_links() # use this if this project is on github

# Your files that do not belong to the package itself (others are added by "use_* function")
use_build_ignore(c(
  "^packaging.R$", "[.]Rproj$",
  "^cran-comments.md$", "^logo.png$"
), escape = FALSE)

# If your code uses the pipe operator %>%
# use_pipe()

# If your package contains data. Google how to document
# use_data()

# Add short docu in Markdown (without running R code)
use_readme_md()

# Longer docu in RMarkdown (with running R code). Often quite similar to readme.
use_vignette("MetricsWeighted")

# If you want to add unit tests
use_testthat()
# use_test("accurary-error.R")

# On top of NEWS.md, describe changes made to the package
use_news_md()

# Add logo
use_logo("logo.png")

# If package goes to CRAN: infos (check results etc.) for CRAN
use_cran_comments()

# Github actions
use_github_action("check-standard")
use_github_action("test-coverage")
use_github_action("pkgdown")

# Revdep
use_revdep()

# =============================================================================
# Finish package building (can use fresh session)
# =============================================================================

library(devtools)

document()
test()
check(manual = TRUE, cran = TRUE, vignettes = FALSE)
build()
# build(binary = TRUE)
install()

# Run only if package is public(!) and should go to CRAN
if (FALSE) {
  check_win_devel()
  check_rhub()

  # Takes long
  revdepcheck::revdep_check(num_workers = 4, bioc = FALSE)

  # Wait until above checks are passed without relevant notes/warnings
  # then submit to CRAN
  devtools::release()
}
