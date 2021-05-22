#' Weighted Variance
#'
#' Calculates weighted variance, see \code{stats::cov.wt} or \url{https://en.wikipedia.org/wiki/Sample_mean_and_covariance#Weighted_samples} for details.
#'
#' @importFrom stats var cov.wt
#' @param x Numeric vector.
#' @param w Optional non-negative, non-missing case weights.
#' @param method Specifies how the result is scaled. If "unbiased", the denomiator is reduced by -1, unlike "ML". See \code{stats::cov.wt} for details.
#' @param na.rm Should missing values in \code{x} be removed? Default is \code{FALSE}.
#' @param ... Further arguments passed to \code{stats::cov.wt}.
#' @return A length-one numeric vector.
#' @export
#' @examples
#' weighted_var(1:10)
#' weighted_var(1:10, w = NULL)
#' weighted_var(1:10, w = rep(1, 10))
#' weighted_var(1:10, w = 1:10)
#' weighted_var(1:10, w = 1:10, method = "ML")
#' @seealso \code{\link{weighted_mean}}.
weighted_var <- function(x, w = NULL, method = c("unbiased", "ML"),
                         na.rm = FALSE, ...) {
  method <- match.arg(method)
  cf <- 1
  if (is.null(w)) {
    if (method == "ML") {
      n <- if (na.rm) sum(!is.na(x)) else length(x)
      cf <- (n - 1) / n
    }
    return(cf * var(x, na.rm = na.rm, ...))
  }
  stopifnot(all(w >= 0), length(x) == length(w))
  if (all(w == 0)) {
    stop("All weights are zero")
  }
  if (na.rm) {
    ok <- !is.na(x)
    x <- x[ok]
    w <- w[ok]
  } else if (anyNA(x)) {
    return(NA)
  }
  as.numeric(cov.wt(cbind(x), wt = w, method = method, ...)$cov)
}

