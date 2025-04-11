#' Classification Metrics
#'
#' @description
#' Weighted versions of non-probabilistic and probabilistic classification metrics:
#' - `accuracy()`: Accuracy (higher is better).
#' - `classification_error()`: Classification error = 1 - Accuracy (lower is better).
#' - `precision()`: Precision (higher is better).
#' - `recall()`: Recall (higher is better).
#' - `f1_score()`: F1 Score. Harmonic mean of precision and recall (higher is better).
#' - `AUC()`: Area under the ROC (higher is better).
#' - `gini_coefficient()`: Gini coefficient, equivalent to \eqn{2 \cdot \textrm{AUC} - 1}.
#'   Up to ties in `predicted`, equivalent to Somer's D (higher is better).
#' - `deviance_bernoulli()`: Average Bernoulli deviance. Equals twice the
#'   log loss/binary cross entropy (smaller is better).
#' - `logLoss()`: Log loss/binary cross entropy. Equals half the average Bernoulli
#'   deviance (smaller is better).
#'
#' @section Input ranges:
#' - For `precision()`, `recall()`, and `f1_score()`: The `actual` and `predicted` values
#'   need to be in \eqn{\{0, 1\}}.
#' - For `accuracy()` and `classification_error()`: Any discrete input.
#' - For `AUC()` and `gini_coefficient()`: Only `actual` must be in \eqn{\{0, 1\}}.
#' - For `deviance_bernoulli()` and `logLoss()`: The values of `actual` must be in
#'   \eqn{\{0, 1\}}, while `predicted` must be in the closed interval \eqn{[0, 1]}.
#'
#' @details
#' Note that the function `AUC()` was originally modified from the 'glmnet' package
#' to ensure deterministic results. The unweighted version can be different from the
#' weighted one with unit weights due to ties in `predicted`.
#'
#' @name classification
#'
#' @inheritParams regression
#' @param ... Further arguments passed to [weighted_mean()]
#'   (no effect for `AUC()` and `gini_coefficient()`).
#' @returns A numeric vector of length one.
#' @examples
#' y <- c(0, 0, 1, 1)
#' pred <- c(0, 0, 1, 0)
#' w <- y * 2
#'
#' accuracy(y, pred)
#' classification_error(y, pred, w = w)
#' precision(y, pred, w = w)
#' recall(y, pred, w = w)
#' f1_score(y, pred, w = w)
#'
#' y2 <- c(0, 1, 0, 1)
#' pred2 <- c(0.1, 0.1, 0.9, 0.8)
#' w2 <- 1:4
#'
#' AUC(y2, pred2)
#' AUC(y2, pred2, w = rep(1, 4)) # Different due to ties in predicted
#'
#' gini_coefficient(y2, pred2, w = w2)
#' logLoss(y2, pred2, w = w2)
#' deviance_bernoulli(y2, pred2, w = w2)
NULL

#' @rdname classification
#' @export
accuracy <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  return(weighted_mean(actual == predicted, w = w, ...))
}

#' @rdname classification
#' @export
classification_error <- function(actual, predicted, w = NULL, ...) {
  return(1 - accuracy(actual = actual, predicted = predicted, w = w, ...))
}

#' @rdname classification
#' @export
precision <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1),
    all(predicted == 0 | predicted == 1)
  )
  return(weighted_mean(actual[predicted == 1], w = w[predicted == 1], ...))
}

#' @rdname classification
#' @export
recall <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1),
    all(predicted == 0 | predicted == 1)
  )
  return(weighted_mean(predicted[actual == 1], w = w[actual == 1], ...))
}

#' @rdname classification
#' @export
f1_score <- function(actual, predicted, w = NULL, ...) {
  p <- precision(actual = actual, predicted = predicted, w = w, ...)
  r <- recall(actual = actual, predicted = predicted, w = w, ...)
  return(2 * (p * r) / (p + r))
}

#' @rdname classification
#' @export
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
  return(exp(log(u) - log(sumw_pos) - log(sumw_neg)))
}

#' @rdname classification
#' @export
gini_coefficient <- function(actual, predicted, w = NULL, ...) {
  return(-1 + 2 * AUC(actual = actual, predicted = predicted, w = w, ...))
}

#' @rdname classification
#' @export
deviance_bernoulli <- function(actual, predicted, w = NULL, ...) {
  return(2 * logLoss(actual = actual, predicted = predicted, w = w, ...))
}

#' @rdname classification
#' @export
logLoss <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1),
    all(predicted >= 0 & predicted <= 1)
  )
  losses <- -xlogy(actual, predicted) - xlogy(1 - actual, 1 - predicted)
  return(weighted_mean(losses, w = w, ...))
}

# Helper function

#' Calculates x*log(y)
#'
#' Internal function originally implemented in 'hstats'.
#' Returns 0 whenever x = 0 and y >= 0.
#'
#' @noRd
#' @keywords internal
#'
#' @param x A numeric vector/matrix.
#' @param y A numeric vector/matrix.
#' @returns A numeric vector or matrix.
xlogy <- function(x, y) {
  out <- x * log(y)
  out[x == 0] <- 0
  return(out)
}
