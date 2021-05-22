#' Multiple Metrics
#'
#' Provides a way to create a list of metrics/scoring functions/performance measures from a parametrized function like the Tweedie deviance or the elementary scoring functions for expectiles.
#'
#' @importFrom stats setNames
#' @param fun A metric/scoring function/performance measure with additional parameter to be varied.
#' @param ... Further arguments passed to \code{fun}, including one varying parameter (specified by a vector).
#' @return A named list of functions.
#' @export
#' @examples
#' data <- data.frame(act = 1:10, pred = c(1:9, 12))
#' multi <- multi_metric(fun = deviance_tweedie,
#'                       tweedie_p = c(0, seq(1, 3, by = 0.1)))
#' performance(data, actual = "act", predicted = "pred", metrics = multi)
#' multi <- multi_metric(fun = r_squared, deviance_function = deviance_tweedie,
#'                       tweedie_p = c(0, seq(1, 3, by = 0.1)))
#' performance(data, actual = "act", predicted = "pred", metrics = multi)
#' multi <- multi_metric(fun = elementary_score_expectile,
#'                       theta = 1:11, alpha = 0.1)
#' performance(data, actual = "act", predicted = "pred",
#'             metrics = multi, key = "theta")
#' multi <- multi_metric(fun = elementary_score_expectile,
#'                       theta = 1:11, alpha = 0.5)
#' performance(data, actual = "act", predicted = "pred",
#'             metrics = multi, key = "theta")
#' @seealso \code{\link{performance}}.
multi_metric <- function(fun, ...) {
  stopifnot(is.function(fun),
            length(param <- list(...)) >= 1L)
  # Determine varying argument in ...
  len <- vapply(param, length, FUN.VALUE = numeric(1))
  varying <- names(which(len > 1))
  if (length(varying) > 1L) {
    stop("Only one parameter may vary.")
  } else if (length(varying) == 0L) {
    varying <- names(len)[1]
  }
  # Create function
  base_fun <- function(p) function(actual, predicted, w = NULL, ...)
    do.call(fun, c(list(actual = actual, predicted = predicted, w = w),
                    setNames(list(p), varying),
                    param[setdiff(names(len), varying)],
                    ...))
  setNames(lapply(param[[varying]], base_fun), param[[varying]])
}


