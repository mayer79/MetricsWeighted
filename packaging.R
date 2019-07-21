#=====================================================================================
# BUILD THE PACKAGE "MetricsWeighted"
#=====================================================================================

library(devtools)

stopifnot(basename(getwd()) == "MetricsWeighted")

pkg <- "release/MetricsWeighted"
unlink(pkg, force = TRUE, recursive = TRUE)
create_package(pkg, fields = list(
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
            Maintainer = "Michael Mayer <mayermichael79@gmail.com>"), 
  rstudio = FALSE)

# Add R files
Rfiles <- list.files("R", pattern = "\\.[rR]")
stopifnot(file.exists(fp <- file.path("R", Rfiles)))
file.copy(fp, file.path(pkg, "R"))

# Create Rd files
document(pkg)

# Add further files
# devtools::use_cran_comments(pkg) (is required)
mdfiles <- c("NEWS.md", "README.md")
stopifnot(file.exists(mdfiles))
file.copy(mdfiles, pkg)

# Check
check(pkg, document = FALSE, manual = TRUE, check_dir = dirname(normalizePath(pkg)))

# tar and zip file plus check
build(pkg, manual = TRUE) # tar
# build(pkg, binary = TRUE) # zip

# Install the package (locally)
install(pkg) # tar

check_win_devel(pkg)

check_rhub(pkg)

setwd(file.path("C:/projects/MetricsWeighted", pkg))

devtools::release()

