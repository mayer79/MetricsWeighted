#' Recall
#'
#' @description Returns weighted recall.
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
#' recall(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' recall(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' recall(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
recall <- function(actual, predicted, w = NULL, ...) {
  weighted_mean(predicted[actual == 1], w[actual == 1], ...)
}

