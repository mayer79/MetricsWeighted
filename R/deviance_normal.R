#' Normal deviance
#'
#' @description Weighted average of (unscaled) unit normal deviance. This equals the weighted mean-squared error, see e.g. [1].
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{deviance_tweedie}.
#'
#' @return A numeric vector of length one.
#'
#' @export
#'
#' @references
#' [1] Ohlsson E. and Johansson B. (2015). Non-Life Insurance Pricing with Generalized Linear Models. Springer Nature EN. ISBN 978-3642107900.
#'
#' @examples
#' deviance_normal(1:10, (1:10)^2)
#' deviance_normal(1:10, (1:10)^2, w = rep(1, 10))
#' deviance_normal(1:10, (1:10)^2, w = 1:10)
#'
#' @seealso \code{\link{deviance_tweedie}, \link{mse}}.
#'
deviance_normal <- function(actual, predicted, w = NULL, ...) {
  deviance_tweedie(actual = actual, predicted = predicted, w = w, tweedie_p = 0)
}
