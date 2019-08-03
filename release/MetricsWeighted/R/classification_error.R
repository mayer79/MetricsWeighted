#' Classification error
#'
#' Calculates weighted classification error, i.e. the weighted proportion of elements in \code{predicted} that are unequal to those in \code{observed}. Equals 1 - accuracy.
#'
#' @author Michael Mayer
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{accuracy}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' classification_error(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' classification_error(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' classification_error(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{accuracy}}.
classification_error <- function(actual, predicted, w = NULL, ...) {
  1 - accuracy(actual = actual, predicted = predicted, w = w, ...)
}
