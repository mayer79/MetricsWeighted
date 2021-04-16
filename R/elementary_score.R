#' Elementary Scoring Function for Expectiles and Quantiles
#'
#' Weighted average of the elementary scoring function for expectiles resp. quantiles at level \code{alpha} with parameter \code{theta}, see reference below.
#' Every choice of \code{theta} gives a scoring function consistent for the expectile resp. quantile at level \code{alpha}.
#' Note that the expectile at level \code{alpha = 0.5} is the expectation (mean).
#' The smaller the score, the better.
#'
#' @name elementary_score
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param alpha Optional level of expectile resp. quantile.
#' @param theta Optional parameter.
#' @param ... Further arguments passed to \code{weighted_mean}.
#' @return A numeric vector of length one.
#' @references
#' Ehm, W., Gneiting, T., Jordan, A. and Krüger, F. (2016), Of quantiles and expectiles: consistent scoring functions, Choquet representations and forecast rankings. J. R. Stat. Soc. B, 78: 505-562, <doi.org/10.1111/rssb.12154>.
#' @examples
#' elementary_score_expectile(1:10, c(1:9, 12), alpha = 0.5, theta = 11)
#' elementary_score_expectile(1:10, c(1:9, 12), alpha = 0.5, theta = 11, w = rep(1, 10))
#' elementary_score_quantile(1:10, c(1:9, 12), alpha = 0.5, theta = 11, w = rep(1, 10))
NULL

#' @rdname elementary_score
#' @export
elementary_score_expectile <- function(actual, predicted, w = NULL, alpha = 0.5, theta = 0, ...) {
  stopifnot(length(alpha) == 1L, alpha >= 0, alpha <= 1,
            length(theta) == 1L,
            length(actual) == length(predicted))

  score <- abs((actual < predicted) - alpha) * (
       .positive_part(actual - theta) -
       .positive_part(predicted - theta) -
       (actual - predicted) * (theta < predicted)
    )

  weighted_mean(x = score, w = w, ...)
}

#' @rdname elementary_score
#' @export
elementary_score_quantile <- function(actual, predicted, w = NULL, alpha = 0.5, theta = 0, ...) {
  stopifnot(length(alpha) == 1L, alpha >= 0, alpha <= 1,
            length(theta) == 1L,
            length(actual) == length(predicted))

  score <- ((actual < predicted) - alpha) *
    ((theta < predicted) - (theta < actual))

  weighted_mean(x = score, w = w, ...)
}

# Helper function
.positive_part <- function(x) {
  (x + abs(x)) / 2
}


