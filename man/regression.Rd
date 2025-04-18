% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regression.R
\name{regression}
\alias{regression}
\alias{mse}
\alias{rmse}
\alias{mae}
\alias{medae}
\alias{mape}
\alias{prop_within}
\alias{deviance_normal}
\alias{deviance_poisson}
\alias{deviance_gamma}
\alias{deviance_tweedie}
\title{Regression Metrics}
\usage{
mse(actual, predicted, w = NULL, ...)

rmse(actual, predicted, w = NULL, ...)

mae(actual, predicted, w = NULL, ...)

medae(actual, predicted, w = NULL, ...)

mape(actual, predicted, w = NULL, ...)

prop_within(actual, predicted, w = NULL, tol = 1, ...)

deviance_normal(actual, predicted, w = NULL, ...)

deviance_poisson(actual, predicted, w = NULL, ...)

deviance_gamma(actual, predicted, w = NULL, ...)

deviance_tweedie(actual, predicted, w = NULL, tweedie_p = 0, ...)
}
\arguments{
\item{actual}{Observed values.}

\item{predicted}{Predicted values.}

\item{w}{Optional case weights.}

\item{...}{Further arguments passed to \code{\link[=weighted_mean]{weighted_mean()}} (no effect for \code{medae()}).}

\item{tol}{Predictions in \eqn{[\textrm{actual} \pm \textrm{tol}]} count as "within"
(only relevant for \code{prop_within()}).}

\item{tweedie_p}{Tweedie power \eqn{p \in \{0\} \cup [1, \infty)}.}
}
\value{
A numeric vector of length one.
}
\description{
Case-weighted versions of typical regression metrics:
\itemize{
\item \code{mse()}: Mean-squared error.
\item \code{rmse()}: Root-mean-squared error.
\item \code{mae()}: Mean absolute error.
\item \code{medae()}: Median absolute error.
\item \code{mape()}: Mean absolute percentage error.
\item \code{prop_within()}: Proportion of predictions that are within a given tolerance
around the actual values.
\item \code{deviance_normal()}: Average (unscaled) normal deviance. Equals MSE, and also the
average Tweedie deviance with \eqn{p = 0}.
\item \code{deviance_poisson()}: Average (unscaled) Poisson deviance. Equals average Tweedie
deviance with \eqn{p=1}.
\item \code{deviance_gamma()}: Average (unscaled) Gamma deviance. Equals average Tweedie
deviance with \eqn{p=2}.
\item \code{deviance_tweedie()}: Average Tweedie deviance with parameter
\eqn{p \in \{0\} \cup [1, \infty)}, see reference.
}

Lower values mean better performance. Notable exception is \code{prop_within()},
where higher is better.
}
\section{Input range}{

The values of \code{actual} and \code{predicted} can be any real numbers, with the following
exceptions:
\itemize{
\item \code{mape()}: Non-zero actual values.
\item \code{deviance_poisson()}: Non-negative actual values and predictions.
\item \code{deviance_gamma()}: Strictly positive actual values and predictions.
}
}

\examples{
y <- 1:10
pred <- c(1:9, 12)
w <- 1:10

rmse(y, pred)
sqrt(mse(y, pred)) # Same

mae(y, pred)
mae(y, pred, w = w)
medae(y, pred, w = 1:10)
mape(y, pred)

prop_within(y, pred)

deviance_normal(y, pred)
deviance_poisson(y, pred)
deviance_gamma(y, pred)

deviance_tweedie(y, pred, tweedie_p = 0) # Normal
deviance_tweedie(y, pred, tweedie_p = 1) # Poisson
deviance_tweedie(y, pred, tweedie_p = 2) # Gamma
deviance_tweedie(y, pred, tweedie_p = 1.5, w = 1:10)

}
\references{
Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC.
ISBN 978-0412997112.
}
