#' Weighted Quantiles
#'
#' Calculates weighted quantiles. Based on linear interpolation of the weighted empirical cdf (like type 4 in stats::quantile). If no weights are passed, uses \code{stats::quantile} with type = 4.
#'
#' @importFrom stats quantile
#' @param x Numeric vector.
#' @param w Optional non-negative case weights.
#' @param probs Vector of probabilities.
#' @param na.rm Ignore missing data?
#' @param names Return names?
#' @param type Quantile type. Only relevant for the unweighted case.
#' @param ... Further arguments passed to \code{stats::quantile} in the unweighted case. Not used in the weighted case.
#' @export
#' @examples
#' n <- 11
#' quantile(seq_len(n), type = 4)
#' weighted_quantile(seq_len(n))
#' weighted_quantile(seq_len(n), w = rep(1, n))
#' weighted_quantile(seq_len(n), w = seq_len(n))
#' weighted_quantile(seq_len(n), w = seq_len(n), names = FALSE)
#' weighted_quantile(seq_len(n), w = seq_len(n), probs = 0.5, names = FALSE)
#' @seealso \code{\link{weighted_median}}.
weighted_quantile <- function(x, w = NULL, probs = seq(0, 1, 0.25),
                              na.rm = TRUE, names = TRUE, type = 4, ...) {
  # Initial checks and subsetting
  if (is.null(w)) {
    return(quantile(x = x, probs = probs, na.rm = na.rm, names = names, type = type, ...))
  }
  stopifnot(length(x) == length(w),
            all(probs >= 0 & probs <= 1))

  if (isTRUE(na.rm) && anyNA(x)) {
    ok <- !is.na(x)
    x <- x[ok]
    w <- w[ok]
  }
  stopifnot(all(w >= 0), length(x) >= 1)
  if (all(w == 0)) {
    stop("All weights are zero")

  }
  if (length(x) == 1L) {
    out <- rep(x, length(probs))
  } else {
    ord <- order(x)
    x <- x[ord]
    w <- w[ord]
    out <- approxfun(cumsum(w) / sum(w), x, rule = 2)(probs)
  }
  if (names) {
    names(out) <- paste0(format(100 * probs, trim = TRUE), "%")
  }
  out
}

