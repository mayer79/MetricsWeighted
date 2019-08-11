#' Weighted Median
#'
#' Calculates weighted median.
#'
#' @param x Numeric vector.
#' @param w Optional non-negative case weights.
#' @param ... Further arguments passed to \code{weighted_quantile}.
#' @export
#' @examples
#' n <- 20
#' quantile(seq_len(n), probs = 0.5, type = 4, names = FALSE)
#' weighted_median(seq_len(n), type = 4)
#' weighted_median(seq_len(n), w = rep(1, n))
#' weighted_median(seq_len(n), w = seq_len(n))
#' @seealso \code{\link{weighted_quantile}}.
weighted_median <- function(x, w = NULL, ...) {
  weighted_quantile(x, w, probs = 0.5, names = FALSE, ...)
}

