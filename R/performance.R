#' Apply one or more metrics to columns in a data set
#'
#' @importFrom stats setNames
#'
#' @description Applies one or more metrics to a \code{data.frame} containing columns with actual and predicted values as well as an optional column with case weights. The results are returned as a \code{data.frame} and can be used in a \code{dplyr} pipe.
#'
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param data A \code{data.frame} containing \code{actual}, \code{predicted} and possibly \code{w}.
#' @param actual The column name in \code{data} referring to actual values.
#' @param predicted The column name in \code{data} referring to predicted values.
#' @param w The optional column name in \code{data} referring to case weights.
#' @param metrics Either a function or a named list of functions. Each function represents a metric and has four arguments: observed, predicted, case weights and \code{...}. If not a named list but a single function, the name of the function is guessed by \code{deparse(substitute(...))}, which would not provide the actual name of the function if called within \code{lapply} etc. In such cases, you can pass a named list with one element, e.g. \code{list(rmse = rmse)}.
#' @param key Name of the resulting column containing the name of the metric. Defaults to "metric".
#' @param value Name of the resulting column with the value of the metric. Defaults to "value".
#' @param ... Further arguments passed to the metric functions, e.g. if the metric is "r_squared", you could pass the relevant deviance function as additional argument (see examples).
#'
#' @return Data frame with one row per metric and two columns: \code{key} and \code{value}.
#'
#' @export
#'
#' @examples
#' ir <- iris
#' ir$fitted <- lm(Sepal.Length ~ ., data = ir)$fitted
#' performance(ir, "Sepal.Length", "fitted")
#' performance(ir, "Sepal.Length", "fitted", metrics = r_squared)
#' performance(ir, "Sepal.Length", "fitted", metrics = c(`R-squared` = r_squared, rmse = rmse))
#' performance(ir, "Sepal.Length", "fitted", metrics = r_squared,
#'             deviance_function = deviance_gamma)
#' performance(ir, "Sepal.Length", "fitted", metrics = r_squared,
#'             deviance_function = deviance_tweedie)
#' performance(ir, "Sepal.Length", "fitted", metrics = r_squared,
#'             deviance_function = deviance_tweedie, tweedie_p = 2)
#' performance(ir, "Sepal.Length", "fitted", metrics = r_squared,
#'             deviance_function = deviance_tweedie, tweedie_p = 0)
performance <- function(data, actual, predicted, w = NULL, metrics = rmse,
                        key = "metric", value = "value", ...) {
  stopifnot(c(actual, predicted, w) %in% names(data))

  if (is.list(metrics)) {
    if (is.null(names(metrics))) {
      stop("List of metrics needs to be named.")
    }
  } else {
    metrics <- setNames(list(metrics), deparse(substitute(metrics)))
  }

  one_metric <- function(metric, nm) {
    if (!is.function(metric)) {
      stop("Metric does not appear to be a function.")
    }
    val <- metric(actual = data[[actual]], predicted = data[[predicted]],
                  w = if (!is.null(w)) data[[w]], ...)
    setNames(data.frame(nm, val, row.names = NULL), c(key, value))
  }
  out <- do.call(rbind, c(Map(one_metric, metrics, names(metrics)),
                          list(make.row.names = FALSE)))
  out[[key]] <- factor(out[[key]], names(metrics))
  out
}
