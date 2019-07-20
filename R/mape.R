#' Mean absolute percentage error
#'
#' @description Returns weighted mean absolute percentage error of predicted values.
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
#' mape(1:10, (1:10)^2)
#' mape(1:10, (1:10)^2, w = rep(1, 10))
#' mape(1:10, (1:10)^2, w = 1:10)
mape <- function(actual, predicted, w = NULL, ...) {
  weighted_mean(abs(actual - predicted) / abs(actual), w, ...)
}

