#' Recall
#'
#' Calculates weighted recall.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' recall(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' recall(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' recall(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{precision}, \link{f1_score}}.
recall <- function(actual, predicted, w = NULL, ...) {
  stopifnot(all(actual == 0 | actual == 1),
            all(predicted == 0 | predicted == 1))
  weighted_mean(predicted[actual == 1], w = w[actual == 1], ...)
}

