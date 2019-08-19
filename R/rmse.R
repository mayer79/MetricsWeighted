#' Root-Mean-Squared Error
#'
#' Weighted root-mean-squared error of predicted values. Equals the square root of mean-squared error. Smaller values are better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{mse}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' rmse(1:10, c(1:9, 12))
#' rmse(1:10, c(1:9, 12), w = rep(1, 10))
#' rmse(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{mse}}.
rmse <- function(actual, predicted, w = NULL, ...) {
  sqrt(mse(actual = actual, predicted = predicted, w = w, ...))
}
