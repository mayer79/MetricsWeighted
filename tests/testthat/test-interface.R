context("Interface")

test_that("'actual' has same length as 'predicted'", {
  y <- c(0, 2)
  pred <- c(1, 1)
  bad_pred <- 1:3
  expect_silent(mse(y, pred))
  expect_error(mse(y, bad_pred))
})

test_that("'actual' has same length as 'w'", {
  y <- c(0, 2)
  pred <- c(1, 1)
  w <- 1:2
  bad_w <- 1:3
  expect_silent(weighted_mean(y - pred, w))
  expect_error(weighted_mean(y - bad_pred, bad_w))
})

test_that("Negative weights yield error", {
  y <- c(0, 2)
  pred <- c(1, 1)
  bad_w <- c(-1, 2)
  expect_error(weighted_mean(y - bad_pred, bad_w))
})

test_that("Not all weights should be 0", {
  y <- c(0, 2)
  pred <- c(1, 1)
  bad_w <- c(0.0, 0.0)
  expect_error(weighted_mean(y - bad_pred, bad_w))
})
