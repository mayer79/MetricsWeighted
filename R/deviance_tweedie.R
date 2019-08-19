#' Tweedie Deviance
#'
#' Weighted average of (unscaled) unit Tweedie deviance with parameter p. This includes the normal deviance (p = 0), the Poisson deviance (p = 1), as well as the Gamma deviance (p = 2), see [1] for a reference and \url{https://en.wikipedia.org/wiki/Tweedie_distribution} for the specific deviance formula. For 0 < p < 1, the distribution is not defined. The smaller the deviance, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param tweedie_p Tweedie power.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' [1] Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 0)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 2)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.5)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.5, w = rep(1, 10))
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.5, w = 1:10)
#' @seealso \code{\link{deviance_normal}, \link{deviance_poisson}, \link{deviance_gamma}}.
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
  stopifnot(length(actual) == length(predicted),
            all(predicted > 0))
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
