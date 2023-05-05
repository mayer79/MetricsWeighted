#' Generalized R-Squared
#'
#' @description
#' Returns (weighted) proportion of deviance explained, see reference below.
#' For the mean-squared error as deviance, this equals the usual (weighted) R-squared.
#' The higher, the better.
#'
#' The convenience functions
#' - [r_squared_poisson()],
#' - [r_squared_gamma()], and
#' - [r_squared_bernoulli()]
#'
#' call the function [r_squared(..., deviance_function = fun)] with the right deviance
#' function.
#'
#' @details
#' The deviance gain is calculated regarding the null model derived from the actual
#' values. While fine for in-sample considerations, this is only an approximation
#' for out-of-sample considerations. There, it is recommended to calculate null
#' deviance regarding the in-sample (weighted) mean. This value can be passed by
#' the argument `reference_mean`.
#'
#' @name rsquared
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param deviance_function A positive (deviance) function taking four arguments:
#'   "actual", "predicted", "w" and "...".
#' @param reference_mean An optional reference mean used to derive the null deviance.
#'   Recommended in out-of-sample applications.
#' @param ... Further arguments passed to [weighted_mean()] and `deviance_function()`.
#' @returns A numeric vector of length one.
#' @references
#'   Cohen, Jacob. et al. (2002). Applied Multiple Regression/Correlation Analysis for
#'     the Behavioral Sciences (3rd ed.). Routledge. ISBN 978-0805822236.
#' @examples
#' y <- 1:10
#' pred <- c(1, 1:9))
#' w <- 1:10
#'
#' r_squared(y, pred)
#' r_squared(y, pred, w = w)
#'
#' r_squared(y, pred, w = w, deviance_function = deviance_gamma)
#' r_squared_gamma(y, pred, w = w)
#'
#' # Poisson situation
#' y2 <- 0:2
#' pred2 <- c(0.1, 1, 2)
#' r_squared(y2, pred2, deviance_function = deviance_poisson)
#' r_squared_poisson(y2, pred2)
#'
#' # Binary (probabilistic) classification
#' y3 <- c(0, 0, 1, 1)
#' pred3 <- c(0.1, 0.1, 0.9, 0.8)
#' r_squared_bernoulli(y3, pred3, w = 1:4)
#'
#' # With respect to 'own' deviance formula
#' myTweedie <- function(actual, predicted, w = NULL, ...) {
#'   deviance_tweedie(actual, predicted, w, tweedie_p = 1.5, ...)
#' }
#' r_squared(y, pred, deviance_function = myTweedie)
NULL

#' @rdname rsquared
#' @export
r_squared <- function(actual, predicted, w = NULL, deviance_function = mse,
                      reference_mean = NULL, ...) {
  stopifnot(is.function(deviance_function))
  if (is.null(reference_mean)) {
    actual_mean <- rep(weighted_mean(actual, w = w, ...), length(actual))
  } else {
    stopifnot(length(reference_mean) == 1L)
    actual_mean <- rep(reference_mean, length(actual))
  }
  d0 <- deviance_function(actual = actual, predicted = actual_mean, w = w, ...)
  dres <- deviance_function(actual = actual, predicted = predicted, w = w, ...)
  1 - dres / d0
}

#' @rdname rsquared
#' @export
r_squared_poisson <- function(actual, predicted, w = NULL, reference_mean = NULL, ...) {
  r_squared(
    actual = actual,
    predicted = predicted,
    w = w,
    deviance_function = deviance_poisson,
    reference_mean = reference_mean,
    ...
  )
}

#' @rdname rsquared
#' @export
r_squared_gamma <- function(actual, predicted, w = NULL, reference_mean = NULL, ...) {
  r_squared(
    actual = actual,
    predicted = predicted,
    w = w,
    deviance_function = deviance_gamma,
    reference_mean = reference_mean,
    ...
  )
}

#' @rdname rsquared
#' @export
r_squared_bernoulli <- function(actual, predicted, w = NULL,
                                reference_mean = NULL, ...) {
  r_squared(
    actual = actual,
    predicted = predicted,
    w = w,
    deviance_function = deviance_bernoulli,
    reference_mean = reference_mean,
    ...
  )
}
