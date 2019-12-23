#' Elementary Scoring Function for Expectiles
#'
#' Weighted average of the elementary scoring function for expectiles at level `alpha` with parameter `theta`, see [1].
#' Every choice of `theta` gives a scoring function consistent for the expectile at level `alpha`.
#' Note that the expectile at level `alpha = 0.5` is the expectation (mean).
#' The smaller the score, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param alpha Optional level of expectile.
#' @param theta Optional parameter.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @export
#' @references
#' [1] Ehm, W., Gneiting, T., Jordan, A. and Krüger, F. (2016), Of quantiles and expectiles: consistent scoring functions, Choquet representations and forecast rankings. J. R. Stat. Soc. B, 78: 505-562. \href{https://doi.org/10.1111/rssb.12154}{doi:10.1111/rssb.12154}
#' @examples
#' elemantary_score_expectile(1:10, c(1:9, 12), alpha = 0.5, theta = 1)
#' elemantary_score_expectile(1:10, c(1:9, 12), alpha = 0.5, theta = 1, w = rep(1, 10))
elemantary_score_expectile <- function(actual, predicted, w = NULL, alpha = 0.5, theta = 0, ...) {
  stopifnot(alpha >= 0 && alpha <= 1)

  score <- abs((actual < predicted) - alpha) *
    (positive_part(actual - theta) -
       positive_part(predicted - theta) -
       (actual - predicted) * (theta < predicted)
    )
  
  weighted_mean(x = score, w = w, ...)
}

positive_part <- function(x){
  # slightly faster and less memory than x * (x>=0) and pmax(0, x)
  (x + abs(x))/2
}
