context("MAE")

test_that("mae works without weights", {
  y <- c(0, 2)
  pred <- c(1, 1)
  expect_equal(mae(y, pred), 1)
})

test_that("mae with weight 1 gives same as unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- rep(1, length(y))
  expect_equal(mae(y, pred, w), mae(y, pred))
})

test_that("mae with weight 2 gives same as weight 1", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(mae(y, pred, w1), mae(y, pred, w2))
})

test_that("mae with varying weights is different from unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- 1:5
  expect_false(mae(y, pred, w) == mae(y, pred))
})
