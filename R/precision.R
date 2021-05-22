#' Precision
#'
#' Calculates weighted precision, see \url{https://en.wikipedia.org/wiki/Precision_and_recall} for the (unweighted) version. The higher, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' precision(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' precision(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{recall}, \link{f1_score}}.
precision <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted),
            all(actual == 0 | actual == 1),
            all(predicted == 0 | predicted == 1))
  weighted_mean(actual[predicted == 1], w = w[predicted == 1], ...)
}
