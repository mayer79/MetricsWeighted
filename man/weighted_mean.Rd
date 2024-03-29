% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/statistics.R
\name{weighted_mean}
\alias{weighted_mean}
\title{Weighted Mean}
\usage{
weighted_mean(x, w = NULL, ...)
}
\arguments{
\item{x}{Numeric vector.}

\item{w}{Optional vector of non-negative case weights.}

\item{...}{Further arguments passed to \code{\link[=mean]{mean()}} or \code{\link[stats:weighted.mean]{stats::weighted.mean()}}.}
}
\value{
A length-one numeric vector.
}
\description{
Returns the weighted mean of a numeric vector.
In contrast to \code{\link[stats:weighted.mean]{stats::weighted.mean()}}, \code{w} does not need to be specified.
}
\examples{
weighted_mean(1:10)
weighted_mean(1:10, w = NULL)
weighted_mean(1:10, w = 1:10)
}
\seealso{
\code{\link[stats:weighted.mean]{stats::weighted.mean()}}
}
