context("MAPE")

test_that("mape does not allow 0 actuals", {
  y <- 0:2
  pred <- 2 * y
  expect_error(mape(y, pred))
})


test_that("mape works without weights", {
  y <- 1:3
  pred <- 2 * y
  expect_equal(mape(y, pred), 100)
})

test_that("mape with weight 1 gives same as unweighted", {
  y <- 1:5
  pred <- 1.5 * y
  w <- rep(1, length(y))
  expect_equal(mape(y, pred, w), mape(y, pred))
})

test_that("mape with weight 2 gives same as weight 1", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(mape(y, pred, w1), mape(y, pred, w2))
})

test_that("mape with varying weights is different from unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- 1:5
  expect_false(mape(y, pred, w) == mape(y, pred))
})
