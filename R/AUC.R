#' Area under the ROC
#'
#' @description Weighted AUC, i.e. the area under the receiver operating curve, based on a deterministic version of \code{glmnet::auc}. Note that the unweighted version can be different from the weighted one with unit weights due to ties in "predicted".
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (not necessarly between 0 and 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed by other methods.
#'
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' AUC(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8))
#' AUC(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8))
#' AUC(c(1, 0, 0, 1), 2 * c(0.1, 0.1, 0.9, 0.8))
#' AUC(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8), w = rep(1, 4)) # different from last due to ties
#' AUC(c(1, 0, 0, 1), c(0.1, 0.2, 0.9, 0.8))
#' AUC(c(1, 0, 0, 1), c(0.1, 0.2, 0.9, 0.8), w = rep(1, 4)) # same as last (no ties)
#' AUC(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' 
#' @seealso \code{\link{gini_coefficient}}.
#' 
AUC <- function(actual, predicted, w = NULL, ...) {
  # Modified version of glmnet::auc
  if (is.null(w)) {
    r <- rank(predicted)
    n_pos <- sum(actual)
    n_neg <- length(actual) - n_pos
    u <- sum(r[actual == 1]) - n_pos * (n_pos + 1) / 2
    return(exp(log(u) - log(n_pos) - log(n_neg)))
  }
  
  op <- order(predicted)
  actual <- actual[op]
  w <- w[op]
  cw <- cumsum(w)
  w_pos <- w[actual == 1]
  cw_pos <- cumsum(w_pos)
  u <- sum(w_pos * (cw[actual == 1] - cw_pos))
  sumw_pos <- cw_pos[length(w_pos)]
  sumw_neg <- cw[length(w)] - sumw_pos
  exp(log(u) - log(sumw_pos) - log(sumw_neg))
}