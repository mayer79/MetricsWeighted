#' Apply one or more metrics to columns in a data frame
#'
#' @importFrom stats setNames
#'
#' @description Applies one or more metrics to a \code{data.frame} containing columns with actual and predicted values as well as an optional column with case weights. The results are organized as \code{data.frame} and can be used in a \code{dplyr} pipe.
#' @author Michael Mayer, \email{mayermichael79@gmail.com}
#' @param data A \code{data.frame} containing \code{y_var}, \code{pred_var} and possibly \code{w_var}.
#' @param y_var The column name in \code{data} referring to actual values.
#' @param pred_var The column name in \code{data} referring to predicted values.
#' @param w_var the optional column name in \code{data} referring to case weights.
#' @param metrics Either a function or a named list of functions. Each function represents a metric and has four arguments: observed, predicted, case weights and \code{...}.
#' @param metric_name Name of the resulting column containing the name of the metric.
#' @param value_name Name of the resulting column with the value of the metric.
#' @param ... Further arguments passed to the metric functions.
#'
#' @return Data frame with one row per metric and two columns: \code{metric_name} and \code{value_name}.
#'
#' @export
#'
#' @examples
#' ir <- iris
#' ir$fitted <- lm(Sepal.Length ~ ., data = ir)$fitted
#' performance(ir, "Sepal.Length", "fitted")
#' performance(ir, "Sepal.Length", "fitted", metrics = r_squared)
#' performance(ir, "Sepal.Length", "fitted", metrics = c(`R-squared` = r_squared, rmse = rmse))
performance <- function(data, y_var, pred_var, w_var = NULL, metrics = rmse,
                        metric_name = "metric", value_name = "value", ...) {
  stopifnot(c(y_var, pred_var, w_var) %in% names(data))

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
    val <- metric(actual = data[[y_var]], predicted = data[[pred_var]],
                  w_var = if (!is.null(w_var)) data[[w_var]], ...)
    setNames(data.frame(nm, val, row.names = NULL), c(metric_name, value_name))
  }
  out <- do.call(rbind, c(Map(one_metric, metrics, names(metrics)),
                          list(make.row.names = FALSE)))
  out[[metric_name]] <- factor(out[[metric_name]], names(metrics))
  out
}
