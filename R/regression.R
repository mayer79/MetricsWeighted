#' Regression Metrics
#'
#' @description
#' Case-weighted versions of typical regression metrics:
#' - `mse()`: Mean-squared error
#' - `rmse()`: Root-mean-squared error.
#' - `mae()`: Mean absolute error
#' - `medae()`: Median absolute error
#' - `mape()`: Mean Absolute Percentage Error
#' - `prop_within()`: Proportion of predictions that are within a given tolerance
#'   around the actual values
#' - `deviance_normal()`: Average (unscaled) normal deviance. Equals MSE, and also the
#'   average Tweedie deviance with \eqn{p = 0}
#' - `deviance_poisson()`: Average (unscaled) Poisson deviance. Equals average Tweedie
#'   deviance with \eqn{p=1}
#' - `deviance_gamma()`: Average (unscaled) Gamma deviance. Equals average Tweedie
#'   deviance with \eqn{p=2}
#' - `deviance_tweedie()`: Average Tweedie deviance with parameter
#'   \eqn{p \in \{0\} \cup [1, \infty)}, see reference.
#'
#' Lower values mean better performance. Notable exception is `prop_within()`,
#' where higher is better.
#'
#' @section Input range:
#' The values of `actual` and `predicted` can be any real numbers, with the following
#' exceptions:
#' - `mape()`: Non-zero observed values.
#' - `deviance_poisson()`: Non-negative observed values, strictly positive predictions.
#' - `deviance_gamma()`: Strictly positive observed values and predictions.
#'
#' @name regression
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tweedie_p Tweedie power \eqn{p \in \{0\} \cup [1, \infty)}.
#' @param tol Predictions in \eqn{[\text{actual} \pm \text{tol}]} count as "within"
#'   (only relevant for [prop_within()]).
#' @param ... Further arguments passed to [weighted_mean()] (no effect for `medae()`).
#' @returns A numeric vector of length one.
#' @examples
#' y <- 1:10
#' pred <- c(1:9, 12)
#' w <- 1:10
#'
#' rmse(y, pred)
#' sqrt(mse(y, pred))  # Same
#'
#' mae(y, pred)
#' mae(y, pred, w = w)
#' medae(y, pred, w = 1:10)
#' mape(y, pred)
#'
#' prop_within(y, pred)
#'
#' deviance_normal(y, pred)
#' deviance_poisson(y, pred)
#' deviance_gamma(y, pred)
#'
#' deviance_tweedie(y, pred, tweedie_p = 0)  # Normal
#' deviance_tweedie(y, pred, tweedie_p = 1)  # Poisson
#' deviance_tweedie(y, pred, tweedie_p = 2)  # Gamma
#' deviance_tweedie(y, pred, tweedie_p = 1.5, w = 1:10)
#'
#' @references
#'   Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC.
#'     ISBN 978-0412997112.
NULL

#' @rdname regression
#' @export
mse <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean((actual - predicted)^2, w = w, ...)
}

#' @rdname regression
#' @export
rmse <- function(actual, predicted, w = NULL, ...) {
  sqrt(mse(actual = actual, predicted = predicted, w = w, ...))
}

#' @rdname regression
#' @export
mae <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(abs(actual - predicted), w = w, ...)
}

#' @rdname regression
#' @export
medae <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_median(abs(actual - predicted), w = w, ...)
}

#' @rdname regression
#' @export
mape <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual != 0)
  )
  val <- abs(actual - predicted) / abs(actual)
  100 * weighted_mean(val, w = w, ...)
}

#' @rdname regression
#' @export
prop_within <- function(actual, predicted, w = NULL, tol = 1, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(abs(actual - predicted) <= tol, w = w, ...)
}

#' @rdname regression
#' @export
deviance_normal <- function(actual, predicted, w = NULL, ...) {
  mse(actual = actual, predicted = predicted, w = w, ...)
}

#' @rdname regression
#' @export
deviance_poisson <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual >= 0),
    all(predicted > 0)
  )
  pos <- actual > 0
  predicted[pos] <- (actual * log(actual / predicted) - (actual - predicted))[pos]
  weighted_mean(x = 2 * predicted, w = w, ...)
}

#' @rdname regression
#' @export
deviance_gamma <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(predicted > 0),
    all(actual > 0)
  )
  u <- -log(ifelse(actual == 0, 1, actual / predicted)) +
    (actual - predicted) / predicted
  weighted_mean(x = 2 * u, w = w, ...)
}

#' @rdname regression
#' @export
deviance_tweedie <- function(actual, predicted, w = NULL, tweedie_p = 0, ...) {
  stopifnot(tweedie_p <= 0 || tweedie_p >= 1)

  # Catch special cases
  if (tweedie_p %in% 0:2) {
    if (tweedie_p == 0) {
      fun <- deviance_normal
    } else if (tweedie_p == 1) {
      fun <- deviance_poisson
    } else {
      fun <- deviance_gamma
    }
    return(fun(actual = actual, predicted = predicted, w = w, ...))
  }
  # General Tweedie case
  stopifnot(
    length(actual) == length(predicted),
    all(predicted > 0)
  )
  if (tweedie_p >= 1 && tweedie_p < 2) {
    stopifnot(all(actual >= 0))
  }
  if (tweedie_p >= 2) {
    stopifnot(all(actual > 0))
  }
  u <- pmax(actual, 0)^(2 - tweedie_p) / ((1 - tweedie_p) * (2 - tweedie_p)) -
    (actual * predicted^(1 - tweedie_p)) / (1 - tweedie_p) +
    (predicted^(2 - tweedie_p) / (2 - tweedie_p))
  weighted_mean(x = 2 * u, w = w, ...)
}
