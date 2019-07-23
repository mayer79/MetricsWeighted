#' F1 score
#'
#' @description Weighted F1 score, the harmonic mean of precision and recall.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{precision} and \code{recall}.
#'
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' f1_score(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' f1_score(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' f1_score(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' 
#' @seealso \code{\link{precision}, \link{recall}}.
#' 
f1_score <- function(actual, predicted, w = NULL, ...) {
  p <- precision(actual = actual, predicted = predicted, w = w, ...)
  r <- recall(actual = actual, predicted = predicted, w = w, ...)
  2 * (p * r) / (p + r)
}

