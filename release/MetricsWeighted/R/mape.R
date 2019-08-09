#' Mean absolute percentage error
#'
#' Calculates weighted mean absolute percentage error of predicted values. The smaller, the better.
#'
#' @param actual Strictly positive observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mape(1:10, (1:10)^2)
#' mape(1:10, (1:10)^2, w = rep(1, 10))
#' mape(1:10, (1:10)^2, w = 1:10)
mape <- function(actual, predicted, w = NULL, ...) {
  stopifnot(all(actual > 0))
  val <- abs(actual - predicted) / abs(actual)
  100 * weighted_mean(val, w = w, ...)
}

