#' Root-mean-squared error
#'
#' @description Weighted root-mean-squared error of predicted values. Equals the square root of mean-squared error.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{mse}.
#' 
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' rmse(1:10, (1:10)^2)
#' rmse(1:10, (1:10)^2, w = rep(1, 10))
#' rmse(1:10, (1:10)^2, w = 1:10)
#' 
#' @seealso \code{\link{mse}}.
#' 
rmse <- function(actual, predicted, w = NULL, ...) {
  sqrt(mse(actual = actual, predicted = predicted, w = w, ...))
}