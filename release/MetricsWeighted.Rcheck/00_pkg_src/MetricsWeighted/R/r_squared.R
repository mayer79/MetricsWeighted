#' R-squared
#'
#' @description Returns weighted R-squared of predicted values.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#'
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' r_squared(1:10, c(1, 1:9))
#' r_squared(1:10, c(1, 1:9), w = rep(1, 10))
#' r_squared(1:10, c(1, 1:9), w = 1:10)
r_squared <- function(actual, predicted, w = NULL, ...) {
  actual_mean <- weighted_mean(actual, w, ...)
  tss <- weighted_mean((actual - actual_mean)^2, w, ...)
  rss <- weighted_mean((actual - predicted)^2, w, ...)
  1 - rss / tss
}
