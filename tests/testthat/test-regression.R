funs <- c(mse, rmse, mae, medae, mape)

test_that("mse is the same as rmse squared", {
  y <- 1:10
  pred <- 10:1
  w <- 1:10
  expect_equal(mse(y, pred, w), rmse(y, pred, w)^2)
})

test_that("mape does not allow 0 actuals", {
  y <- 0:2
  pred <- 2 * y
  expect_error(mape(y, pred))
})

test_that("weight 1 gives same as unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- rep(1, length(y))
  for (f in funs)
    expect_equal(f(y, pred, w), f(y, pred))
})

test_that("weight 2 gives same as weight 1", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  for (f in funs)
    expect_equal(f(y, pred, w1), f(y, pred, w2))
})

test_that("varying weights is different from unweighted", {
  y <- 1:15
  pred <- sqrt(2:16)
  w <- 1:15
  for (f in funs)
    expect_false(f(y, pred, w) == f(y, pred))
})



