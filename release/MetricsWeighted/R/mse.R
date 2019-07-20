#' Mean-squared error
#'
#' @description Returns weighted mean-squared error of predicted values.
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
#' mse(1:10, (1:10)^2)
#' mse(1:10, (1:10)^2, w = rep(1, 10))
#' mse(1:10, (1:10)^2, w = 1:10)
mse <- function(actual, predicted, w = NULL, ...) {
  weighted_mean((actual - predicted)^2, w, ...)
}