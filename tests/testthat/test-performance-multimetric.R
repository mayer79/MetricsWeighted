ir <- iris
fit_num <- lm(Sepal.Length ~ ., data = ir)
ir$fitted <- fit_num$fitted
y <- "Sepal.Length"
p <- "fitted"
w <- "Petal.Length"

test_that("performance works", {
  perf <- performance(ir, y, p)
  expect_equal(as.character(perf$metric), "rmse")
  expect_equal(perf$value, rmse(ir[[y]], ir[[p]]))
})

test_that("Weighted performance works", {
  perf <- performance(ir, y, p, w = w)
  expect_equal(perf$value, rmse(ir[[y]], ir[[p]], ir[[w]]))
})

test_that("performance works with non-default metric", {
  perf <- performance(ir, y, p, w = w, metrics = r_squared)
  expect_equal(as.character(perf$metric), "r_squared")
  expect_equal(perf$value, r_squared(ir[[y]], ir[[p]], ir[[w]]))
})

test_that("performance does not accept unnamed vector of metrics", {
  expect_error(
    performance(ir, y, p, w = w, metrics = c(r_squared, rmse))
  )
})

test_that("performance accepts named list of metrics", {
  metrics <- list(`R-squared` = r_squared, rmse = rmse)
  perf <- performance(ir, y, p, w = w, metrics = metrics)
  expect_equal(as.character(perf$metric), c("R-squared", "rmse"))
})

test_that("performance works with parametrized metric", {
  perf <- performance(
    ir, y, p, w = w, metrics = r_squared, deviance_function = deviance_gamma
  )
  expect_equal(perf$value, r_squared_gamma(ir[[y]], ir[[p]], ir[[w]]))
})

test_that("performance works with multi_metric", {
  multi <- multi_metric(fun = deviance_tweedie, tweedie_p = c(0, 1, 2))
  perf <- performance(ir, y, p, w = w, metrics = multi, key = "Tweedie p")
  expected <- c(
    deviance_normal(ir[[y]], ir[[p]], ir[[w]]),
    deviance_poisson(ir[[y]], ir[[p]], ir[[w]]),
    deviance_gamma(ir[[y]], ir[[p]], ir[[w]])
  )
  expect_equal(colnames(perf)[1L], "Tweedie p")
  expect_equal(perf$value, expected)
})
