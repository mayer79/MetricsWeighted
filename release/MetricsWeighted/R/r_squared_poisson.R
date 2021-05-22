#' Pseudo R-Squared regarding Poisson deviance
#'
#' Wrapper to \code{r_squared} with \code{deviance_function = deviance_poisson}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{r_squared}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(0:2, c(0.1, 1, 2), w = rep(1, 3),
#'           deviance_function = deviance_poisson)
#' r_squared_poisson(0:2, c(0.1, 1, 2), w = rep(1, 3))
#' @seealso \code{\link{r_squared}}.
r_squared_poisson <- function(actual, predicted, w = NULL, ...) {
  r_squared(actual = actual, predicted = predicted, w = w,
            deviance_function = deviance_poisson, ...)
}
