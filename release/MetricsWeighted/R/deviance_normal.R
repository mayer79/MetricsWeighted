#' Normal deviance
#'
#' @description Weighted average of unit normal deviance. Equals the weighted mean-squared error.
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
