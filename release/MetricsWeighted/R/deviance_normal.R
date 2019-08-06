#' Normal deviance
#'
#' Weighted average of (unscaled) unit normal deviance. This equals the weighted mean-squared error, see e.g. [1].
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{mse}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' [1] Ohlsson E. and Johansson B. (2015). Non-Life Insurance Pricing with Generalized Linear Models. Springer Nature EN. ISBN 978-3642107900.
#' @examples
#' deviance_normal(1:10, c(1:9, 12))
#' deviance_normal(1:10, c(1:9, 12), w = rep(1, 10))
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 0)
#' deviance_normal(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{deviance_tweedie}, \link{mse}}.
deviance_normal <- function(actual, predicted, w = NULL, ...) {
  mse(actual = actual, predicted = predicted, w = w, ...)
}
