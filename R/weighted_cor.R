#' Weighted Pearson Correlation
#'
#' Calculates weighted Pearson correlation coefficient between observed and predicted values by the help of \code{stats::cov.wt}.
#'
#' @importFrom stats cor cov.wt
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param na.rm Should missing values in \code{observed} or \code{predicted} be removed? Default is \code{FALSE}.
#' @param ... Further arguments passed to \code{stats::cov.wt}.
#' @return A length-one numeric vector.
#' @export
#' @examples
#' weighted_cor(1:10, c(1, 1:9))
#' cor(1:10, c(1, 1:9))
#' weighted_cor(1:10, c(1, 1:9), w = rep(1, 10))
#' weighted_cor(1:10, c(1, 1:9), w = 1:10)
#' @seealso \code{\link{weighted_mean}}.
weighted_cor <- function(actual, predicted, w = NULL, na.rm = FALSE, ...) {
  stopifnot(length(actual) == length(predicted))
  if (is.null(w)) {
    return(cor(actual, predicted, use = if (na.rm) "p" else "e"))
  }
  stopifnot(all(w >= 0), length(actual) == length(w))
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
  cov.wt(cbind(actual, predicted), wt = w, cor = TRUE, ...)$cor[1, 2]
}

