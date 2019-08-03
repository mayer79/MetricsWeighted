#' Log Loss/binary cross entropy
#'
#' Calculates weighted logloss/cross entropy. Equals half of the unit Bernoulli deviance.
#'
#' @author Michael Mayer
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' logLoss(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8))
#' logLoss(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8))
#' logLoss(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' @seealso \code{\link{deviance_bernoulli}}.
logLoss <- function(actual, predicted, w = NULL, ...) {
  eps <- 1e-15
  predicted <- pmax(pmin(predicted, 1 - eps), eps)
  -weighted_mean(actual * log(predicted) + (1 - actual) * log(1 - predicted), w = w, ...)
}
