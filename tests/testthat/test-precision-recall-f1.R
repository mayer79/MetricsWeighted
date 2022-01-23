test_that("measures work without weights", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  tp <- sum(pred & y)
  fp <- sum(pred & !y)
  fn <- sum(!pred & y)

  prec <- precision(y, pred)
  rec <- recall(y, pred)
  expect_equal(prec, tp / (tp + fp))
  expect_equal(rec, tp / (tp + fn))
  expect_equal(f1_score(y, pred), 2 * prec * rec / (prec + rec))
})

test_that("measures with weight 1 gives same as unweighted", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  w <- rep(1, length(y))
  expect_equal(precision(y, pred, w), precision(y, pred))
  expect_equal(recall(y, pred, w), recall(y, pred))
  expect_equal(f1_score(y, pred, w), f1_score(y, pred))
})

test_that("measures with weight 2 gives same as weight 1", {
  y <- c(0, 0, 1)
  pred <- c(0, 1, 1)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(precision(y, pred, w = w1), precision(y, pred, w = w2))
  expect_equal(recall(y, pred, w = w1), recall(y, pred, w = w2))
  expect_equal(f1_score(y, pred, w = w1), f1_score(y, pred, w = w2))
})

test_that("measures with varying weights is different from unweighted", {
  y <- c(0, 1, 0, 1)
  pred <- c(0, 1, 1, 0)
  w <- 1:4
  expect_false(precision(y, pred, w) == precision(y, pred))
  expect_false(recall(y, pred, w) == recall(y, pred))
  expect_false(f1_score(y, pred, w) == f1_score(y, pred))
})

test_that("values outside 0, 1 gives error", {
  y <- c(0, 1, 0)
  y_bad <- c(0.1, 1, 0)
  pred <- c(0, 1, 1)
  pred_bad <- c(0, 1, 1.1)
  expect_error(precision(y, pred_bad))
  expect_error(precision(y_bad, pred))
  expect_error(recall(y, pred_bad))
  expect_error(recall(y_bad, pred))
  expect_error(f1_score(y, pred_bad))
  expect_error(f1_score(y_bad, pred))
})

