#' Area under the ROC
#'
#' Function modified from the {glmnet} package (modified to ensure deterministic results).
#' Calculates weighted AUC, i.e. the area under the receiver operating curve.
#' The larger, the better.
#'
#' The unweighted version can be different from the weighted one with unit weights
#' due to ties in \code{predicted}.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values of any value (not necessarly between 0 and 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed by other methods.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' AUC(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8))
#' AUC(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8))
#' # different from last due to ties 'in predicted':
#' AUC(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8), w = rep(1, 4))
#' @seealso \code{\link{gini_coefficient}}.
AUC <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1)
  )

  # Modified version of glmnet::auc
  if (is.null(w)) {
    r <- rank(predicted)
    n_pos <- sum(actual)
    n_neg <- length(actual) - n_pos
    u <- sum(r[actual == 1]) - n_pos * (n_pos + 1) / 2
    return(exp(log(u) - log(n_pos) - log(n_neg)))
  }
  stopifnot(
    all(w >= 0),
    length(predicted) == length(w)
  )
  if (all(w == 0)) {
    stop("All weights are zero")
  }
  op <- order(predicted)
  actual <- actual[op]
  w <- w[op]
  cw <- cumsum(w)
  w_pos <- w[actual == 1]
  cw_pos <- cumsum(w_pos)
  u <- sum(w_pos * (cw[actual == 1] - cw_pos))
  sumw_pos <- cw_pos[length(w_pos)]
  sumw_neg <- cw[length(w)] - sumw_pos
  exp(log(u) - log(sumw_pos) - log(sumw_neg))
}

#' Gini Coefficient
#'
#' Calculates weighted Gini coefficient, obtained as 2 * AUC - 1.
#' Up to ties in \code{predicted} equivalent to Somer's D.
#' The larger the Gini coefficient, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values of any value (not necessarly between 0 and 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{AUC()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' gini_coefficient(c(0, 0, 1, 1), 2 * c(0.1, 0.1, 0.9, 0.8))
#' gini_coefficient(c(0, 0, 1, 1), c(0.1, 0.6, 0.9, 0.5))
#' gini_coefficient(c(0, 0, 1, 1), c(0.1, 0.6, 0.9, 0.5), w = 1:4)
#' @seealso \code{\link{AUC}}.
gini_coefficient <- function(actual, predicted, w = NULL, ...) {
  -1 + 2 * AUC(actual = actual, predicted = predicted, w = w, ...)
}
