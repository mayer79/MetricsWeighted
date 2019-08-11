#' Weighted Quantiles
#'
#' Function copied (and adapted) from spatstat package. Based on linear interpolation of the weighted empirical cdf (like type 4 in stats::quantile).
#'
#' @importFrom stats quantile
#' @param x Numeric vector.
#' @param w Optional non-negative case weights.
#' @param probs Vector of probabilities.
#' @param na.rm Ignore missing data?
#' @param names Return names?
#' @param ... Further arguments passed to \code{stats::quantile} in the unweighted case. Not used in the weighted case.
#' @export
#' @examples
#' n <- 11
#' quantile(seq_len(n))
#' weighted_quantile(seq_len(n), type = 4)
#' weighted_quantile(seq_len(n), w = rep(1, n))
#' weighted_quantile(seq_len(n), w = seq_len(n))
#' weighted_quantile(seq_len(n), w = seq_len(n), names = FALSE)
#' weighted_quantile(seq_len(n), w = seq_len(n), probs = 0.5, names = FALSE)
#' @seealso \code{\link{weighted_median}}.
weighted_quantile <- function(x, w = NULL, probs = seq(0, 1, 0.25),
                              na.rm = TRUE, names = TRUE, ...) {
  if (is.null(w)) {
    return(quantile(x = x, probs = probs, na.rm = na.rm, names = names, ...))
  }
  if (isTRUE(na.rm) && anyNA(x)) {
    ok <- !is.na(x)
    x <- x[ok]
    w <- w[ok]
  }
  stopifnot(all(w >= 0))
  if (all(w == 0)) {
    stop("All weights are zero")
  }

  oo <- order(x)
  x <- x[oo]
  w <- w[oo]
  Fx <- cumsum(w) / sum(w)

  result <- numeric(length(probs))

  for (i in seq_along(result)) {
    p <- probs[i]
    lefties <- which(Fx <= p)
    if (length(lefties) == 0) {
      result[i] <- x[1]
    } else {
      left <- max(lefties)
      result[i] <- x[left]
      if (Fx[left] < p && left < length(x)) {
        right <- left + 1
        y <- x[left] + (x[right] - x[left]) * (p - Fx[left]) / (Fx[right] - Fx[left])
        if (is.finite(y)) result[i] <- y
      }
    }
  }
  if (names) {
    names(result) <- paste0(format(100 * probs, trim = TRUE), "%")
  }
  result
}

