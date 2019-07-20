#' Root-mean-squared error
#'
#' @description Returns (weighted) root-mean-squared error of predicted values.
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
#' rmse(1:10, (1:10)^2)
#' rmse(1:10, (1:10)^2, w = rep(1, 10))
#' rmse(1:10, (1:10)^2, w = 1:10)
rmse <- function(actual, predicted, w = NULL, ...) {
  sqrt(weighted_mean((actual - predicted)^2, w, ...))
}