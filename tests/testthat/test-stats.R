test_that("unweighted stats match unweighted function", {
  x <- c(0, 1, 2, 1, 2, 3, 4, 5)
  y <- 1:length(x)
  expect_equal(mean(x), weighted_mean(x))
  expect_equal(median(x), weighted_median(x))
  expect_equal(quantile(x, probs = 0.2), weighted_quantile(x, probs = 0.2))
  expect_equal(var(x), weighted_var(x))
  expect_equal(cor(x, y), weighted_cor(x, y))

  # Now with missing values
  x <- c(0, 1, 2, 1, 2, 3, 4, NA)
  y <- c(NA, 2:length(x))
  expect_equal(mean(x, na.rm = TRUE), weighted_mean(x, na.rm = TRUE))
  expect_equal(median(x, na.rm = TRUE), weighted_median(x, na.rm = TRUE))
  expect_equal(
    quantile(x, probs = 0.2, na.rm = TRUE),
    weighted_quantile(x, probs = 0.2, na.rm = TRUE)
  )
  expect_equal(var(x, na.rm = TRUE), weighted_var(x, na.rm = TRUE))
  expect_equal(cor(x, y, use = "p"), weighted_cor(x, y, na.rm = TRUE))
})

test_that("weight 1 gives same as unweighted", {
  x <- c(0, 1, 2, 1, 2, 3, 4, 5)
  y <- 1:length(x)
  w <- rep(1, length(x))
  expect_equal(weighted_mean(x), weighted_mean(x, w = w))
  expect_equal(weighted_median(x), weighted_median(x, w = w))
  expect_equal(weighted_quantile(x, probs = 0.2),
               weighted_quantile(x, probs = 0.2, w = w))
  expect_equal(weighted_var(x), weighted_var(x, w = w))
  expect_equal(weighted_cor(x, y), weighted_cor(x, y, w = w))

  # Now with missing values
  x <- c(0, 1, 2, 1, 2, 3, 4, NA)
  y <- c(NA, 2:length(x))
  expect_equal(
    weighted_mean(x, na.rm = TRUE),
    weighted_mean(x, w = w, na.rm = TRUE)
  )
  expect_equal(
    weighted_median(x, na.rm = TRUE),
    weighted_median(x, w = w, na.rm = TRUE)
  )
  expect_equal(
    weighted_quantile(x, probs = 0.2, na.rm = TRUE),
    weighted_quantile(x, probs = 0.2, w = w, na.rm = TRUE)
  )
  expect_equal(
    weighted_var(x, na.rm = TRUE),
    weighted_var(x, w = w, na.rm = TRUE)
  )
  expect_equal(
    weighted_cor(x, y, na.rm = TRUE),
    weighted_cor(x, y, w = w, na.rm = TRUE)
  )
})

test_that("weight 1 gives same as weight 2", {
  x <- c(0, 1, 2, 1, 2, 3, 4, 5)
  y <- 1:length(x)
  w1 <- rep(1, length(x))
  w2 <- rep(2, length(x))
  expect_equal(weighted_mean(x, w = w2), weighted_mean(x, w = w1))
  expect_equal(weighted_median(x, w = w2), weighted_median(x, w = w1))
  expect_equal(weighted_quantile(x, w = w2, probs = 0.2),
               weighted_quantile(x, probs = 0.2, w = w1))
  expect_equal(weighted_var(x, w = w2), weighted_var(x, w = w1))
  expect_equal(weighted_cor(x, y, w = w2), weighted_cor(x, y, w = w1))

  # Now with missing values
  x <- c(0, 1, 2, 1, 2, 3, 4, NA)
  y <- c(NA, 2:length(x))
  expect_equal(
    weighted_mean(x, w = w2, na.rm = TRUE),
    weighted_mean(x, w = w1, na.rm = TRUE)
  )
  expect_equal(
    weighted_median(x, w = w2, na.rm = TRUE),
    weighted_median(x, w = w1, na.rm = TRUE)
  )
  expect_equal(
    weighted_quantile(x, w = w2, probs = 0.2, na.rm = TRUE),
    weighted_quantile(x, probs = 0.2, w = w1, na.rm = TRUE)
  )
  expect_equal(
    weighted_var(x, w = w2, na.rm = TRUE),
    weighted_var(x, w = w1, na.rm = TRUE)
  )
  expect_equal(
    weighted_cor(x, y, w = w2, na.rm = TRUE),
    weighted_cor(x, y, w = w1, na.rm = TRUE)
  )
})

test_that("non-constant weights have an effect", {
  x <- c(0, 1, 2, 1, 2, 3, 4, 5)
  y <- 1:length(x)
  w <- 1:length(x)
  expect_false(weighted_mean(x) == weighted_mean(x, w = w))
  expect_false(weighted_median(x) == weighted_median(x, w = w))
  expect_false(weighted_quantile(x, probs = 0.2) ==
               weighted_quantile(x, probs = 0.2, w = w))
  expect_false(weighted_var(x) == weighted_var(x, w = w))
  expect_false(weighted_cor(x, y) == weighted_cor(x, y, w = w))

  # Now with missing values
  x <- c(0, 1, 2, 1, 2, 3, 4, 5, NA)
  y <- c(NA, 2:length(x))
  w <- 1:length(x)
  expect_false(
    weighted_mean(x, na.rm = TRUE) == weighted_mean(x, w = w, na.rm = TRUE)
  )
  expect_false(
    weighted_median(x, na.rm = TRUE) == weighted_median(x, w = w, na.rm = TRUE)
  )
  expect_false(
    weighted_quantile(x, probs = 0.2, na.rm = TRUE) ==
    weighted_quantile(x, probs = 0.2, w = w, na.rm = TRUE)
  )
  expect_false(weighted_var(x, na.rm = TRUE) == weighted_var(x, w = w, na.rm = TRUE))
  expect_false(
    weighted_cor(x, y, na.rm = TRUE) == weighted_cor(x, y, w = w, na.rm = TRUE)
  )
})

