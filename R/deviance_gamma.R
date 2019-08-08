#' Gamma deviance
#'
#' Weighted average of (unscaled) unit Gamma deviance, see e.g. [1]. Special case of Tweedie deviance with Tweedie parameter 2. The smaller the deviance, the better the model.
#'
#' @param actual Strictly positive observed values.
#' @param predicted Strictly positive predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' [1] Jorgensen, B. (1997). The Theory of Dispersion Models. Chapman & Hall/CRC. ISBN 978-0412997112.
#' @examples
#' deviance_gamma(1:10, c(1:9, 12))
#' deviance_gamma(1:10, c(1:9, 12), w = rep(1, 10))
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 2)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.99)
#' deviance_gamma(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{deviance_tweedie}}.
deviance_gamma <- function(actual, predicted, w = NULL, ...) {
  stopifnot(all(predicted > 0), all(actual > 0))
  u <- -log(ifelse(actual == 0, 1, actual / predicted)) +
    (actual - predicted) / predicted
  weighted_mean(x = 2 * u, w = w, ...)
}
