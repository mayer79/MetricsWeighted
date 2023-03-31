#' Accuracy
#'
#' Calculates weighted accuracy, i.e. the weighted proportion of elements in
#' \code{predicted} that are equal to those in \code{actual}. The higher, the better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' accuracy(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' accuracy(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{classification_error}}.
accuracy <- function(actual, predicted, w = NULL, ...) {
  stopifnot(length(actual) == length(predicted))
  weighted_mean(actual == predicted, w = w, ...)
}

#' Classification Error
#'
#' Calculates weighted classification error, i.e. the weighted proportion of elements
#' in \code{predicted} that are unequal to those in \code{observed}.
#' Equals 1 - accuracy, thus lower values are better.
#'
#' @param actual Observed values.
#' @param predicted Predicted values.
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{accuracy()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' classification_error(c(1, 0, 0, 1), c(0, 0, 1, 1))
#' classification_error(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{accuracy}}.
classification_error <- function(actual, predicted, w = NULL, ...) {
  1 - accuracy(actual = actual, predicted = predicted, w = w, ...)
}

#' Precision
#'
#' Calculates weighted precision,
#' see \url{https://en.wikipedia.org/wiki/Precision_and_recall} for the
#' (unweighted) version. The higher, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' precision(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' precision(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{recall}, \link{f1_score}}.
precision <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1),
    all(predicted == 0 | predicted == 1)
  )
  weighted_mean(actual[predicted == 1], w = w[predicted == 1], ...)
}

#' Recall
#'
#' Calculates weighted recall,
#' see \url{https://en.wikipedia.org/wiki/Precision_and_recall} for the (unweighted)
#' definition. The higher, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{weighted_mean()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' recall(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' recall(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{precision}, \link{f1_score}}.
recall <- function(actual, predicted, w = NULL, ...) {
  stopifnot(
    length(actual) == length(predicted),
    all(actual == 0 | actual == 1),
    all(predicted == 0 | predicted == 1)
  )
  weighted_mean(predicted[actual == 1], w = w[actual == 1], ...)
}

#' F1 Score
#'
#' Calculates weighted F1 score or F measure defined as the harmonic mean of precision
#' and recall, see \url{https://en.wikipedia.org/wiki/Precision_and_recall} for some
#' background. The higher, the better.
#'
#' @param actual Observed values (0 or 1).
#' @param predicted Predicted values (0 or 1).
#' @param w Optional case weights.
#' @param ... Further arguments passed to \code{precision()} and \code{recall()}.
#' @return A numeric vector of length one.
#' @export
#' @examples
#' f1_score(c(0, 0, 1, 1), c(0, 0, 1, 1))
#' f1_score(c(1, 0, 0, 1), c(0, 0, 1, 1), w = 1:4)
#' @seealso \code{\link{precision}, \link{recall}}.
f1_score <- function(actual, predicted, w = NULL, ...) {
  p <- precision(actual = actual, predicted = predicted, w = w, ...)
  r <- recall(actual = actual, predicted = predicted, w = w, ...)
  2 * (p * r) / (p + r)
}


