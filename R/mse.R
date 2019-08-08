#' Mean-squared error
#'
#' Calculates weighted mean-squared error of prediction. Equals mean unit normal deviance. The smaller the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mse(1:10, c(1:9, 12))
#' mse(1:10, c(1:9, 12), w = rep(1, 10))
#' mse(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{rmse}, \link{deviance_normal}}.
mse <- function(actual, predicted, w = NULL, ...) {
  weighted_mean((actual - predicted)^2, w = w, ...)
}
