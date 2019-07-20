#' Mean absolute error
#'
#' @description Returns weighted mean absolute error of predicted values.
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
#' mae(1:10, (1:10)^2)
#' mae(1:10, (1:10)^2, w = rep(1, 10))
#' mae(1:10, (1:10)^2, w = 1:10)
mae <- function(actual, predicted, w = NULL, ...) {
  weighted_mean(abs(actual - predicted), w)
}