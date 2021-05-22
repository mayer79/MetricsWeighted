#' Pseudo R-Squared regarding Gamma deviance
#'
#' Wrapper to \code{r_squared} with \code{deviance_function = deviance_gamma}.
#'
#' The deviance gain is calculated regarding the null model derived from the actual values. While fine for in-sample considerations, this is only an approximation for out-of-sample considerations. There, it is recommended to calculate null deviance regarding the in-sample (weighted) mean. This value can be passed by the argument \code{reference_mean}.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param reference_mean An optional reference mean used to derive the null deviance. Recommended in out-of-sample applications.
#' @param ... Further arguments passed to \code{r_squared}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' r_squared(1:10, c(1:9, 12), w = 1:10, deviance_function = deviance_gamma)
#' r_squared_gamma(1:10, c(1:9, 12), w = 1:10)
#' @seealso \code{\link{r_squared}}.
r_squared_gamma <- function(actual, predicted, w = NULL,
                            reference_mean = NULL, ...) {
  r_squared(actual = actual, predicted = predicted, w = w,
            deviance_function = deviance_gamma,
            reference_mean = reference_mean, ...)
}
