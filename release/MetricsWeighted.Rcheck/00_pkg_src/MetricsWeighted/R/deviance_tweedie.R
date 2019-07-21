#' Tweedie deviance
#'
#' @description Returns (average) weighted Tweedie deviance with parameter p. This includes the normal deviance (p = 0), the Poisson deviance (p = 1), as well as the Gamma deviance (p = 2). 
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param p Tweedie power.
#' @param ... Further arguments passed to \code{weighted_mean}.
#'
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' deviance_tweedie(1:10, (1:10)^2, p = 0)
#' deviance_tweedie(1:10, (1:10)^2, p = 1)
#' deviance_tweedie(1:10, (1:10)^2, p = 2)
#' deviance_tweedie(1:10, (1:10)^2, p = 1.5)
#' deviance_tweedie(1:10, (1:10)^2, p = 1.5, w = rep(1, 10))
#' deviance_tweedie(1:10, (1:10)^2, p = 1.5, w = 1:10)
deviance_tweedie <- function(actual, predicted, w = NULL, p = 1, ...) {
  if (p == 0) {
    u <- (actual - predicted)^2 / 2
  } else if (p == 1) {
    u <- pmax(1e-15, predicted)
    pos <- actual > 0
    u[pos] <- (actual * log(actual / u) - (actual - u))[pos]
  } else if (p == 2) {
    predicted <- pmax(1e-15, predicted)
    u <- -log(ifelse(actual == 0, 1, actual / predicted)) + (actual - predicted) / predicted
  } else {
    u <- pmax(actual, 0)^(2 - p) / ((1 - p) * (2 - p)) -
                (actual * predicted^(1 - p)) / (1 - p) + (predicted^(2 - p) / (2 - p))
  }
  
  weighted_mean(2 * u, w, ...)
}
