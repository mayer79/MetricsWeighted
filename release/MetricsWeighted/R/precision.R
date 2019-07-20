#' Precision
#'
#' @description Returns weighted precision.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#'
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' precision(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' precision(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' precision(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
precision <- function(actual, predicted, w = NULL, ...) {
  weighted_mean(actual[predicted == 1], w[predicted == 1], ...)
}