#' Mean Absolute Error
#'
#' Calculates weighted mean absolute error of predicted values. The smaller the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mae(1:10, c(1:9, 12))
#' mae(1:10, c(1:9, 12), w = rep(1, 10))
#' mae(1:10, c(1:9, 12), w = 1:10)
mae <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(abs(actual - predicted), w = w, ...)
}
