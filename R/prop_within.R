#' Proportion Within
#'
#' Calculates weighted proportion of predictions that are within a given tolerance around the actual values. The larger the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tol Predictions in the closed interval from actual - tol to actual + tol count as within.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' prop_within(1:10, c(1:9, 12))
#' prop_within(1:10, c(1:9, 12), w = rep(1, 10))
#' prop_within(1:10, c(1:9, 12), w = 1:10)
#' data <- data.frame(act = 1:10, pred = c(1:9, 12), w = 1:10)
#' multi <- multi_metric(fun = prop_within, tol = 0:3)
#' performance(data, actual = "act", predicted = "pred", w = "w",
#'   metrics = multi, key = "Proportion within")
prop_within <- function(actual, predicted, w = NULL, tol = 1, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(abs(actual - predicted) <= tol, w = w, ...)
}
