#' Area under the ROC
#'
#' @importFrom glmnet auc
#'
#' @description Returns weighted AUC, i.e. the area under the receiver operating curve.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (not necessarly between 0 and 1).
#' @param w Optional case weights. Not dealt with currently.
#' @param ... Currently not used.
#'
#' @return A numeric vector of length one.
#' 
#' @export
#'
#' @examples
#' AUC(c(0, 0, 1, 1), 2 * c(0.1, 0.1, 0.9, 0.8))
#' AUC(c(1, 0, 0, 1), c(0.1, 0.1, 0.9, 0.8))
#' AUC(c(0, 0, 1, 1), c(0.1, 0.1, 0.9, 0.8), w = 1:4)
#' 
AUC <- function(actual, predicted, w = NULL, ...) {
  if(is.null(w)) auc(actual, predicted) else auc(actual, predicted, w)
}