test_that("mse works without weights", {
  y <- c(0, 2)
  pred <- c(1, 1)
  expect_equal(mse(y, pred), 1)
})

test_that("mse is the same as rmse squared", {
  y <- 1:10
  pred <- 10:1
  w <- 1:10
  expect_equal(mse(y, pred, w), rmse(y, pred, w)^2)
})


test_that("mse with weight 1 gives same as unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- rep(1, length(y))
  expect_equal(mse(y, pred, w), mse(y, pred))
})

test_that("mse with weight 2 gives same as weight 1", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(mse(y, pred, w1), mse(y, pred, w2))
})

test_that("mse with varying weights is different from unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- 1:5
  expect_false(mse(y, pred, w) == mse(y, pred))
})



