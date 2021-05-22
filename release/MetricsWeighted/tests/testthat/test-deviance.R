context("deviance")

test_that("normal deviance equals MSE", {
  y <- c(0, 2)
  pred <- c(1, 1)
  expect_equal(mse(y, pred), deviance_normal(y, pred))
})

test_that("Poisson deviance only accepts positive predictions", {
  y <- 0:3
  pred <- y + 0.1
  pred_bad <- y
  expect_silent(deviance_poisson(y, pred))
  expect_error(deviance_poisson(y, pred_bad))
})

test_that("Poisson deviance only accepts non-negative actual values", {
  y <- 0:3
  pred <- y + 0.1
  y_bad <- y - 0.01
  expect_silent(deviance_poisson(y, pred))
  expect_error(deviance_poisson(y_bad, pred))
})

test_that("Gamma deviance only accepts positive predictions", {
  y <- 1:4
  pred <- y + 0.1
  pred_bad <- y - 1
  expect_silent(deviance_gamma(y, pred))
  expect_error(deviance_gamma(y, pred_bad))
})

test_that("Gamma deviance only accepts positive actual values", {
  y <- 1:4
  pred <- y + 0.1
  y_bad <- y - 1
  expect_silent(deviance_gamma(y, pred))
  expect_error(deviance_gamma(y_bad, pred))
})

test_that("Poisson deviance is 0 if actual = predicted", {
  y <- 1:2
  pred <- y
  expect_equal(deviance_poisson(y, pred), 0)
})

test_that("Poisson deviance is 2 * pred for actual 0", {
  y <- 0
  pred <- 0.5
  expect_equal(deviance_poisson(y, pred), 2 * pred)
})

test_that("Gamma deviance is 0 if actual = predicted", {
  y <- 1:2
  pred <- y
  expect_equal(deviance_gamma(y, pred), 0)
})

test_that("Gamma deviance is 2 * (1 - log(2)) if predicted = actual / 2", {
  y <- 2
  pred <- y / 2
  expect_equal(deviance_gamma(y, pred), 2 * (1 - log(2)))
})

test_that("normal deviance is Tweedie 0", {
  y <- 1:3
  pred <- y + 0.1
  w <- 1:3
  expect_equal(deviance_normal(y, pred, w),
               deviance_tweedie(y, pred, w, tweedie_p = 0))
})

test_that("Poisson deviance is Tweedie 1", {
  y <- 1:3
  pred <- y + 0.1
  w <- 1:3
  expect_equal(deviance_poisson(y, pred, w),
               deviance_tweedie(y, pred, w, tweedie_p = 1))
})

test_that("Gamma deviance is Tweedie 2", {
  y <- 1:3
  pred <- y + 0.1
  w <- 1:3
  expect_equal(deviance_gamma(y, pred, w),
               deviance_tweedie(y, pred, w, tweedie_p = 2))
})

test_that("Tweedie deviance 0.5 gives error", {
  y <- 1:3
  pred <- y + 0.1
  w <- 1:3
  expect_error(deviance_tweedie(y, pred, w, tweedie_p = 0.5))
})

test_that("deviance with weight 1 gives same as unweighted", {
  y <- c(0.1, 0.2, 1, 2)
  pred <- y + 0.1
  w <- rep(1, length(y))
  expect_equal(deviance_poisson(y, pred, w), deviance_poisson(y, pred))
  expect_equal(deviance_gamma(y, pred, w), deviance_gamma(y, pred))
  expect_equal(deviance_normal(y, pred, w), deviance_normal(y, pred))
  expect_equal(deviance_tweedie(y, pred, w, tweedie_p = 1.5),
               deviance_tweedie(y, pred, tweedie_p = 1.5))
})

test_that("deviance with weight 2 gives same as weight 1", {
  y <- c(0.1, 0.2, 1, 2)
  pred <- y + 0.1

  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(deviance_poisson(y, pred, w1),
               deviance_poisson(y, pred, w2))
  expect_equal(deviance_gamma(y, pred, w1),
               deviance_gamma(y, pred, w2))
  expect_equal(deviance_normal(y, pred, w1),
               deviance_normal(y, pred, w2))
  expect_equal(deviance_tweedie(y, pred, w = w1, tweedie_p = 1.5),
               deviance_tweedie(y, pred, w = w2, tweedie_p = 1.5))
})

test_that("deviance with varying weights is different from unweighted", {
  y <- c(0.1, 0.2, 1, 2)
  pred <- y + 0.1

  w <- 1:4
  expect_false(deviance_poisson(y, pred, w) == deviance_poisson(y, pred))
  expect_false(deviance_gamma(y, pred, w) == deviance_gamma(y, pred))
  expect_false(deviance_normal(y, pred, w) == deviance_normal(y, pred))
  expect_false(deviance_tweedie(y, pred, w, tweedie_p = 1.5) ==
               deviance_tweedie(y, pred, tweedie_p = 1.5))
})



