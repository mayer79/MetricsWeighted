#' Poisson deviance
#'
#' Weighted average of unit Poisson deviance, see e.g. [1]. Special case of Tweedie deviance with Tweedie parameter 1.
#'
#' @author Michael Mayer
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' [1] Ohlsson E. and Johansson B. (2015). Non-Life Insurance Pricing with Generalized Linear Models. Springer Nature EN. ISBN 978-3642107900.
#' @examples
#' deviance_poisson(0:2, c(0.1, 1, 3))
#' deviance_poisson(0:2, c(0.1, 1, 3), w = c(1, 1, 1))
#' deviance_tweedie(0:2, c(0.1, 1, 3), tweedie_p = 1)
#' deviance_tweedie(0:2, c(0.1, 1, 3), tweedie_p = 1.01)
#' deviance_poisson(0:2, c(0.1, 1, 3), w = 1:3)
#' @seealso \code{\link{deviance_tweedie}}.
deviance_poisson <- function(actual, predicted, w = NULL, ...) {
  u <- pmax(1e-15, predicted)
  pos <- actual > 0
  u[pos] <- (actual * log(actual / u) - (actual - u))[pos]
  weighted_mean(x = 2 * u, w = w, ...)
}
