#' Root-Mean-Squared Error
#'
#' Weighted root-mean-squared error of predicted values.
#' Equals the square root of mean-squared error. Smaller values are better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{mse()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' rmse(1:10, c(1:9, 12))
#' rmse(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{mse}}.
rmse <- function(actual, predicted, w = NULL, ...) {
  sqrt(mse(actual = actual, predicted = predicted, w = w, ...))
}

#' Mean-Squared Error
#'
#' Calculates weighted mean-squared error of prediction.
#' Equals mean unit normal deviance. The smaller, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mse(1:10, c(1:9, 12))
#' mse(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{rmse}, \link{deviance_normal}}.
mse <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean((actual - predicted)^2, w = w, ...)
}

#' Mean Absolute Error
#'
#' Calculates weighted mean absolute error of predicted values.
#' The smaller the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mae(1:10, c(1:9, 12))
#' mae(1:10, c(1:9, 12), w = 1:10)
mae <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(abs(actual - predicted), w = w, ...)
}

#' Median Absolute Error
#'
#' Calculates weighted median absolute error of predicted values.
#' The smaller the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_median()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' medae(1:10, c(2:10, 100))
#' medae(1:10, c(2:10, 100), w = 1:10)
medae <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_median(abs(actual - predicted), w = w, ...)
}

#' Mean Absolute Percentage Error
#'
#' Calculates weighted mean absolute percentage error of predicted values.
#' The smaller, the better.
#'
#' @param actual Strictly positive observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mape(1:10, c(1:9, 12))
#' mape(1:10, c(1:9, 12), w = 1:10)
mape <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual != 0)
  )
  val <- abs(actual - predicted) / abs(actual)
  100 * weighted_mean(val, w = w, ...)
}

#' Proportion Within
#'
#' Calculates weighted proportion of predictions that are within a given tolerance
#' around the actual values. The larger the value, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tol Predictions in the closed interval from actual - tol to actual + tol count
#' as within.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' prop_within(1:10, c(1:9, 12))
#' prop_within(1:10, c(1:9, 12), w = 1:10)
#' data <- data.frame(act = 1:10, pred = c(1:9, 12), w = 1:10)
#' multi <- multi_metric(fun = prop_within, tol = 0:3)
#' performance(data, actual = "act", predicted = "pred", w = "w",
#'   metrics = multi, key = "Proportion within")
prop_within <- function(actual, predicted, w = NULL, tol = 1, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(abs(actual - predicted) <= tol, w = w, ...)
}

