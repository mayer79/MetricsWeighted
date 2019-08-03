#' Mean absolute percentage error
#'
#' Calculates weighted mean absolute percentage error of predicted values.
#'
#' @author Michael Mayer
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param clip_small Minimal absolute value in the denominator. Used to avoid divisions by 0.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' mape(1:10, (1:10)^2)
#' mape(1:10, (1:10)^2, w = rep(1, 10))
#' mape(1:10, (1:10)^2, w = 1:10)
mape <- function(actual, predicted, w = NULL, clip_small = 0, ...) {
  val <- abs(actual - predicted) / abs(pmax(actual, clip_small))
  100 * weighted_mean(val, w = w, ...)
}

