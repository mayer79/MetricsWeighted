#' Pseudo R-Squared regarding Tweedie deviance
#'
#' Wrapper to \code{r_squared} with \code{deviance_function = deviance_tweedie}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tweedie_p Tweedie power.
#' @param ... Further arguments passed to \code{r_squared}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(0:2, c(0.1, 1, 2), w = rep(1, 3),
#'   deviance_function = deviance_tweedie, tweedie_p = 1.5)
#' r_squared_tweedie(0:2, c(0.1, 1, 2), w = rep(1, 3), tweedie_p = 1.5)
#' @seealso \code{\link{r_squared}}.
r_squared_tweedie <- function(actual, predicted, w = NULL, tweedie_p = 0, ...) {
  r_squared(actual = actual, predicted = predicted, w = w,
            deviance_function = deviance_tweedie, tweedie_p = tweedie_p, ...)
}
