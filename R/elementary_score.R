#' Elementary Scoring Function for Expectiles and Quantiles
#'
#' Weighted average of the elementary scoring function for expectiles or quantiles at
#' level \eqn{\alpha} with parameter \eqn{\theta}, see reference below.
#' Every choice of \eqn{\theta} gives a scoring function consistent for the expectile
#' or quantile at level \eqn{\alpha}.
#' Note that the expectile at level \eqn{\alpha = 0.5} is the expectation (mean).
#' The smaller the score, the better.
#'
#' @name elementary_score
#'
#' @inheritParams regression
#' @param alpha Level of expectile or quantile. The default `alpha = 0.5`
#'   corresponds to the expectation/median.
#' @param theta Evaluation point.
#' @param ... Further arguments passed to [weighted_mean()].
#' @returns A numeric vector of length one.
#' @references
#'   Ehm, W., Gneiting, T., Jordan, A. and Krüger, F. (2016), Of quantiles and
#'     expectiles: consistent scoring functions, Choquet representations and forecast
#'     rankings. J. R. Stat. Soc. B, 78: 505-562, <doi.org/10.1111/rssb.12154>.
#' @examples
#' elementary_score_expectile(1:10, c(1:9, 12), alpha = 0.5, theta = 11)
#' elementary_score_quantile(1:10, c(1:9, 12), alpha = 0.5, theta = 11)
#' @seealso [murphy_diagram()]
NULL

#' @rdname elementary_score
#' @export
elementary_score_expectile <- function(actual, predicted, w = NULL,
                                       alpha = 0.5, theta = 0, ...) {
  stopifnot(
    length(alpha) == 1L,
    alpha >= 0,
    alpha <= 1,
    length(theta) == 1L,
    length(actual) == length(predicted)
  )

  score <- abs((actual < predicted) - alpha) * (
       .positive_part(actual - theta) -
       .positive_part(predicted - theta) -
       (actual - predicted) * (theta < predicted)
    )

  weighted_mean(x = score, w = w, ...)
}

#' @rdname elementary_score
#' @export
elementary_score_quantile <- function(actual, predicted, w = NULL,
                                      alpha = 0.5, theta = 0, ...) {
  stopifnot(
    length(alpha) == 1L,
    alpha >= 0,
    alpha <= 1,
    length(theta) == 1L,
    length(actual) == length(predicted)
  )

  score <- ((actual < predicted) - alpha) * ((theta < predicted) - (theta < actual))
  weighted_mean(x = score, w = w, ...)
}

# Helper function
.positive_part <- function(x) {
  (x + abs(x)) / 2
}


