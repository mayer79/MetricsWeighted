#' Weighted Mean
#'
#' Returns the weighted mean of a numeric vector.
#' In contrast to [stats::weighted.mean()], `w` does not need to be specified.
#'
#' @param x Numeric vector.
#' @param w Optional vector of non-negative case weights.
#' @param ... Further arguments passed to [mean()] or [stats::weighted.mean()].
#' @returns A length-one numeric vector.
#' @export
#' @examples
#' weighted_mean(1:10)
#' weighted_mean(1:10, w = NULL)
#' weighted_mean(1:10, w = 1:10)
#' @seealso [stats::weighted.mean()]
weighted_mean <- function(x, w = NULL, ...) {
  if (is.null(w)) {
    return(mean(x, ...))
  }
  stopifnot(
    all(w >= 0),
    length(x) == length(w)
  )
  if (all(w == 0)) {
    stop("All weights are zero")
  }
  stats::weighted.mean(x, w = w, ...)
}

#' Weighted Quantiles
#'
#' Calculates weighted quantiles based on the generalized inverse of the weighted ECDF.
#' If no weights are passed, uses [stats::quantile()].
#'
#' @inheritParams weighted_mean
#' @param probs Vector of probabilities.
#' @param na.rm Ignore missing data? Default is `TRUE`.
#' @param names Return names? Default is `TRUE`.
#' @param ... Further arguments passed to [stats::quantile()] in the unweighted case.
#'   Not used in the weighted case.
#' @returns A length-one numeric vector.
#' @export
#' @examples
#' n <- 10
#' x <- seq_len(n)
#' quantile(x)
#' weighted_quantile(x)
#' weighted_quantile(x, w = rep(1, n))
#' quantile(x, type = 1)
#' weighted_quantile(x, w = x) # same as Hmisc::wtd.quantile()
#' weighted_quantile(x, w = x, names = FALSE)
#' weighted_quantile(x, w = x, probs = 0.5, names = FALSE)
#'
#' # Example with integer weights
#' x <- c(1, 1:11, 11, 11)
#' w <- seq_along(x)
#' weighted_quantile(x, w)
#' quantile(rep(x, w)) # same
#' @seealso [weighted_median()]
weighted_quantile <- function(x, w = NULL, probs = seq(0, 1, 0.25),
                              na.rm = TRUE, names = TRUE, ...) {
  # Initial checks and subsetting
  if (is.null(w)) {
    return(stats::quantile(x = x, probs = probs, na.rm = na.rm, names = names, ...))
  }
  stopifnot(
    length(x) == length(w),
    all(probs >= 0 & probs <= 1)
  )

  if (isTRUE(na.rm) && anyNA(x)) {
    ok <- !is.na(x)
    x <- x[ok]
    w <- w[ok]
  }
  stopifnot(
    all(w >= 0),
    length(x) >= 1L
  )
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
    out <- stats::stepfun(cs, x)(probs)
  }
  if (names) {
    names(out) <- paste0(format(100 * probs, trim = TRUE), "%")
  }
  out
}

#' Weighted Median
#'
#' Calculates weighted median based on [weighted_quantile()].
#'
#' @inheritParams weighted_mean
#' @param ... Further arguments passed to [weighted_quantile()].
#' @returns A length-one numeric vector.
#' @export
#' @examples
#' n <- 21
#' x <- seq_len(n)
#' quantile(x, probs = 0.5)
#' weighted_median(x, w = rep(1, n))
#' weighted_median(x, w = x)
#' quantile(rep(x, x), probs = 0.5)
#' @seealso [weighted_quantile()]
weighted_median <- function(x, w = NULL, ...) {
  weighted_quantile(x = x, w = w, probs = 0.5, names = FALSE, ...)
}

#' Weighted Variance
#'
#' Calculates weighted variance, see [stats::cov.wt()] or
#' \url{https://en.wikipedia.org/wiki/Sample_mean_and_covariance#Weighted_samples}
#' for details.
#'
#' @inheritParams weighted_mean
#' @param method Specifies how the result is scaled. If "unbiased", the denomiator
#'   is reduced by 1, see [stats::cov.wt()] for details.
#' @param na.rm Should missing values in `x` be removed? Default is `FALSE`.
#' @param ... Further arguments passed to [stats::cov.wt()].
#' @returns A length-one numeric vector.
#' @export
#' @examples
#' weighted_var(1:10)
#' weighted_var(1:10, w = NULL)
#' weighted_var(1:10, w = rep(1, 10))
#' weighted_var(1:10, w = 1:10)
#' weighted_var(1:10, w = 1:10, method = "ML")
#' @seealso [stats::cov.wt()]
weighted_var <- function(x, w = NULL, method = c("unbiased", "ML"),
                         na.rm = FALSE, ...) {
  method <- match.arg(method)
  cf <- 1
  if (is.null(w)) {
    if (method == "ML") {
      n <- if (na.rm) sum(!is.na(x)) else length(x)
      cf <- (n - 1) / n
    }
    return(cf * stats::var(x, na.rm = na.rm, ...))
  }
  stopifnot(
    all(w >= 0),
    length(x) == length(w)
  )
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
  as.numeric(stats::cov.wt(cbind(x), wt = w, method = method, ...)$cov)
}

#' Weighted Pearson Correlation
#'
#' Calculates weighted Pearson correlation coefficient between actual and predicted
#' values by the help of [stats::cov.wt()].
#'
#' @inheritParams regression
#' @param na.rm Should observations with missing values in `actual` or `predicted`
#'   be removed? Default is `FALSE`.
#' @param ... Further arguments passed to [stats::cov.wt()].
#' @returns A length-one numeric vector.
#' @export
#' @examples
#' weighted_cor(1:10, c(1, 1:9))
#' weighted_cor(1:10, c(1, 1:9), w = 1:10)
weighted_cor <- function(actual, predicted, w = NULL, na.rm = FALSE, ...) {
  stopifnot(length(actual) == length(predicted))
  if (is.null(w)) {
    return(stats::cor(actual, predicted, use = if (na.rm) "p" else "e"))
  }
  stopifnot(
    all(w >= 0),
    length(actual) == length(w)
  )
  if (all(w == 0)) {
    stop("All weights are zero")
  }
  if (na.rm) {
    ok <- !is.na(actual) & !is.na(predicted)
    actual <- actual[ok]
    predicted <- predicted[ok]
    w <- w[ok]
  } else if (anyNA(actual) || anyNA(predicted)) {
    return(NA)
  }
  stats::cov.wt(cbind(actual, predicted), wt = w, cor = TRUE, ...)$cor[1L, 2L]
}
