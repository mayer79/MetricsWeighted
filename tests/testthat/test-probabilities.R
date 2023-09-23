test_that("Bernoulli deviance equals 2 logloss", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.9, 0.5)
  w <- 1:3
  expect_equal(2 * logLoss(y, pred, w),
               deviance_bernoulli(y, pred, w))
})

test_that("Gini coefficient is 2 AUC - 1", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.9, 0.5)
  w <- 1:3
  expect_equal(2 * AUC(y, pred, w) - 1,
               gini_coefficient(y, pred, w))
})

test_that("actual values are 0 or 1", {
  y <- c(0, 0, 1)
  y_bad <- c(0, 0, 0.9)
  pred <- c(0.1, 0.9, 0.5)
  w <- 1:3
  expect_silent(logLoss(y, pred, w))
  expect_silent(AUC(y, pred, w))
  expect_error(logLoss(y_bad, pred, w))
  expect_error(AUC(y_bad, pred, w))
})

test_that("predicted values are within (0, 1) for logLoss", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.9, 0.5)
  pred_good_1 <- c(0, 0.9, 0.5)
  pred_bad_1 <- c(1, 0.9, 0.5)
  pred_bad_2 <- c(0.1, 1.1, 0.5)
  w <- 1:3
  expect_silent(logLoss(y, pred, w))
  expect_silent(logLoss(y, pred_good_1, w))
  expect_equal(logLoss(y, pred_bad_1, w), Inf)
  expect_error(logLoss(y, pred_bad_2, w))
})

test_that("measures with weight 1 gives same as unweighted", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.9, 0.5)
  w <- rep(1, length(y))
  expect_equal(logLoss(y, pred, w), logLoss(y, pred))
  expect_equal(AUC(y, pred, w), AUC(y, pred))
})

test_that("measures with weight 2 gives same as weight 1, at least for unique pred", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.9, 0.5)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(logLoss(y, pred, w1), logLoss(y, pred, w2))
  expect_equal(AUC(y, pred, w1), AUC(y, pred, w2))
})

test_that("deviance with varying weights is different from unweighted", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.9, 0.5)
  w <- 1:length(y)
  expect_false(logLoss(y, pred, w) == logLoss(y, pred))
  expect_false(AUC(y, pred, w) == AUC(y, pred))
})

test_that("strict monotonicity gives AUC 1", {
  y <- c(0, 0, 1)
  pred <- c(0.1, 0.5, 0.9)
  w <- 1:length(y)
  expect_equal(AUC(y, pred, w), 1)
})

test_that("logLoss of one incorrect prediction of 0.5 equals log(2)", {
  y <- 0
  pred <- 0.5
  expect_equal(logLoss(y, pred), log(2))
  expect_equal(logLoss(1 - y, pred), log(2))
})

test_that("The 0/0 case is okay with logloss", {
  expect_equal(logLoss(0:1, 0:1), 0)
})

test_that("xlogy works (copied from {hstats})", {
  expect_equal(xlogy(1:3, 1:3), (1:3) * log(1:3))
  expect_equal(xlogy(0:2, 0:2), c(0, 0, 2 * log(2)))

  x <- cbind(c(0,   0, 4), c( 0, 1, 2))
  y <- cbind(c(100, 0, 0), c(10, 1, 2))
  expected <- cbind(c(0, 0, -Inf), c(0, 0, 2 * log(2)))
  expect_equal(xlogy(x, y), expected)
})
