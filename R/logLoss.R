#' Log Loss/Binary Cross Entropy
#'
#' Calculates weighted logloss resp. cross entropy. Equals half of the unit Bernoulli deviance. The smaller, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values strictly larger than 0 and smaller than 1.
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
  stopifnot(length(actual) == length(predicted),
            all(actual == 0 | actual == 1),
            all(predicted > 0 & predicted < 1))
  -weighted_mean(actual * log(predicted) + (1 - actual) * log(1 - predicted), w = w, ...)
}
