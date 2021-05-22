context("Median absolute error")

test_that("medae works without weights", {
  y <- 1:3
  pred <- 3:1
  expect_equal(medae(y, pred), 2)
})

test_that("medae with weight 1 gives same as unweighted", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w <- rep(1, length(y))
  expect_equal(medae(y, pred, w), medae(y, pred))
})

test_that("medae with weight 2 gives same as weight 1", {
  y <- 1:5
  pred <- c(2, 1, 3, 2, 4)
  w1 <- rep(1, length(y))
  w2 <- rep(2, length(y))
  expect_equal(medae(y, pred, w1), medae(y, pred, w2))
})

test_that("medae with varying weights is different from unweighted", {
  y <- 1:5
  pred <- y * 1.2
  w <- 1:5
  expect_false(medae(y, pred, w) == medae(y, pred))
})
