#' Pseudo R-Squared regarding Gamma deviance
#'
#' Wrapper to \code{r_squared} with \code{deviance_function = deviance_gamma}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{r_squared}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(1:10, c(1:9, 12), w = 1:10, deviance_function = deviance_gamma)
#' r_squared_gamma(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{r_squared}}.
r_squared_gamma <- function(actual, predicted, w = NULL, ...) {
  r_squared(actual = actual, predicted = predicted, w = w,
            deviance_function = deviance_gamma, ...)
}
