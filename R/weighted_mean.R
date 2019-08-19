#' Weighted Mean
#'
#' Returns weighted mean of a numeric vector. In contrast to \code{stats::weighted.mean}, \code{w} does not need to be specified.
#'
#' @importFrom stats weighted.mean
#' @param x Numeric vector.
#' @param w Optional non-negative case weights.
#' @param ... Further arguments passed to \code{mean} or \code{weighted.mean}.
#' @return A length-one numeric vector.
#' @export
#' @examples
#' weighted_mean(1:10)
#' weighted_mean(1:10, w = NULL)
#' weighted_mean(1:10, w = 1:10)
#' # weighted_mean(1, 0) # Raises error
#' @seealso \code{\link{weighted_quantile}}.
weighted_mean <- function(x, w = NULL, ...) {
  if (is.null(w)) {
    return(mean(x, ...))
  }
  stopifnot(all(w >= 0), length(x) == length(w))
  if (all(w == 0)) {
    stop("All weights are zero")
  }
  weighted.mean(x, w = w, ...)
}
