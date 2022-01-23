test_that("prop_within works without weights", {
  y <- -2:2
  pred <- c(-1, -1, 0, 1, 10)
  expect_equal(prop_within(y, pred, tol = 1), 0.8)
  expect_equal(prop_within(y, pred, tol = 0.1), 0.6)
})

test_that("prop_within with weight 1 gives same as unweighted", {
  y <- -2:2
  pred <- c(-1, -1, 0, 1, 10)
  w <- rep(1, length(y))
  expect_equal(prop_within(y, pred, w), prop_within(y, pred))
})

test_that("prop_within with weight 2 gives same as weight 1", {
  y <- -2:2
  pred <- c(-1, -1, 0, 1, 10)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(prop_within(y, pred, w1), prop_within(y, pred, w2))
})

test_that("prop_within with varying weights is different from unweighted", {
  y <- -2:2
  pred <- c(-1, -1, 0, 1, 10)
  w <- 1:5
  expect_false(prop_within(y, pred, w) == prop_within(y, pred))
})
