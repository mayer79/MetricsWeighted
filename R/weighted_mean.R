#' Weighted mean that handles NULL weights
#'
#' @importFrom stats weighted.mean
#' 
#' @description Returns weighted mean of numeric vector.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param x Numeric vector.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean}.

#' @return A length-one numeric vector.
#' 
#' @export
#'
#' @examples
#' weighted_mean(1:10)
#' weighted_mean(1:10, w = NULL)
#' weighted_mean(1:10, w = 1:10)
weighted_mean <- function(x, w = NULL, ...) {
  if (is.null(w)) {
    return(mean(x, ...))
  }
  weighted.mean(x, w, ...)
}