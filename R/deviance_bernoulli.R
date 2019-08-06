#' Bernoulli deviance
#'
#' Calculates weighted average of unit Bernoulli deviance. Defined as twice logLoss.
#'
#' @param actual Observed values.
#' @param predicted Predicted values strictly between 0 and 1.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{logLoss}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' deviance_bernoulli(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8))
#' deviance_bernoulli(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8))
#' deviance_bernoulli(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' @seealso \code{\link{logLoss}}.
deviance_bernoulli <- function(actual, predicted, w = NULL, ...) {
  2 * logLoss(actual = actual, predicted = predicted, w = w, ...)
}
