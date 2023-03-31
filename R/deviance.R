#' Bernoulli Deviance
#'
#' Calculates weighted average of unit Bernoulli deviance.
#' Defined as twice logLoss. The smaller the deviance, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values strictly between 0 and 1.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{logLoss()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' deviance_bernoulli(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8))
#' deviance_bernoulli(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' @seealso \code{\link{logLoss}}.
deviance_bernoulli <- function(actual, predicted, w = NULL, ...) {
  2 * logLoss(actual = actual, predicted = predicted, w = w, ...)
}

#' Log Loss/Binary Cross Entropy
#'
#' Calculates weighted log loss (= cross entropy).
#' Equals half of the unit Bernoulli deviance. The smaller, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values strictly larger than 0 and smaller than 1.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' logLoss(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8))
#' logLoss(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' @seealso \code{\link{deviance_bernoulli}}.
logLoss <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1),
    all(predicted > 0 & predicted < 1)
  )
  -weighted_mean(
    actual * log(predicted) + (1 - actual) * log(1 - predicted), w = w, ...
  )
}

#' Normal Deviance
#'
#' Weighted average of (unscaled) unit normal deviance. This equals the weighted
#' mean-squared error, see e.g. the reference below.
#' The smaller the deviance, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{mse()}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_normal(1:10, c(1:9, 12))
#' deviance_normal(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{deviance_tweedie}, \link{mse}}.
deviance_normal <- function(actual, predicted, w = NULL, ...) {
  mse(actual = actual, predicted = predicted, w = w, ...)
}

#' Poisson Deviance
#'
#' Weighted average of unit Poisson deviance, see reference below.
#' Special case of Tweedie deviance with Tweedie parameter 1.
#'
#' @param actual Observed non-negative values.
#' @param predicted Strictly positive predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_poisson(0:2, c(0.1, 1, 3))
#' deviance_poisson(0:2, c(0.1, 1, 3), w = c(1, 1, 1))
#' deviance_tweedie(0:2, c(0.1, 1, 3), tweedie_p = 1)
#' deviance_tweedie(0:2, c(0.1, 1, 3), tweedie_p = 1.01)
#' deviance_poisson(0:2, c(0.1, 1, 3), w = 1:3)
#' @seealso \code{\link{deviance_tweedie}}.
deviance_poisson <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual >= 0),
    all(predicted > 0)
  )
  pos <- actual > 0
  predicted[pos] <- (actual * log(actual / predicted) - (actual - predicted))[pos]
  weighted_mean(x = 2 * predicted, w = w, ...)
}

#' Gamma Deviance
#'
#' Weighted average of (unscaled) unit Gamma deviance, see e.g. the reference below.
#' Special case of Tweedie deviance with Tweedie parameter 2.
#' The smaller the deviance, the better.
#'
#' @param actual Strictly positive observed values.
#' @param predicted Strictly positive predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_gamma(1:10, c(1:9, 12))
#' deviance_gamma(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{deviance_tweedie}}.
deviance_gamma <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(predicted > 0),
    all(actual > 0)
  )
  u <- -log(ifelse(actual == 0, 1, actual / predicted)) +
    (actual - predicted) / predicted
  weighted_mean(x = 2 * u, w = w, ...)
}

#' Tweedie Deviance
#'
#' Weighted average of (unscaled) unit Tweedie deviance with parameter p.
#' This includes the normal deviance (p = 0), the Poisson deviance (p = 1),
#' as well as the Gamma deviance (p = 2), see reference below and
#' \url{https://en.wikipedia.org/wiki/Tweedie_distribution} for the
#' specific deviance formula. For 0 < p < 1, the distribution is not defined.
#' The smaller the deviance, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tweedie_p Tweedie power.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 0)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 2)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.5)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.5, w = 1:10)
#' @seealso \code{\link{deviance_normal}, \link{deviance_poisson}, \link{deviance_gamma}}.
deviance_tweedie <- function(actual, predicted, w = NULL, tweedie_p = 0, ...) {
  stopifnot(tweedie_p <= 0 || tweedie_p >= 1)

  # Catch special cases
  if (tweedie_p %in% 0:2) {
    if (tweedie_p == 0) {
      fun <- deviance_normal
    } else if (tweedie_p == 1) {
      fun <- deviance_poisson
    } else {
      fun <- deviance_gamma
    }
    return(fun(actual = actual, predicted = predicted, w = w, ...))
  }
  # General Tweedie case
  stopifnot(
    length(actual) == length(predicted),
    all(predicted > 0)
  )
  if (tweedie_p >= 1 && tweedie_p < 2) {
    stopifnot(all(actual >= 0))
  }
  if (tweedie_p >= 2) {
    stopifnot(all(actual > 0))
  }
  u <- pmax(actual, 0)^(2 - tweedie_p) / ((1 - tweedie_p) * (2 - tweedie_p)) -
    (actual * predicted^(1 - tweedie_p)) / (1 - tweedie_p) +
    (predicted^(2 - tweedie_p) / (2 - tweedie_p))
  weighted_mean(x = 2 * u, w = w, ...)
}

