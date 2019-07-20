#' Classification error
#'
#' @description Returns weighted classification error, i.e. the proportion of elements in \code{predicted} that are unequal to those in \code{observed}.
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
#' classification_error(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' classification_error(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' classification_error(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
classification_error <- function(actual, predicted, w = NULL, ...) {
  weighted_mean(actual == predicted, w, ...)
}