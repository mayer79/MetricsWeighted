#' Accuracy
#'
#' Calculates weighted accuracy, i.e. the weighted proportion of elements in \code{predicted} that are equal to those in \code{observed}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' accuracy(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' accuracy(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' accuracy(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{classification_error}}.
accuracy <- function(actual, predicted, w = NULL, ...) {
  weighted_mean(actual == predicted, w = w, ...)
}
