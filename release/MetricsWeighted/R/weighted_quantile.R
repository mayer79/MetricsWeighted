#' Weighted Quantiles
#'
#' Calculates weighted quantiles based on the generalized inverse of the weighted ECDF. If no weights are passed, uses \code{stats::quantile}.
#'
#' @importFrom stats quantile stepfun
#' @param x Numeric vector.
#' @param w Optional non-negative case weights.
#' @param probs Vector of probabilities.
#' @param na.rm Ignore missing data?
#' @param names Return names?
#' @param ... Further arguments passed to \code{stats::quantile} in the unweighted case. Not used in the weighted case.
#' @export
#' @examples
#' n <- 10
#' x <- seq_len(n)
#' quantile(x)
#' weighted_quantile(x)
#' weighted_quantile(x, w = rep(1, n))
#' quantile(x, type = 1)
#' weighted_quantile(x, w = x) # same as Hmisc::wtd.quantile
#' weighted_quantile(x, w = x, names = FALSE)
#' weighted_quantile(x, w = x, probs = 0.5, names = FALSE)
#'
#' # Example with integer weights
#' x <- c(1, 1:11, 11, 11)
#' w <- seq_along(x)
#' weighted_quantile(x, w)
#' quantile(rep(x, w)) # same
#' @seealso \code{\link{weighted_median}}.
weighted_quantile <- function(x, w = NULL, probs = seq(0, 1, 0.25),
                              na.rm = TRUE, names = TRUE, ...) {
  # Initial checks and subsetting
  if (is.null(w)) {
    return(quantile(x = x, probs = probs, na.rm = na.rm, names = names, ...))
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
    w <- w / sum(w)
    cs <- cumsum(w[-length(w)])
    out <- stepfun(cs, x)(probs)
  }
  if (names) {
    names(out) <- paste0(format(100 * probs, trim = TRUE), "%")
  }
  out
}

