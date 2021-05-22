context("R-squared")

test_that("R-squared is 0 if predicted = mean", {
  y_binary <- c(0, 0, 1, 1)
  y_pos <- c(0.1, 0.2, 0.8, 0.9)
  pred <- rep(0.5, length(y_pos))
  expect_equal(r_squared(y_pos, pred), 0)
  expect_equal(r_squared_poisson(y_pos, pred), 0)
  expect_equal(r_squared_gamma(y_pos, pred), 0)
  expect_equal(r_squared_bernoulli(y_binary, pred), 0)
})

test_that("R-squared is 1 if predicted = actual (except Bernoulli)", {
  y <- c(0.1, 0.2, 0.8, 0.9)
  pred <- y
  expect_equal(r_squared(y, pred), 1)
  expect_equal(r_squared_poisson(y, pred), 1)
  expect_equal(r_squared_gamma(y, pred), 1)
  expect_error(r_squared_bernoulli(y, pred), 1)
})

test_that("R-squared with weight 1 gives same as unweighted", {
  y_binary <- c(0, 0, 1, 1)
  y_pos <- c(0.1, 0.2, 0.8, 0.9)
  pred <- c(0.2, 0.3, 0.7, 0.8)
  w <- rep(1, length(y_pos))
  expect_equal(r_squared(y_pos, pred), r_squared(y_pos, pred, w))
  expect_equal(r_squared_poisson(y_pos, pred),
               r_squared_poisson(y_pos, pred), w)
  expect_equal(r_squared_gamma(y_pos, pred),
               r_squared_gamma(y_pos, pred, w))
  expect_equal(r_squared_bernoulli(y_binary, pred),
               r_squared_bernoulli(y_binary, pred, w))
})

test_that("R-squared with weight 2 gives same as weight 1", {
  y_binary <- c(0, 0, 1, 1)
  y_pos <- c(0.1, 0.2, 0.8, 0.9)
  pred <- c(0.2, 0.3, 0.7, 0.8)
  w1 <- rep(1, length(y_pos))
  w2 <- rep(2, length(y_pos))
  expect_equal(r_squared(y_pos, pred), r_squared(y_pos, pred, w1))
  expect_equal(r_squared_poisson(y_pos, pred, w2),
               r_squared_poisson(y_pos, pred), w1)
  expect_equal(r_squared_gamma(y_pos, pred, w2),
               r_squared_gamma(y_pos, pred, w1))
  expect_equal(r_squared_bernoulli(y_binary, pred, w2),
               r_squared_bernoulli(y_binary, pred, w1))
})

test_that("R-squared with varying weights is different from unweighted", {
  y_binary <- c(0, 0, 1, 1)
  y_pos <- c(0.1, 0.2, 0.8, 0.9)
  pred <- c(0.2, 0.3, 0.7, 0.8)
  w <- 1:length(y_pos)
  expect_false(r_squared(y_pos, pred) == r_squared(y_pos, pred, w))
  expect_false(r_squared_poisson(y_pos, pred) ==
               r_squared_poisson(y_pos, pred, w))
  expect_false(r_squared_gamma(y_pos, pred) ==
               r_squared_gamma(y_pos, pred, w))
  expect_false(r_squared_bernoulli(y_binary, pred) ==
               r_squared_bernoulli(y_binary, pred, w))
})

test_that("if predictions match average of train, r-squared should be 0 rather than negative", {
  y_train <- 1:5
  y_test <- 2:6
  pred <- rep(mean(y_train), length(y_train))
  expect_equal(r_squared(y_test, pred, reference_mean = mean(y_train)), 0)
  expect_lt(r_squared(y_test, pred), 0)
})

test_that("out-of-sample application gives better score when training average is far away from test", {
  y_train <- 1:5
  y_test <- 2:6
  pred <- 1:5
  expect_gt(r_squared(y_test, pred, reference_mean = mean(y_train)),
            r_squared(y_test, pred))
})

