#' Poisson Deviance
#'
#' Weighted average of unit Poisson deviance, see [1]. Special case of Tweedie deviance with Tweedie parameter 1.
#'
#' @param actual Observed non-negative values.
#' @param predicted Strictly positive predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' [1] Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_poisson(0:2, c(0.1, 1, 3))
#' deviance_poisson(0:2, c(0.1, 1, 3), w = c(1, 1, 1))
#' deviance_tweedie(0:2, c(0.1, 1, 3), tweedie_p = 1)
#' deviance_tweedie(0:2, c(0.1, 1, 3), tweedie_p = 1.01)
#' deviance_poisson(0:2, c(0.1, 1, 3), w = 1:3)
#' @seealso \code{\link{deviance_tweedie}}.
deviance_poisson <- function(actual, predicted, w = NULL, ...) {
  stopifnot(all(actual >= 0), all(predicted > 0))
  pos <- actual > 0
  predicted[pos] <- (actual * log(actual / predicted) - (actual - predicted))[pos]
  weighted_mean(x = 2 * predicted, w = w, ...)
}
