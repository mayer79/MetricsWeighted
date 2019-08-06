#' Weighted mean that handles NULL weights
#'
#' Returns weighted mean of numeric vector.
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
weighted_mean <- function(x, w = NULL, ...) {
  if (is.null(w)) {
    return(mean(x, ...))
  }
  stopifnot(all(w >= 0))
  weighted.mean(x, w = w, ...)
}
