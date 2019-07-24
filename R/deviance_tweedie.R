#' Tweedie deviance
#'
#' @description Weighted average of (unscaled) unit Tweedie deviance with parameter p. This includes the normal deviance (p = 0), the Poisson deviance (p = 1), as well as the Gamma deviance (p = 2), see e.g. [1] for a reference.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tweedie_p Tweedie power.
#' @param ... Further arguments passed to \code{weighted_mean}.
#'
#' @return A numeric vector of length one.
#'
#' @export
#'
#' @references
#' [1] Ohlsson E. and Johansson B. (2015). Non-Life Insurance Pricing with Generalized Linear Models. Springer Nature EN. ISBN 978-3642107900.
#'
#' @examples
#' deviance_tweedie(1:10, (1:10)^2, tweedie_p = 0)
#' deviance_tweedie(1:10, (1:10)^2, tweedie_p = 1)
#' deviance_tweedie(1:10, (1:10)^2, tweedie_p = 2)
#' deviance_tweedie(1:10, (1:10)^2, tweedie_p = 1.5)
#' deviance_tweedie(1:10, (1:10)^2, tweedie_p = 1.5, w = rep(1, 10))
#' deviance_tweedie(1:10, (1:10)^2, tweedie_p = 1.5, w = 1:10)
#'
#' @seealso \code{\link{deviance_normal}, \link{deviance_poisson}, \link{deviance_gamma}}.
#'
deviance_tweedie <- function(actual, predicted, w = NULL, tweedie_p = 0, ...) {
   if (tweedie_p == 0) {
    u <- (actual - predicted)^2 / 2
  } else if (tweedie_p == 1) {
    u <- pmax(1e-15, predicted)
    pos <- actual > 0
    u[pos] <- (actual * log(actual / u) - (actual - u))[pos]
  } else if (tweedie_p == 2) {
    predicted <- pmax(1e-15, predicted)
    u <- -log(ifelse(actual == 0, 1, actual / predicted)) + (actual - predicted) / predicted
  } else {
    u <- pmax(actual, 0)^(2 - tweedie_p) / ((1 - tweedie_p) * (2 - tweedie_p)) -
                (actual * predicted^(1 - tweedie_p)) / (1 - tweedie_p) +
      (predicted^(2 - tweedie_p) / (2 - tweedie_p))
  }

  weighted_mean(x = 2 * u, w = w, ...)
}
