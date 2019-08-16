#' Weighted Median
#'
#' Calculates weighted median. For odd sample sizes consistent with unweighted quantiles.
#'
#' @param x Numeric vector.
#' @param w Optional non-negative case weights.
#' @param ... Further arguments passed to \code{weighted_quantile}.
#' @export
#' @examples
#' n <- 21
#' x <- seq_len(n)
#' quantile(x, probs = 0.5)
#' weighted_median(x, w = rep(1, n))
#' weighted_median(x, w = x)
#' quantile(rep(x, x), probs = 0.5)
#' @seealso \code{\link{weighted_quantile}}.
weighted_median <- function(x, w = NULL, ...) {
  weighted_quantile(x = x, w = w, probs = 0.5, names = FALSE, ...)
}

