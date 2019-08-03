#' Gamma deviance
#'
#' Weighted average of (unscaled) unit Gamma deviance, see e.g. [1]. Special case of Tweedie deviance with Tweedie parameter 2.
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
#' deviance_gamma(1:10, c(1:9, 12))
#' deviance_gamma(1:10, c(1:9, 12), w = rep(1, 10))
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 2)
#' deviance_tweedie(1:10, c(1:9, 12), tweedie_p = 1.99)
#' deviance_gamma(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{deviance_tweedie}}.
deviance_gamma <- function(actual, predicted, w = NULL, ...) {
  predicted <- pmax(1e-15, predicted)
  u <- -log(ifelse(actual == 0, 1, actual / predicted)) +
    (actual - predicted) / predicted
  weighted_mean(x = 2 * u, w = w, ...)
}
