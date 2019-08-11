#' Median Absolute Error
#'
#' Calculates weighted median absolute error of predicted values. The smaller the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' medae(1:10, c(2:10, 100))
#' medae(1:10, c(2:10, 100), w = rep(1, 10))
#' medae(1:10, c(2:10, 100), w = 1:10)
medae <- function(actual, predicted, w = NULL, ...) {
  weighted_median(abs(actual - predicted), w = w, ...)
}
