#' Generalized R-Squared
#'
#' Returns (weighted) proportion of deviance explained, see reference below.
#' For the mean-squared error as deviance, this equals the usual (weighted) R-squared.
#' The higher, the better.
#'
#' The deviance gain is calculated regarding the null model derived from the actual
#' values. While fine for in-sample considerations, this is only an approximation
#' for out-of-sample considerations. There, it is recommended to calculate null
#' deviance regarding the in-sample (weighted) mean. This value can be passed by
#' the argument \code{reference_mean}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param deviance_function A positive (deviance) function taking four arguments:
#' "actual", "predicted", "w" and "...".
#' @param reference_mean An optional reference mean used to derive the null deviance.
#' Recommended in out-of-sample applications.
#' @param ... Further arguments passed to \code{weighted_mean()} and
#' \code{deviance_function}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' Cohen, Jacob. et al. (2002). Applied Multiple Regression/Correlation Analysis for the Behavioral Sciences (3rd ed.). Routledge. ISBN 978-0805822236.
#' @examples
#' r_squared(1:10, c(1, 1:9))
#' r_squared(1:10, c(1, 1:9), w = 1:10)
#' r_squared(0:2, c(0.1, 1, 2), deviance_function = deviance_poisson)
#' r_squared(0:2, c(0.1, 1, 2), w = rep(1, 3), deviance_function = deviance_poisson)
#' r_squared(
#'   0:2,
#'   c(0.1, 1, 2),
#'   w = rep(1, 3),
#'   deviance_function = deviance_tweedie,
#'   tweedie_p = 1
#' )
#'
#' # With respect to 'own' deviance formula
#' myTweedie <- function(actual, predicted, w = NULL, ...) {
#'   deviance_tweedie(actual, predicted, w, tweedie_p = 1.5, ...)
#' }
#' r_squared(1:10, c(1, 1:9), deviance_function = myTweedie)
#' @seealso \code{\link{deviance_normal}, \link{mse}}.
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

#' Pseudo R-Squared regarding Bernoulli deviance
#'
#' Wrapper to \code{r_squared()} with \code{deviance_function = deviance_bernoulli}.
#'
#' The deviance gain is calculated regarding the null model derived from the actual
#' values. While fine for in-sample considerations, this is only an approximation
#' for out-of-sample considerations. There, it is recommended to calculate null
#' deviance regarding the in-sample (weighted) mean.
#' This value can be passed by the argument \code{reference_mean}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param reference_mean An optional reference mean used to derive the null deviance.
#' Recommended in out-of-sample applications.
#' @param ... Further arguments passed to \code{r_squared()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(
#'   c(0, 0, 1, 1),
#'   c(0.1, 0.1, 0.9, 0.8),
#'   w = 1:4,
#'   deviance_function = deviance_bernoulli
#' )
#' r_squared_bernoulli(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' @seealso \code{\link{r_squared}}.
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

#' Pseudo R-Squared regarding Poisson deviance
#'
#' Wrapper to \code{r_squared} with \code{deviance_function = deviance_poisson}.
#'
#' The deviance gain is calculated regarding the null model derived from the actual
#' values. While fine for in-sample considerations, this is only an approximation for
#' out-of-sample considerations. There, it is recommended to calculate null deviance
#' regarding the in-sample (weighted) mean. This value can be passed by the argument
#' \code{reference_mean}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param reference_mean An optional reference mean used to derive the null deviance.
#' Recommended in out-of-sample applications.
#' @param ... Further arguments passed to \code{r_squared()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(0:2, c(0.1, 1, 2), w = rep(1, 3),
#'           deviance_function = deviance_poisson)
#' r_squared_poisson(0:2, c(0.1, 1, 2), w = rep(1, 3))
#' @seealso \code{\link{r_squared}}.
r_squared_poisson <- function(actual, predicted, w = NULL,
                              reference_mean = NULL, ...) {
  r_squared(actual = actual, predicted = predicted, w = w,
            deviance_function = deviance_poisson,
            reference_mean = reference_mean, ...)
}

#' Pseudo R-Squared regarding Gamma deviance
#'
#' Wrapper to \code{r_squared} with \code{deviance_function = deviance_gamma}.
#'
#' The deviance gain is calculated regarding the null model derived from the actual
#' values. While fine for in-sample considerations, this is only an approximation for
#' out-of-sample considerations. There, it is recommended to calculate null deviance
#' regarding the in-sample (weighted) mean. This value can be passed by the argument
#' \code{reference_mean}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param reference_mean An optional reference mean used to derive the null deviance.
#' Recommended in out-of-sample applications.
#' @param ... Further arguments passed to \code{r_squared()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(1:10, c(1:9, 12), w = 1:10, deviance_function = deviance_gamma)
#' r_squared_gamma(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{r_squared}}.
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
